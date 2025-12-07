import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Configuration for selection and hover states in the calendar.
///
/// Controls the visual appearance of selected cells, events, and time slots,
/// as well as hover effects for interactive elements.
class SelectionTheme extends Equatable {
  /// Creates a new selection theme.
  const SelectionTheme({
    this.selectionColor,
    this.selectionBorderColor,
    this.selectionBorderWidth = 2.0,
    this.selectionBorderRadius = 4.0,
    this.selectionOpacity = 0.2,
    this.hoverColor,
    this.hoverBorderColor,
    this.hoverBorderWidth = 1.0,
    this.hoverOpacity = 0.1,
    this.enableHoverEffect = true,
    this.enableSelectionAnimation = true,
    this.selectionAnimationDuration = const Duration(milliseconds: 200),
    this.selectionAnimationCurve = Curves.easeInOut,
    this.timeSlotSelectionColor,
    this.timeSlotHoverColor,
    this.eventSelectionColor,
    this.eventHoverColor,
    this.multiSelectEnabled = false,
    this.multiSelectColor,
    this.rangeSelectionEnabled = false,
    this.rangeSelectionColor,
    this.rangeSelectionOpacity = 0.15,
  });

  // ─────────────────────────────────────────────────────────────────────────
  // Selection Colors
  // ─────────────────────────────────────────────────────────────────────────

  /// Background color for selected cells/items.
  /// If null, uses theme primary color with [selectionOpacity].
  final Color? selectionColor;

  /// Border color for selected cells/items.
  /// If null, uses theme primary color.
  final Color? selectionBorderColor;

  /// Border width for selected cells/items.
  /// Default: 2.0
  final double selectionBorderWidth;

  /// Border radius for selection highlight.
  /// Default: 4.0
  final double selectionBorderRadius;

  /// Opacity for selection background color.
  /// Default: 0.2
  final double selectionOpacity;

  // ─────────────────────────────────────────────────────────────────────────
  // Hover Colors
  // ─────────────────────────────────────────────────────────────────────────

  /// Background color for hovered cells/items.
  /// If null, uses theme primary color with [hoverOpacity].
  final Color? hoverColor;

  /// Border/outline color for hovered cells/items.
  /// If null, uses theme primary color.
  final Color? hoverBorderColor;

  /// Border width for hover outline.
  /// Default: 1.0
  final double hoverBorderWidth;

  /// Opacity for hover background color.
  /// Default: 0.1
  final double hoverOpacity;

  /// Whether to enable hover effects (primarily for web/desktop).
  /// Default: true
  final bool enableHoverEffect;

  // ─────────────────────────────────────────────────────────────────────────
  // Animation
  // ─────────────────────────────────────────────────────────────────────────

  /// Whether to animate selection state changes.
  /// Default: true
  final bool enableSelectionAnimation;

  /// Duration for selection animation.
  /// Default: 200ms
  final Duration selectionAnimationDuration;

  /// Curve for selection animation.
  /// Default: Curves.easeInOut
  final Curve selectionAnimationCurve;

  // ─────────────────────────────────────────────────────────────────────────
  // Element-Specific Colors
  // ─────────────────────────────────────────────────────────────────────────

  /// Selection color specifically for time slots.
  /// If null, uses [selectionColor].
  final Color? timeSlotSelectionColor;

  /// Hover color specifically for time slots.
  /// If null, uses [hoverColor].
  final Color? timeSlotHoverColor;

  /// Selection color specifically for events.
  /// If null, uses [selectionColor].
  final Color? eventSelectionColor;

  /// Hover color specifically for events.
  /// If null, uses [hoverColor].
  final Color? eventHoverColor;

  // ─────────────────────────────────────────────────────────────────────────
  // Multi-Select and Range Selection
  // ─────────────────────────────────────────────────────────────────────────

  /// Whether multi-selection is enabled.
  /// Default: false
  final bool multiSelectEnabled;

  /// Color for multi-selected items.
  /// If null, uses [selectionColor].
  final Color? multiSelectColor;

  /// Whether range selection is enabled (e.g., selecting a date range).
  /// Default: false
  final bool rangeSelectionEnabled;

  /// Color for range selection.
  /// If null, uses theme primary color.
  final Color? rangeSelectionColor;

  /// Opacity for range selection highlight.
  /// Default: 0.15
  final double rangeSelectionOpacity;

  // ─────────────────────────────────────────────────────────────────────────
  // Helper Methods
  // ─────────────────────────────────────────────────────────────────────────

  /// Gets the effective selection color for time slots.
  Color? getTimeSlotSelectionColor(Color primaryColor) {
    return timeSlotSelectionColor ??
        selectionColor ??
        primaryColor.withValues(alpha: selectionOpacity);
  }

  /// Gets the effective hover color for time slots.
  Color? getTimeSlotHoverColor(Color primaryColor) {
    return timeSlotHoverColor ??
        hoverColor ??
        primaryColor.withValues(alpha: hoverOpacity);
  }

  /// Gets the effective selection color for events.
  Color? getEventSelectionColor(Color primaryColor) {
    return eventSelectionColor ??
        selectionColor ??
        primaryColor.withValues(alpha: selectionOpacity);
  }

  /// Gets the effective hover color for events.
  Color? getEventHoverColor(Color primaryColor) {
    return eventHoverColor ??
        hoverColor ??
        primaryColor.withValues(alpha: hoverOpacity);
  }

  /// Creates a BoxDecoration for selection state.
  BoxDecoration getSelectionDecoration(Color primaryColor) {
    return BoxDecoration(
      color: selectionColor ?? primaryColor.withValues(alpha: selectionOpacity),
      borderRadius: BorderRadius.circular(selectionBorderRadius),
      border: Border.all(
        color: selectionBorderColor ?? primaryColor,
        width: selectionBorderWidth,
      ),
    );
  }

  /// Creates a BoxDecoration for hover state.
  BoxDecoration getHoverDecoration(Color primaryColor) {
    return BoxDecoration(
      color: hoverColor ?? primaryColor.withValues(alpha: hoverOpacity),
      borderRadius: BorderRadius.circular(selectionBorderRadius),
      border: Border.all(
        color: hoverBorderColor ?? primaryColor,
        width: hoverBorderWidth,
      ),
    );
  }

  @override
  List<Object?> get props => [
        selectionColor,
        selectionBorderColor,
        selectionBorderWidth,
        selectionBorderRadius,
        selectionOpacity,
        hoverColor,
        hoverBorderColor,
        hoverBorderWidth,
        hoverOpacity,
        enableHoverEffect,
        enableSelectionAnimation,
        selectionAnimationDuration,
        selectionAnimationCurve,
        timeSlotSelectionColor,
        timeSlotHoverColor,
        eventSelectionColor,
        eventHoverColor,
        multiSelectEnabled,
        multiSelectColor,
        rangeSelectionEnabled,
        rangeSelectionColor,
        rangeSelectionOpacity,
      ];

  /// Creates a copy of this theme with the given fields replaced.
  SelectionTheme copyWith({
    Color? selectionColor,
    Color? selectionBorderColor,
    double? selectionBorderWidth,
    double? selectionBorderRadius,
    double? selectionOpacity,
    Color? hoverColor,
    Color? hoverBorderColor,
    double? hoverBorderWidth,
    double? hoverOpacity,
    bool? enableHoverEffect,
    bool? enableSelectionAnimation,
    Duration? selectionAnimationDuration,
    Curve? selectionAnimationCurve,
    Color? timeSlotSelectionColor,
    Color? timeSlotHoverColor,
    Color? eventSelectionColor,
    Color? eventHoverColor,
    bool? multiSelectEnabled,
    Color? multiSelectColor,
    bool? rangeSelectionEnabled,
    Color? rangeSelectionColor,
    double? rangeSelectionOpacity,
  }) {
    return SelectionTheme(
      selectionColor: selectionColor ?? this.selectionColor,
      selectionBorderColor: selectionBorderColor ?? this.selectionBorderColor,
      selectionBorderWidth: selectionBorderWidth ?? this.selectionBorderWidth,
      selectionBorderRadius:
          selectionBorderRadius ?? this.selectionBorderRadius,
      selectionOpacity: selectionOpacity ?? this.selectionOpacity,
      hoverColor: hoverColor ?? this.hoverColor,
      hoverBorderColor: hoverBorderColor ?? this.hoverBorderColor,
      hoverBorderWidth: hoverBorderWidth ?? this.hoverBorderWidth,
      hoverOpacity: hoverOpacity ?? this.hoverOpacity,
      enableHoverEffect: enableHoverEffect ?? this.enableHoverEffect,
      enableSelectionAnimation:
          enableSelectionAnimation ?? this.enableSelectionAnimation,
      selectionAnimationDuration:
          selectionAnimationDuration ?? this.selectionAnimationDuration,
      selectionAnimationCurve:
          selectionAnimationCurve ?? this.selectionAnimationCurve,
      timeSlotSelectionColor:
          timeSlotSelectionColor ?? this.timeSlotSelectionColor,
      timeSlotHoverColor: timeSlotHoverColor ?? this.timeSlotHoverColor,
      eventSelectionColor: eventSelectionColor ?? this.eventSelectionColor,
      eventHoverColor: eventHoverColor ?? this.eventHoverColor,
      multiSelectEnabled: multiSelectEnabled ?? this.multiSelectEnabled,
      multiSelectColor: multiSelectColor ?? this.multiSelectColor,
      rangeSelectionEnabled:
          rangeSelectionEnabled ?? this.rangeSelectionEnabled,
      rangeSelectionColor: rangeSelectionColor ?? this.rangeSelectionColor,
      rangeSelectionOpacity:
          rangeSelectionOpacity ?? this.rangeSelectionOpacity,
    );
  }
}
