import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_customizable_calendar/src/domain/models/calendar_event.dart';
import 'package:flutter_customizable_calendar/src/ui/themes/agenda_preview_theme.dart';
import 'package:intl/intl.dart';

/// A lightweight embedded day timeline that shows events positioned by time.
///
/// This is a simplified version of the full DaysView/WeekView timeline,
/// designed to be embedded in drawers or panels without navigation controls.
class EmbeddedDayTimeline<T extends CalendarEvent> extends StatelessWidget {
  /// Creates an embedded day timeline.
  const EmbeddedDayTimeline({
    required this.date,
    required this.events,
    this.theme = const AgendaPreviewTheme(),
    this.onEventTap,
    this.getEventColor,
    this.getEventTitle,
    this.startHour = 0,
    this.endHour = 24,
    this.hourHeight = 60.0,
    this.timeScaleWidth = 48.0,
    this.showCurrentTimeIndicator = true,
    super.key,
  });

  /// The date to display events for.
  final DateTime date;

  /// Events to display on the timeline.
  final List<T> events;

  /// Theme configuration.
  final AgendaPreviewTheme theme;

  /// Callback when an event is tapped.
  final void Function(T event)? onEventTap;

  /// Function to get the color for an event.
  final Color Function(T event)? getEventColor;

  /// Function to get the title for an event.
  final String Function(T event)? getEventTitle;

  /// First hour to display (0-23).
  final int startHour;

  /// Last hour to display (1-24).
  final int endHour;

  /// Height of each hour slot in pixels.
  final double hourHeight;

  /// Width of the time scale column.
  final double timeScaleWidth;

  /// Whether to show the current time indicator line.
  final bool showCurrentTimeIndicator;

  @override
  Widget build(BuildContext context) {
    final totalHeight = (endHour - startHour) * hourHeight;
    final dayStart = DateTime(date.year, date.month, date.day, startHour);

    // Filter events for this day
    final dayEvents = events.where((event) {
      final eventDate = DateTime(
        event.start.year,
        event.start.month,
        event.start.day,
      );
      final targetDate = DateTime(date.year, date.month, date.day);
      return eventDate.isAtSameMomentAs(targetDate) ||
          (event.start.isBefore(targetDate.add(const Duration(days: 1))) &&
              event.end.isAfter(targetDate));
    }).toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    return SingleChildScrollView(
      physics: theme.scrollPhysics ?? const BouncingScrollPhysics(),
      child: SizedBox(
        height: totalHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time scale
            _TimeScaleColumn(
              startHour: startHour,
              endHour: endHour,
              hourHeight: hourHeight,
              width: timeScaleWidth,
              textStyle: theme.eventTimeStyle,
            ),

            // Events area
            Expanded(
              child: Stack(
                children: [
                  // Hour grid lines
                  _HourGridLines(
                    startHour: startHour,
                    endHour: endHour,
                    hourHeight: hourHeight,
                  ),

                  // Current time indicator
                  if (showCurrentTimeIndicator &&
                      _isToday(date))
                    _CurrentTimeIndicator(
                      startHour: startHour,
                      hourHeight: hourHeight,
                    ),

                  // Events
                  ..._buildEventWidgets(
                    context,
                    dayEvents,
                    dayStart,
                    totalHeight,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  List<Widget> _buildEventWidgets(
    BuildContext context,
    List<T> dayEvents,
    DateTime dayStart,
    double totalHeight,
  ) {
    if (dayEvents.isEmpty) return [];

    // Calculate layouts for overlapping events
    final layouts = _calculateEventLayouts(dayEvents, dayStart, totalHeight);

    return layouts.entries.map((entry) {
      final event = entry.key;
      final rect = entry.value;
      final eventColor = getEventColor?.call(event) ?? event.color;
      final eventTitle = _getEventTitle(event);

      return Positioned(
        left: rect.left,
        top: rect.top,
        width: rect.width,
        height: rect.height,
        child: _TimelineEventItem(
          event: event,
          eventColor: eventColor,
          eventTitle: eventTitle,
          theme: theme,
          onTap: onEventTap != null ? () => onEventTap!(event) : null,
        ),
      );
    }).toList();
  }

  Map<T, Rect> _calculateEventLayouts(
    List<T> events,
    DateTime dayStart,
    double totalHeight,
  ) {
    final minuteExtent = totalHeight / ((endHour - startHour) * 60);
    final layoutsMap = <T, Rect>{};
    var startIndex = 0;

    while (startIndex < events.length) {
      var clusterEndDate = events[startIndex].end;
      var finalIndex = startIndex + 1;
      final rows = <List<T>>[
        [events[startIndex]],
      ];

      // Clustering overlapping events
      while (finalIndex < events.length &&
          events[finalIndex].start.isBefore(clusterEndDate)) {
        final currentEvent = events[finalIndex];

        if (currentEvent.end.isAfter(clusterEndDate)) {
          clusterEndDate = currentEvent.end;
        }

        if (currentEvent.start.isAfter(events[finalIndex - 1].start)) {
          rows.add([]);
        }

        rows.last.add(currentEvent);
        finalIndex++;
      }

      const dxStep = 8.0;
      const padding = 4.0;

      // Calculate widths and positions
      for (var index = 0; index < rows.length; index++) {
        final currentRow = rows[index];
        var dxOffset = padding;

        if (index > 0) {
          final currentDate = currentRow.first.start;
          var prev = index - 1;

          if (currentDate.difference(rows[prev].last.start) <
              rows[prev].last.duration) {
            dxOffset = layoutsMap[rows[prev].last]!.left + dxStep;
          } else {
            while (prev > 0 &&
                currentDate.difference(rows[prev].first.start) >=
                    rows[prev].first.duration) {
              prev--;
            }
            dxOffset = layoutsMap[rows[prev].first]!.left + dxStep;
          }
        }

        // Assume a reasonable width - this will be constrained by parent
        const availableWidth = 280.0; // Will be adjusted by Positioned
        final columnWidth =
            (availableWidth - dxOffset - padding) / currentRow.length;

        for (final event in currentRow) {
          final startMinutes = event.start.difference(dayStart).inMinutes;
          final durationMinutes = event.duration.inMinutes;

          layoutsMap[event] = Rect.fromLTWH(
            dxOffset,
            max(0, startMinutes * minuteExtent),
            columnWidth,
            max(durationMinutes, 15) * minuteExtent, // Min 15 min height
          );
          dxOffset += columnWidth;
        }
      }

      startIndex = finalIndex;
    }

    return layoutsMap;
  }

  String _getEventTitle(T event) {
    if (getEventTitle != null) {
      return getEventTitle!(event);
    }

    if (event is SimpleEvent) {
      return event.title;
    }
    if (event is SimpleAllDayEvent) {
      return event.title;
    }

    return 'Event';
  }
}

/// Renders the time scale column with hour labels.
class _TimeScaleColumn extends StatelessWidget {
  const _TimeScaleColumn({
    required this.startHour,
    required this.endHour,
    required this.hourHeight,
    required this.width,
    this.textStyle,
  });

  final int startHour;
  final int endHour;
  final double hourHeight;
  final double width;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      child: Stack(
        children: List.generate(endHour - startHour, (index) {
          final hour = startHour + index;
          final time = DateTime(2024, 1, 1, hour);

          return Positioned(
            top: index * hourHeight - 6, // Center on hour line
            left: 0,
            right: 4,
            child: Text(
              DateFormat.j().format(time), // e.g., "9 AM"
              style: textStyle ??
                  theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                    fontSize: 11,
                  ),
              textAlign: TextAlign.right,
            ),
          );
        }),
      ),
    );
  }
}

/// Renders horizontal grid lines for each hour.
class _HourGridLines extends StatelessWidget {
  const _HourGridLines({
    required this.startHour,
    required this.endHour,
    required this.hourHeight,
  });

  final int startHour;
  final int endHour;
  final double hourHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomPaint(
      size: Size.infinite,
      painter: _GridLinesPainter(
        startHour: startHour,
        endHour: endHour,
        hourHeight: hourHeight,
        lineColor: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
      ),
    );
  }
}

class _GridLinesPainter extends CustomPainter {
  _GridLinesPainter({
    required this.startHour,
    required this.endHour,
    required this.hourHeight,
    required this.lineColor,
  });

  final int startHour;
  final int endHour;
  final double hourHeight;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 0.5;

    for (var i = 0; i <= endHour - startHour; i++) {
      final y = i * hourHeight;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridLinesPainter oldDelegate) {
    return hourHeight != oldDelegate.hourHeight ||
        lineColor != oldDelegate.lineColor;
  }
}

/// Shows the current time as a horizontal line.
class _CurrentTimeIndicator extends StatefulWidget {
  const _CurrentTimeIndicator({
    required this.startHour,
    required this.hourHeight,
  });

  final int startHour;
  final double hourHeight;

  @override
  State<_CurrentTimeIndicator> createState() => _CurrentTimeIndicatorState();
}

class _CurrentTimeIndicatorState extends State<_CurrentTimeIndicator> {
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    // Update every minute
    Future.delayed(
      Duration(seconds: 60 - _currentTime.second),
      _scheduleUpdate,
    );
  }

  void _scheduleUpdate() {
    if (!mounted) return;
    setState(() {
      _currentTime = DateTime.now();
    });
    Future.delayed(const Duration(minutes: 1), _scheduleUpdate);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final minutesSinceStart =
        (_currentTime.hour - widget.startHour) * 60 + _currentTime.minute;
    final top = minutesSinceStart * (widget.hourHeight / 60);

    if (top < 0) return const SizedBox.shrink();

    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: theme.colorScheme.error,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Container(
              height: 1.5,
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}

/// An event item widget for the timeline with a colored left bar.
class _TimelineEventItem<T extends CalendarEvent> extends StatelessWidget {
  const _TimelineEventItem({
    required this.event,
    required this.eventColor,
    required this.eventTitle,
    required this.theme,
    this.onTap,
  });

  final T event;
  final Color eventColor;
  final String eventTitle;
  final AgendaPreviewTheme theme;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(theme.eventItemBorderRadius),
          child: Container(
            decoration: BoxDecoration(
              color: theme.eventItemBackgroundColor ??
                  eventColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(theme.eventItemBorderRadius),
              border: Border(
                left: BorderSide(
                  color: eventColor,
                  width: theme.eventColorBarWidth,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  eventTitle,
                  style: theme.eventTitleStyle ??
                      themeData.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onSurface,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (theme.showEventTime && event.duration.inMinutes >= 30)
                  Text(
                    _formatEventTime(),
                    style: theme.eventTimeStyle ??
                        themeData.textTheme.labelSmall?.copyWith(
                          color: themeData.colorScheme.outline,
                        ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatEventTime() {
    if (theme.eventTimeFormatter != null) {
      return theme.eventTimeFormatter!(event);
    }

    final startTime = DateFormat.jm().format(event.start);
    final endTime = DateFormat.jm().format(event.end);
    return '$startTime - $endTime';
  }
}
