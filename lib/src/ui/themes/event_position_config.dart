import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Strategy for handling overlapping events.
enum OverlapStrategy {
  /// Events cascade to the right (current default behavior).
  cascade,

  /// Events stack vertically within the same time slot.
  stack,

  /// Events divide the available width equally.
  sideBySide,

  /// Use a custom builder for overlap handling.
  custom,
}

/// Configuration for event positioning and layout in timeline views.
///
/// Controls how events are positioned on the grid, including overlap handling,
/// snapping behavior, and margin/padding settings.
class EventPositionConfig extends Equatable {
  /// Creates a new event position configuration.
  const EventPositionConfig({
    this.minVisibleDuration = 15,
    this.snapToGrid = true,
    this.snapInterval = 15,
    this.eventMargin = const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
    this.clipToVisibleHours = false,
    this.overlapCascadeOffset = 10.0,
    this.overlapStrategy = OverlapStrategy.cascade,
    this.maxCascadeDepth,
    this.minEventWidth = 40.0,
    this.maxEventWidth,
    this.eventSpacing = 2.0,
    this.allowPartialVisibility = true,
    this.minVisibleHeight = 20.0,
  });

  /// Minimum visible duration in minutes for events to display.
  /// Events shorter than this will be rendered at this minimum height.
  /// Default: 15
  final int minVisibleDuration;

  /// Whether to snap events to the grid when positioning.
  /// Default: true
  final bool snapToGrid;

  /// Grid snap interval in minutes.
  /// Default: 15
  final int snapInterval;

  /// Margin around each event within its cell.
  /// Default: EdgeInsets.symmetric(horizontal: 2, vertical: 1)
  final EdgeInsets eventMargin;

  /// Whether to clip events that extend past visible hours.
  /// Default: false
  final bool clipToVisibleHours;

  /// Horizontal offset in pixels for cascading overlapped events.
  /// Default: 10.0px
  final double overlapCascadeOffset;

  /// Strategy for handling overlapping events.
  /// Default: OverlapStrategy.cascade
  final OverlapStrategy overlapStrategy;

  /// Maximum number of cascade levels before events stack.
  /// If null, cascading continues indefinitely.
  final int? maxCascadeDepth;

  /// Minimum width for events in pixels.
  /// Default: 40.0
  final double minEventWidth;

  /// Maximum width for events in pixels.
  /// If null, events can expand to fill available space.
  final double? maxEventWidth;

  /// Spacing between adjacent events in pixels.
  /// Default: 2.0
  final double eventSpacing;

  /// Whether events can be partially visible at view edges.
  /// Default: true
  final bool allowPartialVisibility;

  /// Minimum visible height for events in pixels.
  /// Events will not be rendered smaller than this.
  /// Default: 20.0
  final double minVisibleHeight;

  /// Calculates the effective width for an event at a given cascade depth.
  double getEventWidth({
    required double availableWidth,
    required int cascadeDepth,
  }) {
    if (overlapStrategy == OverlapStrategy.sideBySide) {
      // Divide equally
      return availableWidth / (cascadeDepth + 1);
    }

    // Cascade strategy - reduce width by offset
    final width = availableWidth - (cascadeDepth * overlapCascadeOffset);
    if (maxEventWidth != null && width > maxEventWidth!) {
      return maxEventWidth!;
    }
    return width.clamp(minEventWidth, availableWidth);
  }

  /// Calculates the horizontal offset for an event at a given cascade depth.
  double getHorizontalOffset(int cascadeDepth) {
    if (overlapStrategy == OverlapStrategy.sideBySide) {
      return 0; // Handled by width division
    }
    return cascadeDepth * overlapCascadeOffset;
  }

  @override
  List<Object?> get props => [
        minVisibleDuration,
        snapToGrid,
        snapInterval,
        eventMargin,
        clipToVisibleHours,
        overlapCascadeOffset,
        overlapStrategy,
        maxCascadeDepth,
        minEventWidth,
        maxEventWidth,
        eventSpacing,
        allowPartialVisibility,
        minVisibleHeight,
      ];

  /// Creates a copy of this config with the given fields replaced.
  EventPositionConfig copyWith({
    int? minVisibleDuration,
    bool? snapToGrid,
    int? snapInterval,
    EdgeInsets? eventMargin,
    bool? clipToVisibleHours,
    double? overlapCascadeOffset,
    OverlapStrategy? overlapStrategy,
    int? maxCascadeDepth,
    double? minEventWidth,
    double? maxEventWidth,
    double? eventSpacing,
    bool? allowPartialVisibility,
    double? minVisibleHeight,
  }) {
    return EventPositionConfig(
      minVisibleDuration: minVisibleDuration ?? this.minVisibleDuration,
      snapToGrid: snapToGrid ?? this.snapToGrid,
      snapInterval: snapInterval ?? this.snapInterval,
      eventMargin: eventMargin ?? this.eventMargin,
      clipToVisibleHours: clipToVisibleHours ?? this.clipToVisibleHours,
      overlapCascadeOffset: overlapCascadeOffset ?? this.overlapCascadeOffset,
      overlapStrategy: overlapStrategy ?? this.overlapStrategy,
      maxCascadeDepth: maxCascadeDepth ?? this.maxCascadeDepth,
      minEventWidth: minEventWidth ?? this.minEventWidth,
      maxEventWidth: maxEventWidth ?? this.maxEventWidth,
      eventSpacing: eventSpacing ?? this.eventSpacing,
      allowPartialVisibility:
          allowPartialVisibility ?? this.allowPartialVisibility,
      minVisibleHeight: minVisibleHeight ?? this.minVisibleHeight,
    );
  }
}
