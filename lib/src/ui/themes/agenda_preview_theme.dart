import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_customizable_calendar/src/domain/models/calendar_event.dart';

/// Configuration for the Agenda Preview component.
///
/// The Agenda Preview shows a list of events for the selected date(s),
/// typically displayed below a Month view calendar. Inspired by Syncfusion's
/// agenda view implementation.
class AgendaPreviewTheme extends Equatable {
  /// Creates a new agenda preview theme.
  const AgendaPreviewTheme({
    this.enabled = false,
    this.heightRatio = 0.3,
    this.minHeight = 100,
    this.maxHeight,
    this.backgroundColor,
    this.dividerColor,
    this.dividerThickness = 1,
    this.showDivider = true,
    this.padding = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 4),
    this.emptyText = 'No events',
    this.emptyTextStyle,
    this.dateHeaderStyle,
    this.showDateHeader = true,
    this.dateHeaderFormatter,
    this.itemBuilder,
    this.scrollPhysics,
    this.separatorBuilder,
  });

  /// Whether the agenda preview is enabled.
  /// Default: false
  final bool enabled;

  /// The ratio of height the agenda preview takes relative to total height.
  /// Value between 0.0 and 1.0, where 0.3 means 30% of total height.
  /// Default: 0.3
  final double heightRatio;

  /// Minimum height for the agenda preview in pixels.
  /// Default: 100.0
  final double minHeight;

  /// Maximum height for the agenda preview in pixels.
  /// If null, uses [heightRatio] calculation only.
  final double? maxHeight;

  /// Background color for the agenda preview container.
  /// If null, uses theme surface color.
  final Color? backgroundColor;

  /// Color of the divider between calendar and agenda preview.
  /// If null, uses theme divider color.
  final Color? dividerColor;

  /// Thickness of the divider.
  /// Default: 1.0
  final double dividerThickness;

  /// Whether to show a divider between calendar and agenda.
  /// Default: true
  final bool showDivider;

  /// Padding around the agenda preview content.
  /// Default: EdgeInsets.all(8.0)
  final EdgeInsets padding;

  /// Padding around each event item.
  /// Default: EdgeInsets.symmetric(vertical: 4.0)
  final EdgeInsets itemPadding;

  /// Text shown when no events for selected date.
  /// Default: 'No events'
  final String emptyText;

  /// Text style for empty message.
  /// If null, uses theme caption style.
  final TextStyle? emptyTextStyle;

  /// Text style for date header.
  /// If null, uses theme subtitle style.
  final TextStyle? dateHeaderStyle;

  /// Whether to show a date header above the events list.
  /// Default: true
  final bool showDateHeader;

  /// Custom formatter for the date header.
  /// If null, uses default date format (e.g., "Monday, December 6").
  final String Function(DateTime)? dateHeaderFormatter;

  /// Custom builder for event items in the agenda.
  /// If null, uses default event rendering.
  final Widget Function(CalendarEvent event)? itemBuilder;

  /// Scroll physics for the agenda list.
  /// If null, uses default bouncing physics.
  final ScrollPhysics? scrollPhysics;

  /// Custom separator between event items.
  /// If null, uses default spacing from [itemPadding].
  final Widget Function(int index)? separatorBuilder;

  /// Calculates the actual height for the agenda preview.
  double calculateHeight(double totalHeight) {
    final calculated = totalHeight * heightRatio;
    var result = calculated.clamp(minHeight, totalHeight);
    if (maxHeight != null) {
      result = result.clamp(minHeight, maxHeight!);
    }
    return result;
  }

  /// Calculates the remaining height for the calendar.
  double calculateCalendarHeight(double totalHeight) {
    final agendaHeight = calculateHeight(totalHeight);
    final dividerHeight = showDivider ? dividerThickness : 0;
    return totalHeight - agendaHeight - dividerHeight;
  }

  @override
  List<Object?> get props => [
        enabled,
        heightRatio,
        minHeight,
        maxHeight,
        backgroundColor,
        dividerColor,
        dividerThickness,
        showDivider,
        padding,
        itemPadding,
        emptyText,
        emptyTextStyle,
        dateHeaderStyle,
        showDateHeader,
        scrollPhysics,
      ];

  /// Creates a copy of this theme with the given fields replaced.
  AgendaPreviewTheme copyWith({
    bool? enabled,
    double? heightRatio,
    double? minHeight,
    double? maxHeight,
    Color? backgroundColor,
    Color? dividerColor,
    double? dividerThickness,
    bool? showDivider,
    EdgeInsets? padding,
    EdgeInsets? itemPadding,
    String? emptyText,
    TextStyle? emptyTextStyle,
    TextStyle? dateHeaderStyle,
    bool? showDateHeader,
    String Function(DateTime)? dateHeaderFormatter,
    Widget Function(CalendarEvent)? itemBuilder,
    ScrollPhysics? scrollPhysics,
    Widget Function(int)? separatorBuilder,
  }) {
    return AgendaPreviewTheme(
      enabled: enabled ?? this.enabled,
      heightRatio: heightRatio ?? this.heightRatio,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      dividerColor: dividerColor ?? this.dividerColor,
      dividerThickness: dividerThickness ?? this.dividerThickness,
      showDivider: showDivider ?? this.showDivider,
      padding: padding ?? this.padding,
      itemPadding: itemPadding ?? this.itemPadding,
      emptyText: emptyText ?? this.emptyText,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      dateHeaderStyle: dateHeaderStyle ?? this.dateHeaderStyle,
      showDateHeader: showDateHeader ?? this.showDateHeader,
      dateHeaderFormatter: dateHeaderFormatter ?? this.dateHeaderFormatter,
      itemBuilder: itemBuilder ?? this.itemBuilder,
      scrollPhysics: scrollPhysics ?? this.scrollPhysics,
      separatorBuilder: separatorBuilder ?? this.separatorBuilder,
    );
  }
}
