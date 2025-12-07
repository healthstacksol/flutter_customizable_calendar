import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Configuration for grid line rendering in timeline views.
///
/// Controls the appearance of vertical and horizontal grid lines in the
/// Days and Week calendar views.
class GridLineTheme extends Equatable {
  /// Creates a new grid line theme configuration.
  const GridLineTheme({
    this.showVerticalLines = true,
    this.showHorizontalLines = true,
    this.verticalLineColor,
    this.horizontalLineColor,
    this.verticalLineWidth = 1.0,
    this.horizontalLineWidth = 1.0,
    this.hourLineColor,
    this.halfHourLineColor,
    this.quarterHourLineColor,
    this.hourLineWidth = 1.0,
    this.halfHourLineWidth = 0.5,
    this.quarterHourLineWidth = 0.5,
    this.stripeColor,
    this.stripeOpacity = 0.1,
    this.alternatingStripes = true,
  });

  /// Whether to show vertical grid lines between days.
  /// Default: true
  final bool showVerticalLines;

  /// Whether to show horizontal grid lines at hour boundaries.
  /// Default: true
  final bool showHorizontalLines;

  /// Color of vertical grid lines between days.
  /// If null, uses the theme's divider color.
  final Color? verticalLineColor;

  /// Color of horizontal grid lines.
  /// If null, uses the theme's divider color.
  final Color? horizontalLineColor;

  /// Width of vertical grid lines.
  /// Default: 1.0
  final double verticalLineWidth;

  /// Width of horizontal grid lines.
  /// Default: 1.0
  final double horizontalLineWidth;

  /// Color for hour-boundary horizontal lines.
  /// If null, falls back to [horizontalLineColor].
  final Color? hourLineColor;

  /// Color for half-hour horizontal lines.
  /// If null, falls back to [horizontalLineColor] with reduced opacity.
  final Color? halfHourLineColor;

  /// Color for quarter-hour horizontal lines.
  /// If null, falls back to [horizontalLineColor] with reduced opacity.
  final Color? quarterHourLineColor;

  /// Width of hour-boundary lines.
  /// Default: 1.0
  final double hourLineWidth;

  /// Width of half-hour lines.
  /// Default: 0.5
  final double halfHourLineWidth;

  /// Width of quarter-hour lines.
  /// Default: 0.5
  final double quarterHourLineWidth;

  /// Color for alternating column stripes (e.g., in week view).
  /// If null, uses grey.
  final Color? stripeColor;

  /// Opacity of the stripe color.
  /// Default: 0.1
  final double stripeOpacity;

  /// Whether to show alternating stripes on columns.
  /// Default: true
  final bool alternatingStripes;

  @override
  List<Object?> get props => [
        showVerticalLines,
        showHorizontalLines,
        verticalLineColor,
        horizontalLineColor,
        verticalLineWidth,
        horizontalLineWidth,
        hourLineColor,
        halfHourLineColor,
        quarterHourLineColor,
        hourLineWidth,
        halfHourLineWidth,
        quarterHourLineWidth,
        stripeColor,
        stripeOpacity,
        alternatingStripes,
      ];

  /// Creates a copy of this theme with the given fields replaced.
  GridLineTheme copyWith({
    bool? showVerticalLines,
    bool? showHorizontalLines,
    Color? verticalLineColor,
    Color? horizontalLineColor,
    double? verticalLineWidth,
    double? horizontalLineWidth,
    Color? hourLineColor,
    Color? halfHourLineColor,
    Color? quarterHourLineColor,
    double? hourLineWidth,
    double? halfHourLineWidth,
    double? quarterHourLineWidth,
    Color? stripeColor,
    double? stripeOpacity,
    bool? alternatingStripes,
  }) {
    return GridLineTheme(
      showVerticalLines: showVerticalLines ?? this.showVerticalLines,
      showHorizontalLines: showHorizontalLines ?? this.showHorizontalLines,
      verticalLineColor: verticalLineColor ?? this.verticalLineColor,
      horizontalLineColor: horizontalLineColor ?? this.horizontalLineColor,
      verticalLineWidth: verticalLineWidth ?? this.verticalLineWidth,
      horizontalLineWidth: horizontalLineWidth ?? this.horizontalLineWidth,
      hourLineColor: hourLineColor ?? this.hourLineColor,
      halfHourLineColor: halfHourLineColor ?? this.halfHourLineColor,
      quarterHourLineColor: quarterHourLineColor ?? this.quarterHourLineColor,
      hourLineWidth: hourLineWidth ?? this.hourLineWidth,
      halfHourLineWidth: halfHourLineWidth ?? this.halfHourLineWidth,
      quarterHourLineWidth: quarterHourLineWidth ?? this.quarterHourLineWidth,
      stripeColor: stripeColor ?? this.stripeColor,
      stripeOpacity: stripeOpacity ?? this.stripeOpacity,
      alternatingStripes: alternatingStripes ?? this.alternatingStripes,
    );
  }
}
