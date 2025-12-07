import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Configuration for the current time indicator line.
///
/// The current time indicator is a horizontal line that spans across
/// the timeline grid to show the current time position.
class CurrentTimeIndicatorTheme extends Equatable {
  /// Creates a new current time indicator theme.
  const CurrentTimeIndicatorTheme({
    this.enabled = true,
    this.color = Colors.blue,
    this.thickness = 2.0,
    this.showBullet = true,
    this.bulletRadius = 5.0,
    this.bulletColor,
    this.dashPattern,
    this.extendToFullWidth = true,
    this.showInDaysView = true,
    this.showInWeekView = true,
    this.offset = 0.0,
  });

  /// Whether the current time indicator is enabled.
  /// Default: true
  final bool enabled;

  /// Color of the time indicator line.
  /// Default: Colors.blue
  final Color color;

  /// Thickness of the line.
  /// Default: 2.0
  final double thickness;

  /// Whether to show a bullet/circle at the start of the line.
  /// Default: true
  final bool showBullet;

  /// Radius of the bullet circle.
  /// Default: 5.0
  final double bulletRadius;

  /// Color of the bullet. If null, uses [color].
  final Color? bulletColor;

  /// Dash pattern for the line. If null, draws solid line.
  /// Example: [5, 3] for 5px dash, 3px gap.
  final List<double>? dashPattern;

  /// Whether the line extends to the full width of the timeline.
  /// Default: true
  final bool extendToFullWidth;

  /// Whether to show in Days view.
  /// Default: true
  final bool showInDaysView;

  /// Whether to show in Week view.
  /// Default: true
  final bool showInWeekView;

  /// Vertical offset from the exact time position in pixels.
  /// Positive values move the indicator down, negative up.
  /// Default: 0.0
  final double offset;

  /// Gets the effective bullet color.
  Color get effectiveBulletColor => bulletColor ?? color;

  /// Creates a Paint object for the line.
  Paint get linePaint => Paint()
    ..color = color
    ..strokeWidth = thickness
    ..style = PaintingStyle.stroke;

  /// Creates a Paint object for the bullet.
  Paint get bulletPaint => Paint()
    ..color = effectiveBulletColor
    ..style = PaintingStyle.fill;

  @override
  List<Object?> get props => [
        enabled,
        color,
        thickness,
        showBullet,
        bulletRadius,
        bulletColor,
        dashPattern,
        extendToFullWidth,
        showInDaysView,
        showInWeekView,
        offset,
      ];

  /// Creates a copy of this theme with the given fields replaced.
  CurrentTimeIndicatorTheme copyWith({
    bool? enabled,
    Color? color,
    double? thickness,
    bool? showBullet,
    double? bulletRadius,
    Color? bulletColor,
    List<double>? dashPattern,
    bool? extendToFullWidth,
    bool? showInDaysView,
    bool? showInWeekView,
    double? offset,
  }) {
    return CurrentTimeIndicatorTheme(
      enabled: enabled ?? this.enabled,
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      showBullet: showBullet ?? this.showBullet,
      bulletRadius: bulletRadius ?? this.bulletRadius,
      bulletColor: bulletColor ?? this.bulletColor,
      dashPattern: dashPattern ?? this.dashPattern,
      extendToFullWidth: extendToFullWidth ?? this.extendToFullWidth,
      showInDaysView: showInDaysView ?? this.showInDaysView,
      showInWeekView: showInWeekView ?? this.showInWeekView,
      offset: offset ?? this.offset,
    );
  }
}
