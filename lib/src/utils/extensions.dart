import 'package:flutter/material.dart';
import 'package:flutter_customizable_calendar/src/domain/models/visible_days_config.dart';

///
extension CapitalizedString on String {
  /// Returns new [String] which has the first letter in upper case.
  String capitalized() => '${this[0].toUpperCase()}${substring(1)}';
}

///
extension DurationInWeeks on Duration {
  /// The number of entire weeks spanned by this Duration.
  int inWeeks(int visibleDay) => inDays ~/ visibleDay;
}

///
extension WeekUtils on DateTime {
  /// Returns all day dates of current week from Monday (1) to Sunday (7).
  DateTimeRange weekRange(int visibleDays) {
    if (visibleDays == 7) {
      return DateTimeRange(
        start: DateUtils.addDaysToDate(this, 1 - weekday),
        end: DateUtils.addDaysToDate(this, 8 - weekday),
      );
    }
    final range = DateTimeRange(
      start: DateUtils.addDaysToDate(this, 0),
      end: DateUtils.addDaysToDate(this, visibleDays),
    );
    return range;
  }

  /// Returns week range with configurable first day of week and visible days.
  ///
  /// Uses [VisibleDaysConfig] to determine:
  /// - Which day the week starts on (`firstDayOfWeek`)
  /// - How many days are visible (`daysPerPage`)
  DateTimeRange weekRangeWithConfig(VisibleDaysConfig config) {
    final daysFromFirstDay = (weekday - config.firstDayOfWeek + 7) % 7;
    final weekStart = DateUtils.addDaysToDate(this, -daysFromFirstDay);

    return DateTimeRange(
      start: weekStart,
      end: DateUtils.addDaysToDate(weekStart, config.daysPerPage),
    );
  }

  DateTime addWeeks(int visibleDays, int weeks) {
    return DateUtils.addDaysToDate(
      this,
      weeks * visibleDays,
    );
  }

  /// Adds weeks using the config's days per page setting.
  DateTime addWeeksWithConfig(VisibleDaysConfig config, int weeks) {
    return DateUtils.addDaysToDate(
      this,
      weeks * config.daysPerPage,
    );
  }

  /// Returns result of check whether both dates are in the same week range.
  bool isSameWeekAs(int visibleDays, DateTime? other) {
    if (other == null) return false;
    final week = weekRange(visibleDays);
    return !other.isBefore(week.start) && other.isBefore(week.end);
  }

  /// Returns result of check whether both dates are in the same week range
  /// using [VisibleDaysConfig].
  bool isSameWeekAsWithConfig(VisibleDaysConfig config, DateTime? other) {
    if (other == null) return false;
    final week = weekRangeWithConfig(config);
    return !other.isBefore(week.start) && other.isBefore(week.end);
  }

  /// Returns the start of the week based on [firstDayOfWeek].
  DateTime weekStart(int firstDayOfWeek) {
    final daysFromFirstDay = (weekday - firstDayOfWeek + 7) % 7;
    return DateUtils.addDaysToDate(this, -daysFromFirstDay);
  }
}

///
extension MonthUtils on DateTime {
  /// Returns day dates of 6 weeks which include current month.
  DateTimeRange monthViewRange({
    bool weekStartsOnSunday = false,
    int numberOfWeeks = 6,
  }) {
    final first = DateUtils.addDaysToDate(
      this,
      1 - day,
    );
    final startDate = DateUtils.addDaysToDate(
      first,
      1 - first.weekday - (weekStartsOnSunday ? 1 : 0),
    );

    /// In case of clock change, set end day to 12:00
    return DateTimeRange(
      start: startDate,
      end: DateUtils.addDaysToDate(
        startDate,
        numberOfWeeks * 7,
      ).add(const Duration(hours: 12)),
    );
  }

  /// Returns month view range using [VisibleDaysConfig].
  ///
  /// Respects the first day of week from the config and calculates the
  /// appropriate range to display in a month view.
  DateTimeRange monthViewRangeWithConfig({
    required VisibleDaysConfig config,
    int numberOfWeeks = 6,
  }) {
    final first = DateUtils.addDaysToDate(this, 1 - day);
    final daysFromFirstDay = (first.weekday - config.firstDayOfWeek + 7) % 7;
    final startDate = DateUtils.addDaysToDate(first, -daysFromFirstDay);

    return DateTimeRange(
      start: startDate,
      end: DateUtils.addDaysToDate(
        startDate,
        numberOfWeeks * 7,
      ).add(const Duration(hours: 12)),
    );
  }
}

///
extension DaysList on DateTimeRange {
  /// Returns all days dates between [start] and [end] values.
  List<DateTime> get days => List.generate(
        duration.inDays,
        (index) => DateUtils.addDaysToDate(start, index),
      );

  /// Returns visible days filtered by [VisibleDaysConfig].
  List<DateTime> visibleDays(VisibleDaysConfig config) {
    return days.where(config.isDayVisible).toList();
  }
}
