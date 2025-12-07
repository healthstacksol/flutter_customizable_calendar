import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Configuration for calendar grid cell rendering.
///
/// Controls the appearance of individual cells in the timeline grid,
/// including background colors, borders, and custom builders.
class GridCellTheme extends Equatable {
  /// Creates a new grid cell theme configuration.
  const GridCellTheme({
    this.cellBackground,
    this.alternatingCellBackground,
    this.cellDecoration,
    this.topBorder,
    this.bottomBorder,
    this.leftBorder,
    this.rightBorder,
    this.minCellHeight,
    this.maxCellHeight,
    this.hourLineBorder,
    this.halfHourLineBorder,
    this.quarterHourLineBorder,
    this.cellBuilder,
    this.weekendCellBackground,
    this.todayCellBackground,
    this.pastCellBackground,
    this.futureCellBackground,
    this.cellPadding,
    this.cellMargin,
  });

  /// Background color for cells.
  /// If null, cells are transparent.
  final Color? cellBackground;

  /// Background color for alternating cells (every other column).
  /// If null, uses [cellBackground].
  final Color? alternatingCellBackground;

  /// Custom decoration for cells.
  /// Overrides [cellBackground] if provided.
  final BoxDecoration? cellDecoration;

  /// Border for the top edge of cells.
  final BorderSide? topBorder;

  /// Border for the bottom edge of cells.
  final BorderSide? bottomBorder;

  /// Border for the left edge of cells.
  final BorderSide? leftBorder;

  /// Border for the right edge of cells.
  final BorderSide? rightBorder;

  /// Minimum height for cells.
  final double? minCellHeight;

  /// Maximum height for cells.
  final double? maxCellHeight;

  /// Border style for hour-boundary lines.
  final BorderSide? hourLineBorder;

  /// Border style for half-hour lines.
  final BorderSide? halfHourLineBorder;

  /// Border style for quarter-hour lines.
  final BorderSide? quarterHourLineBorder;

  /// Custom builder for cell contents.
  /// Parameters: (DateTime date, int hour, int minute)
  final Widget Function(DateTime date, int hour, int minute)? cellBuilder;

  /// Background color for weekend day cells.
  /// If null, uses [cellBackground] or [alternatingCellBackground].
  final Color? weekendCellBackground;

  /// Background color for today's cell.
  /// If null, uses [cellBackground].
  final Color? todayCellBackground;

  /// Background color for cells in the past.
  /// If null, uses [cellBackground].
  final Color? pastCellBackground;

  /// Background color for cells in the future.
  /// If null, uses [cellBackground].
  final Color? futureCellBackground;

  /// Padding inside each cell.
  final EdgeInsets? cellPadding;

  /// Margin around each cell.
  final EdgeInsets? cellMargin;

  /// Returns the effective background color for a cell.
  Color? getBackgroundColor({
    required DateTime date,
    required int columnIndex,
    required DateTime now,
  }) {
    final isToday = date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
    final isWeekend =
        date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
    final isPast = date.isBefore(DateTime(now.year, now.month, now.day));

    if (isToday && todayCellBackground != null) {
      return todayCellBackground;
    }
    if (isWeekend && weekendCellBackground != null) {
      return weekendCellBackground;
    }
    if (isPast && pastCellBackground != null) {
      return pastCellBackground;
    }
    if (!isPast && futureCellBackground != null) {
      return futureCellBackground;
    }
    if (columnIndex.isOdd && alternatingCellBackground != null) {
      return alternatingCellBackground;
    }
    return cellBackground;
  }

  @override
  List<Object?> get props => [
        cellBackground,
        alternatingCellBackground,
        cellDecoration,
        topBorder,
        bottomBorder,
        leftBorder,
        rightBorder,
        minCellHeight,
        maxCellHeight,
        hourLineBorder,
        halfHourLineBorder,
        quarterHourLineBorder,
        weekendCellBackground,
        todayCellBackground,
        pastCellBackground,
        futureCellBackground,
        cellPadding,
        cellMargin,
      ];

  /// Creates a copy of this theme with the given fields replaced.
  GridCellTheme copyWith({
    Color? cellBackground,
    Color? alternatingCellBackground,
    BoxDecoration? cellDecoration,
    BorderSide? topBorder,
    BorderSide? bottomBorder,
    BorderSide? leftBorder,
    BorderSide? rightBorder,
    double? minCellHeight,
    double? maxCellHeight,
    BorderSide? hourLineBorder,
    BorderSide? halfHourLineBorder,
    BorderSide? quarterHourLineBorder,
    Widget Function(DateTime, int, int)? cellBuilder,
    Color? weekendCellBackground,
    Color? todayCellBackground,
    Color? pastCellBackground,
    Color? futureCellBackground,
    EdgeInsets? cellPadding,
    EdgeInsets? cellMargin,
  }) {
    return GridCellTheme(
      cellBackground: cellBackground ?? this.cellBackground,
      alternatingCellBackground:
          alternatingCellBackground ?? this.alternatingCellBackground,
      cellDecoration: cellDecoration ?? this.cellDecoration,
      topBorder: topBorder ?? this.topBorder,
      bottomBorder: bottomBorder ?? this.bottomBorder,
      leftBorder: leftBorder ?? this.leftBorder,
      rightBorder: rightBorder ?? this.rightBorder,
      minCellHeight: minCellHeight ?? this.minCellHeight,
      maxCellHeight: maxCellHeight ?? this.maxCellHeight,
      hourLineBorder: hourLineBorder ?? this.hourLineBorder,
      halfHourLineBorder: halfHourLineBorder ?? this.halfHourLineBorder,
      quarterHourLineBorder:
          quarterHourLineBorder ?? this.quarterHourLineBorder,
      cellBuilder: cellBuilder ?? this.cellBuilder,
      weekendCellBackground:
          weekendCellBackground ?? this.weekendCellBackground,
      todayCellBackground: todayCellBackground ?? this.todayCellBackground,
      pastCellBackground: pastCellBackground ?? this.pastCellBackground,
      futureCellBackground: futureCellBackground ?? this.futureCellBackground,
      cellPadding: cellPadding ?? this.cellPadding,
      cellMargin: cellMargin ?? this.cellMargin,
    );
  }
}
