import 'package:equatable/equatable.dart';
import 'package:flutter_customizable_calendar/src/ui/themes/timeline_theme.dart';

/// Configuration for a single time increment mark on the timeline.
///
/// Allows defining custom time intervals (5, 10, 15, 20, 30, etc. minutes)
/// with individual styling.
class TimeIncrement extends Equatable {
  /// Creates a new time increment configuration.
  const TimeIncrement({
    required this.minutes,
    required this.theme,
    this.showLabel = false,
    this.labelFormatter,
  });

  /// Creates a standard hour increment.
  const TimeIncrement.hour({
    this.theme = const TimeMarkTheme(length: 24),
    this.showLabel = true,
    this.labelFormatter,
  }) : minutes = 60;

  /// Creates a 30-minute increment.
  const TimeIncrement.halfHour({
    this.theme = const TimeMarkTheme(length: 16),
    this.showLabel = false,
    this.labelFormatter,
  }) : minutes = 30;

  /// Creates a 45-minute increment.
  const TimeIncrement.fortyFiveMinutes({
    this.theme = const TimeMarkTheme(length: 12),
    this.showLabel = false,
    this.labelFormatter,
  }) : minutes = 45;

  /// Creates a 15-minute increment.
  const TimeIncrement.quarterHour({
    this.theme = const TimeMarkTheme(length: 8),
    this.showLabel = false,
    this.labelFormatter,
  }) : minutes = 15;

  /// Creates a 10-minute increment.
  const TimeIncrement.tenMinutes({
    this.theme = const TimeMarkTheme(length: 6),
    this.showLabel = false,
    this.labelFormatter,
  }) : minutes = 10;

  /// Creates a 5-minute increment.
  const TimeIncrement.fiveMinutes({
    this.theme = const TimeMarkTheme(length: 4),
    this.showLabel = false,
    this.labelFormatter,
  }) : minutes = 5;

  /// Interval in minutes (e.g., 5, 10, 15, 20, 30, 60).
  final int minutes;

  /// Visual theme for this increment's marks.
  final TimeMarkTheme theme;

  /// Whether to show a label at this increment.
  final bool showLabel;

  /// Optional custom label formatter.
  /// If null and [showLabel] is true, uses the default hour formatter.
  final String Function(DateTime)? labelFormatter;

  /// Returns the number of marks per hour for this increment.
  int get marksPerHour => 60 ~/ minutes;

  /// Returns the total number of marks per day for this increment.
  int get marksPerDay => Duration.minutesPerDay ~/ minutes;

  @override
  List<Object?> get props => [
        minutes,
        theme,
        showLabel,
      ];

  /// Creates a copy with the given fields replaced.
  TimeIncrement copyWith({
    int? minutes,
    TimeMarkTheme? theme,
    bool? showLabel,
    String Function(DateTime)? labelFormatter,
  }) {
    return TimeIncrement(
      minutes: minutes ?? this.minutes,
      theme: theme ?? this.theme,
      showLabel: showLabel ?? this.showLabel,
      labelFormatter: labelFormatter ?? this.labelFormatter,
    );
  }
}

/// Configuration for all time increments displayed on the timeline.
///
/// Replaces the old drawHalfHourMarks/drawQuarterHourMarks flags with a
/// flexible list-based system that supports arbitrary time intervals.
class TimeIncrementConfig extends Equatable {
  /// Creates a new time increment configuration.
  const TimeIncrementConfig({
    this.increments = const [
      TimeIncrement.hour(),
      TimeIncrement.halfHour(),
      TimeIncrement.quarterHour(),
    ],
    this.showIncrementLabels = true,
  });

  /// Creates a minimal configuration with only hour marks.
  const TimeIncrementConfig.hoursOnly({
    this.showIncrementLabels = true,
  }) : increments = const [TimeIncrement.hour()];

  /// Creates a detailed configuration with 15-minute increments.
  const TimeIncrementConfig.detailed({
    this.showIncrementLabels = true,
  }) : increments = const [
          TimeIncrement.hour(),
          TimeIncrement.halfHour(),
          TimeIncrement.quarterHour(),
        ];

  /// Creates a very detailed configuration with 5-minute increments.
  const TimeIncrementConfig.veryDetailed({
    this.showIncrementLabels = true,
  }) : increments = const [
          TimeIncrement.hour(),
          TimeIncrement.halfHour(),
          TimeIncrement.quarterHour(),
          TimeIncrement.tenMinutes(),
          TimeIncrement.fiveMinutes(),
        ];

  /// All time increments to display.
  /// Ordered from largest to smallest interval for proper layering.
  final List<TimeIncrement> increments;

  /// Whether to show labels for increments that have `showLabel` enabled.
  final bool showIncrementLabels;

  /// Returns the smallest increment in minutes.
  int get smallestIncrement {
    if (increments.isEmpty) return 60;
    return increments.map((i) => i.minutes).reduce((a, b) => a < b ? a : b);
  }

  /// Returns the largest increment in minutes.
  int get largestIncrement {
    if (increments.isEmpty) return 60;
    return increments.map((i) => i.minutes).reduce((a, b) => a > b ? a : b);
  }

  /// Returns increments sorted by interval (largest first).
  List<TimeIncrement> get sortedIncrements {
    final sorted = List<TimeIncrement>.from(increments)
      ..sort((a, b) => b.minutes.compareTo(a.minutes));
    return sorted;
  }

  @override
  List<Object?> get props => [
        increments,
        showIncrementLabels,
      ];

  /// Creates a copy with the given fields replaced.
  TimeIncrementConfig copyWith({
    List<TimeIncrement>? increments,
    bool? showIncrementLabels,
  }) {
    return TimeIncrementConfig(
      increments: increments ?? this.increments,
      showIncrementLabels: showIncrementLabels ?? this.showIncrementLabels,
    );
  }
}
