import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_customizable_calendar/src/domain/models/calendar_event.dart';

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
  final Widget Function(
    DateTime date,
    List<CalendarEvent> events,
    bool isSelected,
  )? dayBuilder;

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
    Widget Function(DateTime, List<CalendarEvent>, bool)? dayBuilder,
    bool? showTodayIndicator,
    Color? todayIndicatorColor,
    double? todayIndicatorSize,
    BoxDecoration? dayDecoration,
    BoxDecoration? selectedDayDecoration,
    BoxDecoration? currentDayDecoration,
    BoxDecoration? weekendDayDecoration,
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
    );
  }
}
