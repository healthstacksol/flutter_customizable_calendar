import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Configuration for all animation durations and curves in the calendar.
///
/// This class centralizes animation timing to enable consistent, customizable
/// animations across all calendar views (Days, Week, Month).
class CalendarAnimationConfig extends Equatable {
  /// Creates a new animation configuration with customizable durations.
  const CalendarAnimationConfig({
    this.autoScrollDuration = const Duration(milliseconds: 100),
    this.daySelectionDuration = const Duration(milliseconds: 450),
    this.monthPickerDuration = const Duration(milliseconds: 150),
    this.weekNavigationDuration = const Duration(milliseconds: 400),
    this.daysListDuration = const Duration(milliseconds: 300),
    this.scrollAnimationDuration = const Duration(milliseconds: 300),
    this.itemSelectionDuration = const Duration(milliseconds: 150),
    this.autoScrollCurve = Curves.linear,
    this.navigationCurve = Curves.easeInOut,
    this.selectionCurve = Curves.fastOutSlowIn,
  });

  /// Duration for auto-scroll during drag operations.
  /// Default: 100ms
  final Duration autoScrollDuration;

  /// Duration for day selection animations in Days view.
  /// Default: 450ms
  final Duration daySelectionDuration;

  /// Duration for month picker transition animations.
  /// Default: 150ms
  final Duration monthPickerDuration;

  /// Duration for week navigation/page change animations.
  /// Default: 400ms
  final Duration weekNavigationDuration;

  /// Duration for days list scroll animations.
  /// Default: 300ms
  final Duration daysListDuration;

  /// Duration for general scroll animations.
  /// Default: 300ms
  final Duration scrollAnimationDuration;

  /// Duration for item selection feedback animations.
  /// Default: 150ms
  final Duration itemSelectionDuration;

  /// Curve used for auto-scroll animations.
  /// Default: Curves.linear
  final Curve autoScrollCurve;

  /// Curve used for navigation/page animations.
  /// Default: Curves.easeInOut
  final Curve navigationCurve;

  /// Curve used for selection state animations.
  /// Default: Curves.fastOutSlowIn
  final Curve selectionCurve;

  @override
  List<Object?> get props => [
        autoScrollDuration,
        daySelectionDuration,
        monthPickerDuration,
        weekNavigationDuration,
        daysListDuration,
        scrollAnimationDuration,
        itemSelectionDuration,
        autoScrollCurve,
        navigationCurve,
        selectionCurve,
      ];

  /// Creates a copy of this config with the given fields replaced.
  CalendarAnimationConfig copyWith({
    Duration? autoScrollDuration,
    Duration? daySelectionDuration,
    Duration? monthPickerDuration,
    Duration? weekNavigationDuration,
    Duration? daysListDuration,
    Duration? scrollAnimationDuration,
    Duration? itemSelectionDuration,
    Curve? autoScrollCurve,
    Curve? navigationCurve,
    Curve? selectionCurve,
  }) {
    return CalendarAnimationConfig(
      autoScrollDuration: autoScrollDuration ?? this.autoScrollDuration,
      daySelectionDuration: daySelectionDuration ?? this.daySelectionDuration,
      monthPickerDuration: monthPickerDuration ?? this.monthPickerDuration,
      weekNavigationDuration:
          weekNavigationDuration ?? this.weekNavigationDuration,
      daysListDuration: daysListDuration ?? this.daysListDuration,
      scrollAnimationDuration:
          scrollAnimationDuration ?? this.scrollAnimationDuration,
      itemSelectionDuration:
          itemSelectionDuration ?? this.itemSelectionDuration,
      autoScrollCurve: autoScrollCurve ?? this.autoScrollCurve,
      navigationCurve: navigationCurve ?? this.navigationCurve,
      selectionCurve: selectionCurve ?? this.selectionCurve,
    );
  }
}
