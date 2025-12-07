import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_customizable_calendar/src/domain/models/calendar_event.dart';

/// Context passed to day builder callbacks.
///
/// Encapsulates all information needed to render a custom day cell.
class DayBuilderContext {
  /// Creates a new day builder context.
  const DayBuilderContext({
    required this.date,
    required this.events,
    required this.isSelected,
    this.isToday = false,
    this.isWeekend = false,
    this.isOutsideMonth = false,
  });

  /// The date being rendered.
  final DateTime date;

  /// Events on this date.
  final List<CalendarEvent> events;

  /// Whether this day is currently selected.
  final bool isSelected;

  /// Whether this day is today.
  final bool isToday;

  /// Whether this day is a weekend (Saturday or Sunday).
  final bool isWeekend;

  /// Whether this day is outside the current month.
  final bool isOutsideMonth;
}

/// Typedef for day builder callbacks using the context class.
typedef DayBuilder = Widget Function(DayBuilderContext context);

/// Wrapper for the DaysList view customization parameters
class MonthDayTheme extends Equatable {
  /// Customize the DaysList with the parameters
  const MonthDayTheme({
    this.dayColor,
    this.currentDayColor,
    this.dayNumberBackgroundColor = Colors.transparent,
    this.selectedDayNumberBackgroundColor = Colors.blue,
    this.spacingColor,
    this.dayNumberTextStyle = const TextStyle(),
    this.selectedDayNumberTextStyle = const TextStyle(),
    this.crossAxisSpacing = 1.0,
    this.mainAxisSpacing = 1.0,
    this.dayNumberPadding,
    this.dayNumberMargin,
    this.dayNumberHeight,
    this.weekendDayColor,
    this.weekendDayNumberTextStyle,
    this.outsideMonthDayColor,
    this.outsideMonthDayTextStyle,
    this.outsideMonthOpacity = 0.5,
    this.selectedDayBorderColor,
    this.selectedDayBorderWidth = 2.0,
    this.dayBuilder,
    this.showTodayIndicator = true,
    this.todayIndicatorColor,
    this.todayIndicatorSize = 6.0,
    this.dayDecoration,
    this.selectedDayDecoration,
    this.currentDayDecoration,
    this.weekendDayDecoration,
    // Hover state
    this.hoverDayBorderColor,
    this.hoverDayBorderWidth = 2.0,
    this.hoverDayDecoration,
    // Selected day cell background
    this.selectedDayBackgroundColor,
    // Cell margin
    this.dayCellTopMargin = 0.0,
  });

  /// The color of day card
  final Color? dayColor;

  /// The color of current day card
  final Color? currentDayColor;

  /// The background color of day number
  final Color dayNumberBackgroundColor;

  /// The background color of selected day number
  final Color selectedDayNumberBackgroundColor;

  /// The color of spacing between day views
  final Color? spacingColor;

  /// The TextStyle of day number
  final TextStyle dayNumberTextStyle;

  /// The TextStyle of selected day number
  final TextStyle selectedDayNumberTextStyle;

  /// The cross axis spacing of spacing between day views
  final double crossAxisSpacing;

  /// The main axis spacing of spacing between day views
  final double mainAxisSpacing;

  /// The height of day number container
  final double? dayNumberHeight;

  /// The margin of day number container
  final EdgeInsets? dayNumberMargin;

  /// The padding of day number container
  final EdgeInsets? dayNumberPadding;

  /// Background color for weekend days (Saturday and Sunday).
  final Color? weekendDayColor;

  /// Text style for weekend day numbers.
  final TextStyle? weekendDayNumberTextStyle;

  /// Background color for days outside the current month.
  final Color? outsideMonthDayColor;

  /// Text style for days outside the current month.
  final TextStyle? outsideMonthDayTextStyle;

  /// Opacity for days outside the current month.
  /// Default: 0.5
  final double outsideMonthOpacity;

  /// Border color for selected day.
  final Color? selectedDayBorderColor;

  /// Border width for selected day.
  /// Default: 2.0
  final double selectedDayBorderWidth;

  /// Custom builder for day cells.
  /// Allows complete customization of day rendering.
  /// Use [DayBuilderContext] to access date, events, selection state, etc.
  final DayBuilder? dayBuilder;

  /// Whether to show a dot indicator for today.
  /// Default: true
  final bool showTodayIndicator;

  /// Color for today's indicator dot.
  /// If null, uses the primary color.
  final Color? todayIndicatorColor;

  /// Size of the today indicator dot.
  /// Default: 6.0
  final double todayIndicatorSize;

  /// Custom decoration for regular day cells.
  final BoxDecoration? dayDecoration;

  /// Custom decoration for selected day cell.
  final BoxDecoration? selectedDayDecoration;

  /// Custom decoration for current (today) day cell.
  final BoxDecoration? currentDayDecoration;

  /// Custom decoration for weekend day cells.
  final BoxDecoration? weekendDayDecoration;

  /// Border color for hovered day cell.
  /// If null, uses theme primary color with reduced opacity.
  final Color? hoverDayBorderColor;

  /// Border width for hovered day cell.
  /// Default: 2.0
  final double hoverDayBorderWidth;

  /// Custom decoration for hovered day cell.
  final BoxDecoration? hoverDayDecoration;

  /// Background color for selected day cell (not just the number circle).
  /// If null, no additional background color is applied on selection.
  final Color? selectedDayBackgroundColor;

  /// Top margin for day cells in the grid.
  /// Default: 0.0
  final double dayCellTopMargin;

  @override
  List<Object?> get props => [
        dayColor,
        currentDayColor,
        dayNumberBackgroundColor,
        selectedDayNumberBackgroundColor,
        dayNumberTextStyle,
        selectedDayNumberTextStyle,
        spacingColor,
        crossAxisSpacing,
        mainAxisSpacing,
        dayNumberHeight,
        dayNumberMargin,
        dayNumberPadding,
        weekendDayColor,
        weekendDayNumberTextStyle,
        outsideMonthDayColor,
        outsideMonthDayTextStyle,
        outsideMonthOpacity,
        selectedDayBorderColor,
        selectedDayBorderWidth,
        showTodayIndicator,
        todayIndicatorColor,
        todayIndicatorSize,
        dayDecoration,
        selectedDayDecoration,
        currentDayDecoration,
        weekendDayDecoration,
        hoverDayBorderColor,
        hoverDayBorderWidth,
        hoverDayDecoration,
        selectedDayBackgroundColor,
        dayCellTopMargin,
      ];

  /// Creates a copy of this theme but with the given fields replaced with
  /// the new values
  MonthDayTheme copyWith({
    Color? dayColor,
    Color? currentDayColor,
    Color? dayNumberBackgroundColor,
    Color? selectedDayNumberBackgroundColor,
    Color? spacingColor,
    TextStyle? dayNumberTextStyle,
    TextStyle? selectedDayNumberTextStyle,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    double? dayNumberHeight,
    EdgeInsets? dayNumberMargin,
    EdgeInsets? dayNumberPadding,
    Color? weekendDayColor,
    TextStyle? weekendDayNumberTextStyle,
    Color? outsideMonthDayColor,
    TextStyle? outsideMonthDayTextStyle,
    double? outsideMonthOpacity,
    Color? selectedDayBorderColor,
    double? selectedDayBorderWidth,
    DayBuilder? dayBuilder,
    bool? showTodayIndicator,
    Color? todayIndicatorColor,
    double? todayIndicatorSize,
    BoxDecoration? dayDecoration,
    BoxDecoration? selectedDayDecoration,
    BoxDecoration? currentDayDecoration,
    BoxDecoration? weekendDayDecoration,
    Color? hoverDayBorderColor,
    double? hoverDayBorderWidth,
    BoxDecoration? hoverDayDecoration,
    Color? selectedDayBackgroundColor,
    double? dayCellTopMargin,
  }) {
    return MonthDayTheme(
      dayColor: dayColor ?? this.dayColor,
      currentDayColor: currentDayColor ?? this.currentDayColor,
      dayNumberBackgroundColor:
          dayNumberBackgroundColor ?? this.dayNumberBackgroundColor,
      selectedDayNumberBackgroundColor: selectedDayNumberBackgroundColor ??
          this.selectedDayNumberBackgroundColor,
      spacingColor: spacingColor ?? this.spacingColor,
      dayNumberTextStyle: dayNumberTextStyle ?? this.dayNumberTextStyle,
      selectedDayNumberTextStyle:
          selectedDayNumberTextStyle ?? this.selectedDayNumberTextStyle,
      crossAxisSpacing: crossAxisSpacing ?? this.crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing ?? this.mainAxisSpacing,
      dayNumberHeight: dayNumberHeight ?? this.dayNumberHeight,
      dayNumberMargin: dayNumberMargin ?? this.dayNumberMargin,
      dayNumberPadding: dayNumberPadding ?? this.dayNumberPadding,
      weekendDayColor: weekendDayColor ?? this.weekendDayColor,
      weekendDayNumberTextStyle:
          weekendDayNumberTextStyle ?? this.weekendDayNumberTextStyle,
      outsideMonthDayColor: outsideMonthDayColor ?? this.outsideMonthDayColor,
      outsideMonthDayTextStyle:
          outsideMonthDayTextStyle ?? this.outsideMonthDayTextStyle,
      outsideMonthOpacity: outsideMonthOpacity ?? this.outsideMonthOpacity,
      selectedDayBorderColor:
          selectedDayBorderColor ?? this.selectedDayBorderColor,
      selectedDayBorderWidth:
          selectedDayBorderWidth ?? this.selectedDayBorderWidth,
      dayBuilder: dayBuilder ?? this.dayBuilder,
      showTodayIndicator: showTodayIndicator ?? this.showTodayIndicator,
      todayIndicatorColor: todayIndicatorColor ?? this.todayIndicatorColor,
      todayIndicatorSize: todayIndicatorSize ?? this.todayIndicatorSize,
      dayDecoration: dayDecoration ?? this.dayDecoration,
      selectedDayDecoration:
          selectedDayDecoration ?? this.selectedDayDecoration,
      currentDayDecoration: currentDayDecoration ?? this.currentDayDecoration,
      weekendDayDecoration: weekendDayDecoration ?? this.weekendDayDecoration,
      hoverDayBorderColor: hoverDayBorderColor ?? this.hoverDayBorderColor,
      hoverDayBorderWidth: hoverDayBorderWidth ?? this.hoverDayBorderWidth,
      hoverDayDecoration: hoverDayDecoration ?? this.hoverDayDecoration,
      selectedDayBackgroundColor:
          selectedDayBackgroundColor ?? this.selectedDayBackgroundColor,
      dayCellTopMargin: dayCellTopMargin ?? this.dayCellTopMargin,
    );
  }
}
