import 'package:flutter/material.dart';
import 'package:flutter_customizable_calendar/src/domain/models/calendar_event.dart';
import 'package:flutter_customizable_calendar/src/ui/themes/agenda_preview_theme.dart';
import 'package:intl/intl.dart';

/// A slide-out drawer for displaying events for a selected date.
///
/// The drawer slides from a configurable edge of the screen and shows
/// events in a Day view style layout with colored bars.
class AgendaPreviewDrawer extends StatefulWidget {
  /// Creates an agenda preview drawer.
  const AgendaPreviewDrawer({
    required this.isVisible,
    required this.selectedDate,
    required this.events,
    this.theme = const AgendaPreviewTheme(),
    this.onClose,
    this.onEventTap,
    this.getEventColor,
    this.getEventTitle,
    super.key,
  });

  /// Whether the drawer is visible.
  final bool isVisible;

  /// The selected date to show events for.
  final DateTime selectedDate;

  /// Events to display in the drawer.
  final List<CalendarEvent> events;

  /// Theme configuration for the drawer.
  final AgendaPreviewTheme theme;

  /// Callback when the drawer should close.
  final VoidCallback? onClose;

  /// Callback when an event is tapped.
  final void Function(CalendarEvent event)? onEventTap;

  /// Function to get the color for an event.
  /// If null, uses the event's color property.
  final Color Function(CalendarEvent event)? getEventColor;

  /// Function to get the title for an event.
  /// If null, uses 'Event' as default or SimpleEvent.title if available.
  final String Function(CalendarEvent event)? getEventTitle;

  @override
  State<AgendaPreviewDrawer> createState() => _AgendaPreviewDrawerState();
}

class _AgendaPreviewDrawerState extends State<AgendaPreviewDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  AgendaDrawerEdge? _currentEdge;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.theme.animationDuration,
      vsync: this,
    );

    if (widget.isVisible) {
      _controller.value = 1.0;
    }
  }

  void _updateSlideAnimation(AgendaDrawerEdge edge) {
    if (_currentEdge == edge) return;
    _currentEdge = edge;

    _slideAnimation = Tween<Offset>(
      begin: widget.theme.getSlideBeginOffset(edge),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.theme.animationCurve,
      ),
    );
  }

  @override
  void didUpdateWidget(AgendaPreviewDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update animation duration if changed
    if (widget.theme.animationDuration != oldWidget.theme.animationDuration) {
      _controller.duration = widget.theme.animationDuration;
    }

    // Handle visibility changes
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final effectiveEdge = widget.theme.getEffectiveEdge(screenWidth);

    // Update slide animation for current edge
    _updateSlideAnimation(effectiveEdge);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (_controller.isDismissed) {
          return const SizedBox.shrink();
        }

        return Stack(
          children: [
            // Semi-transparent overlay
            if (widget.theme.showOverlay && _controller.value > 0)
              Positioned.fill(
                child: GestureDetector(
                  onTap:
                      widget.theme.dismissOnOutsideTap ? widget.onClose : null,
                  child: Container(
                    color: (widget.theme.overlayColor ?? Colors.black)
                        .withValues(
                      alpha: widget.theme.overlayOpacity * _controller.value,
                    ),
                  ),
                ),
              ),

            // Slide-out drawer
            _buildDrawerPositioned(effectiveEdge, screenWidth, screenHeight),
          ],
        );
      },
    );
  }

  Widget _buildDrawerPositioned(
    AgendaDrawerEdge edge,
    double screenWidth,
    double screenHeight,
  ) {
    final theme = Theme.of(context);
    final drawerTheme = widget.theme;

    final drawer = SlideTransition(
      position: _slideAnimation,
      child: _buildDrawerContent(theme, drawerTheme, edge, screenHeight),
    );

    switch (edge) {
      case AgendaDrawerEdge.left:
        return Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          child: drawer,
        );
      case AgendaDrawerEdge.right:
        return Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: drawer,
        );
      case AgendaDrawerEdge.bottom:
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: drawer,
        );
    }
  }

  Widget _buildDrawerContent(
    ThemeData theme,
    AgendaPreviewTheme drawerTheme,
    AgendaDrawerEdge edge,
    double screenHeight,
  ) {
    final isBottomSheet = edge == AgendaDrawerEdge.bottom;
    final height = isBottomSheet
        ? screenHeight * drawerTheme.bottomSheetHeight
        : null;

    return Container(
      width: isBottomSheet ? null : drawerTheme.width,
      height: height,
      decoration: BoxDecoration(
        color: drawerTheme.backgroundColor ?? theme.colorScheme.surface,
        borderRadius: isBottomSheet
            ? const BorderRadius.vertical(top: Radius.circular(16))
            : null,
        boxShadow: [
          BoxShadow(
            color: drawerTheme.drawerShadowColor ??
                Colors.black.withValues(alpha: 0.2),
            blurRadius: drawerTheme.drawerElevation,
            offset: drawerTheme.getShadowOffset(edge),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag handle for bottom sheet
          if (isBottomSheet) _buildDragHandle(theme),

          // Header
          if (drawerTheme.showHeader)
            _buildHeader(theme, drawerTheme, isBottomSheet),

          // Event list
          Expanded(
            child: _buildEventList(theme, drawerTheme),
          ),
        ],
      ),
    );
  }

  Widget _buildDragHandle(ThemeData theme) {
    return Container(
      width: 32,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(
    ThemeData theme,
    AgendaPreviewTheme drawerTheme,
    bool isBottomSheet,
  ) {
    final dateText =
        drawerTheme.dateHeaderFormatter?.call(widget.selectedDate) ??
            DateFormat('EEEE, MMMM d').format(widget.selectedDate);

    return Container(
      padding: drawerTheme.headerPadding,
      decoration: BoxDecoration(
        color: drawerTheme.headerBackgroundColor ??
            theme.colorScheme.surfaceContainerLow,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              dateText,
              style: drawerTheme.dateHeaderStyle ??
                  theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          if (drawerTheme.showCloseButton)
            IconButton(
              icon: Icon(drawerTheme.closeButtonIcon),
              onPressed: widget.onClose,
              tooltip: 'Close',
            ),
        ],
      ),
    );
  }

  Widget _buildEventList(ThemeData theme, AgendaPreviewTheme drawerTheme) {
    if (widget.events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 48,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              drawerTheme.emptyText,
              style: drawerTheme.emptyTextStyle ??
                  theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
            ),
          ],
        ),
      );
    }

    // Sort events by start time
    final sortedEvents = List<CalendarEvent>.from(widget.events)
      ..sort((a, b) => a.start.compareTo(b.start));

    return ListView.builder(
      padding: drawerTheme.padding,
      physics: drawerTheme.scrollPhysics ?? const BouncingScrollPhysics(),
      itemCount: sortedEvents.length,
      itemBuilder: (context, index) {
        final event = sortedEvents[index];
        final eventColor =
            widget.getEventColor?.call(event) ?? event.color;

        // Use custom builder if provided
        if (drawerTheme.eventItemBuilder != null) {
          return Padding(
            padding: drawerTheme.eventItemMargin,
            child: drawerTheme.eventItemBuilder!(event, eventColor),
          );
        }

        return _AgendaPreviewEventItem(
          event: event,
          eventColor: eventColor,
          eventTitle: _getEventTitle(event),
          theme: drawerTheme,
          onTap: widget.onEventTap != null
              ? () => widget.onEventTap!(event)
              : null,
        );
      },
    );
  }

  String _getEventTitle(CalendarEvent event) {
    // Use custom getter if provided
    if (widget.getEventTitle != null) {
      return widget.getEventTitle!(event);
    }

    // Check for SimpleEvent or SimpleAllDayEvent which have title
    if (event is SimpleEvent) {
      return event.title;
    }
    if (event is SimpleAllDayEvent) {
      return event.title;
    }

    // Default fallback
    return 'Event';
  }
}

/// An event item widget for the agenda preview with a colored left bar.
class _AgendaPreviewEventItem extends StatelessWidget {
  const _AgendaPreviewEventItem({
    required this.event,
    required this.eventColor,
    required this.eventTitle,
    required this.theme,
    this.onTap,
  });

  final CalendarEvent event;
  final Color eventColor;
  final String eventTitle;
  final AgendaPreviewTheme theme;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Padding(
      padding: theme.eventItemMargin,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(theme.eventItemBorderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: theme.eventItemBackgroundColor ??
                themeData.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(theme.eventItemBorderRadius),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Colored bar on the left
                Container(
                  width: theme.eventColorBarWidth,
                  decoration: BoxDecoration(
                    color: eventColor,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(theme.eventColorBarBorderRadius),
                      bottomLeft:
                          Radius.circular(theme.eventColorBarBorderRadius),
                    ),
                  ),
                ),

                // Event content
                Expanded(
                  child: Padding(
                    padding: theme.eventItemPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Event title
                        Text(
                          eventTitle,
                          style: theme.eventTitleStyle ??
                              themeData.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // Event time
                        if (theme.showEventTime) ...[
                          const SizedBox(height: 4),
                          Text(
                            _formatEventTime(),
                            style: theme.eventTimeStyle ??
                                themeData.textTheme.bodySmall?.copyWith(
                                  color: themeData.colorScheme.outline,
                                ),
                          ),
                        ],
                      ],
                    ),
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

    final startTime = DateFormat.Hm().format(event.start);
    final duration = event.duration;

    if (duration.inMinutes < 60) {
      return '$startTime - ${duration.inMinutes} min';
    } else if (duration.inMinutes == 60) {
      return '$startTime - 1 hour';
    } else {
      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;
      if (minutes == 0) {
        return '$startTime - $hours ${hours == 1 ? "hour" : "hours"}';
      }
      return '$startTime - ${hours}h ${minutes}min';
    }
  }
}

/// A standalone event item widget that can be used outside the drawer.
///
/// This is the same widget used inside [AgendaPreviewDrawer] but exposed
/// for custom implementations.
class AgendaPreviewEventItem extends StatelessWidget {
  /// Creates an agenda preview event item.
  const AgendaPreviewEventItem({
    required this.event,
    required this.eventColor,
    required this.eventTitle,
    this.theme = const AgendaPreviewTheme(),
    this.onTap,
    super.key,
  });

  /// The event to display.
  final CalendarEvent event;

  /// The color for the left bar.
  final Color eventColor;

  /// The title to display.
  final String eventTitle;

  /// Theme configuration.
  final AgendaPreviewTheme theme;

  /// Callback when the item is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _AgendaPreviewEventItem(
      event: event,
      eventColor: eventColor,
      eventTitle: eventTitle,
      theme: theme,
      onTap: onTap,
    );
  }
}

/// A controller for managing the agenda preview drawer state.
class AgendaPreviewController extends ChangeNotifier {
  DateTime? _selectedDate;
  bool _isVisible = false;

  /// The currently selected date.
  DateTime? get selectedDate => _selectedDate;

  /// Whether the drawer is visible.
  bool get isVisible => _isVisible;

  /// Shows the drawer with the given date.
  void show(DateTime date) {
    _selectedDate = date;
    _isVisible = true;
    notifyListeners();
  }

  /// Hides the drawer.
  void hide() {
    _isVisible = false;
    notifyListeners();
  }

  /// Toggles the drawer visibility.
  void toggle(DateTime date) {
    if (_isVisible && _selectedDate == date) {
      hide();
    } else {
      show(date);
    }
  }

  /// Updates the selected date without changing visibility.
  void updateDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
