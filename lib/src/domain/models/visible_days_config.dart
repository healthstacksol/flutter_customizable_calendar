import 'package:equatable/equatable.dart';

/// Configuration for controlling which days are visible in calendar views.
///
/// Enables flexible day filtering for Week and Month views, including
/// weekday-only display, custom first day of week, and arbitrary day filtering.
class VisibleDaysConfig extends Equatable {
  /// Creates a new visible days configuration.
  ///
  /// By default, shows all 7 days with Monday as the first day of week.
  const VisibleDaysConfig({
    this.visibleWeekdays = const [1, 2, 3, 4, 5, 6, 7],
    this.firstDayOfWeek = DateTime.monday,
    this.daysPerPage = 7,
    this.dayFilter,
  });

  /// Creates a weekdays-only configuration (Monday-Friday).
  const VisibleDaysConfig.weekdaysOnly({
    this.firstDayOfWeek = DateTime.monday,
    this.daysPerPage = 5,
    this.dayFilter,
  }) : visibleWeekdays = const [1, 2, 3, 4, 5];

  /// Creates a weekend-only configuration (Saturday-Sunday).
  const VisibleDaysConfig.weekendsOnly({
    this.firstDayOfWeek = DateTime.saturday,
    this.daysPerPage = 2,
    this.dayFilter,
  }) : visibleWeekdays = const [6, 7];

  /// Which days of week to show.
  /// Uses ISO 8601 weekday numbering: 1=Monday, 7=Sunday.
  final List<int> visibleWeekdays;

  /// First day of the week.
  /// Uses ISO 8601 weekday numbering: 1=Monday, 7=Sunday.
  /// Default: DateTime.monday (1)
  final int firstDayOfWeek;

  /// Number of days visible at once in Week view.
  /// Default: 7
  final int daysPerPage;

  /// Optional custom filter function for days.
  /// Return true to show the day, false to hide it.
  /// This is applied in addition to [visibleWeekdays] filtering.
  final bool Function(DateTime)? dayFilter;

  /// Returns true if the given weekday should be visible.
  bool isWeekdayVisible(int weekday) => visibleWeekdays.contains(weekday);

  /// Returns true if the given date should be visible.
  /// Applies both [visibleWeekdays] and [dayFilter] checks.
  bool isDayVisible(DateTime date) {
    if (!isWeekdayVisible(date.weekday)) return false;
    if (dayFilter != null && !dayFilter!(date)) return false;
    return true;
  }

  /// Returns the number of visible days per week.
  int get visibleDaysPerWeek => visibleWeekdays.length;

  /// Returns true if weekends (Saturday and Sunday) are hidden.
  bool get hidesWeekends =>
      !visibleWeekdays.contains(DateTime.saturday) &&
      !visibleWeekdays.contains(DateTime.sunday);

  /// Returns true if this shows all 7 days.
  bool get showsAllDays => visibleWeekdays.length == 7;

  /// Filters a list of dates to only include visible days.
  List<DateTime> filterDays(List<DateTime> dates) {
    return dates.where(isDayVisible).toList();
  }

  /// Gets the ordered list of weekdays starting from [firstDayOfWeek].
  List<int> get orderedWeekdays {
    final result = <int>[];
    for (var i = 0; i < 7; i++) {
      final weekday = ((firstDayOfWeek - 1 + i) % 7) + 1;
      if (visibleWeekdays.contains(weekday)) {
        result.add(weekday);
      }
    }
    return result;
  }

  @override
  List<Object?> get props => [
        visibleWeekdays,
        firstDayOfWeek,
        daysPerPage,
        // Note: dayFilter is not included in props as functions don't have
        // meaningful equality
      ];

  /// Creates a copy of this config with the given fields replaced.
  VisibleDaysConfig copyWith({
    List<int>? visibleWeekdays,
    int? firstDayOfWeek,
    int? daysPerPage,
    bool Function(DateTime)? dayFilter,
  }) {
    return VisibleDaysConfig(
      visibleWeekdays: visibleWeekdays ?? this.visibleWeekdays,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
      daysPerPage: daysPerPage ?? this.daysPerPage,
      dayFilter: dayFilter ?? this.dayFilter,
    );
  }
}
