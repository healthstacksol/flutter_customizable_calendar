import 'package:equatable/equatable.dart';

/// Configuration for auto-scroll behavior during drag operations.
///
/// Controls when and how the calendar auto-scrolls when dragging events
/// near the edges of the visible area.
class DragScrollConfig extends Equatable {
  /// Creates a new drag scroll configuration.
  const DragScrollConfig({
    this.detectionArea = 25.0,
    this.moveDistance = 5.0,
    this.scrollInterval = const Duration(milliseconds: 100),
    this.enableAutoScroll = true,
    this.topEdgeDetectionArea,
    this.bottomEdgeDetectionArea,
    this.leftEdgeDetectionArea,
    this.rightEdgeDetectionArea,
    this.accelerateNearEdge = false,
    this.maxMoveDistance = 20.0,
  });

  /// Distance from edge in pixels that triggers auto-scroll.
  /// Default: 25.0px
  final double detectionArea;

  /// Distance to scroll per interval in pixels.
  /// Default: 5.0px
  final double moveDistance;

  /// Time interval between auto-scroll steps.
  /// Default: 100ms
  final Duration scrollInterval;

  /// Whether auto-scroll is enabled during drag.
  /// Default: true
  final bool enableAutoScroll;

  /// Optional: Custom detection area for top edge.
  /// If null, uses [detectionArea].
  final double? topEdgeDetectionArea;

  /// Optional: Custom detection area for bottom edge.
  /// If null, uses [detectionArea].
  final double? bottomEdgeDetectionArea;

  /// Optional: Custom detection area for left edge.
  /// If null, uses [detectionArea].
  final double? leftEdgeDetectionArea;

  /// Optional: Custom detection area for right edge.
  /// If null, uses [detectionArea].
  final double? rightEdgeDetectionArea;

  /// Whether to accelerate scrolling closer to the edge.
  /// Default: false
  final bool accelerateNearEdge;

  /// Maximum scroll distance when [accelerateNearEdge] is enabled.
  /// Default: 20.0px
  final double maxMoveDistance;

  /// Gets the effective detection area for the top edge.
  double get effectiveTopDetection => topEdgeDetectionArea ?? detectionArea;

  /// Gets the effective detection area for the bottom edge.
  double get effectiveBottomDetection =>
      bottomEdgeDetectionArea ?? detectionArea;

  /// Gets the effective detection area for the left edge.
  double get effectiveLeftDetection => leftEdgeDetectionArea ?? detectionArea;

  /// Gets the effective detection area for the right edge.
  double get effectiveRightDetection => rightEdgeDetectionArea ?? detectionArea;

  @override
  List<Object?> get props => [
        detectionArea,
        moveDistance,
        scrollInterval,
        enableAutoScroll,
        topEdgeDetectionArea,
        bottomEdgeDetectionArea,
        leftEdgeDetectionArea,
        rightEdgeDetectionArea,
        accelerateNearEdge,
        maxMoveDistance,
      ];

  /// Creates a copy of this config with the given fields replaced.
  DragScrollConfig copyWith({
    double? detectionArea,
    double? moveDistance,
    Duration? scrollInterval,
    bool? enableAutoScroll,
    double? topEdgeDetectionArea,
    double? bottomEdgeDetectionArea,
    double? leftEdgeDetectionArea,
    double? rightEdgeDetectionArea,
    bool? accelerateNearEdge,
    double? maxMoveDistance,
  }) {
    return DragScrollConfig(
      detectionArea: detectionArea ?? this.detectionArea,
      moveDistance: moveDistance ?? this.moveDistance,
      scrollInterval: scrollInterval ?? this.scrollInterval,
      enableAutoScroll: enableAutoScroll ?? this.enableAutoScroll,
      topEdgeDetectionArea: topEdgeDetectionArea ?? this.topEdgeDetectionArea,
      bottomEdgeDetectionArea:
          bottomEdgeDetectionArea ?? this.bottomEdgeDetectionArea,
      leftEdgeDetectionArea:
          leftEdgeDetectionArea ?? this.leftEdgeDetectionArea,
      rightEdgeDetectionArea:
          rightEdgeDetectionArea ?? this.rightEdgeDetectionArea,
      accelerateNearEdge: accelerateNearEdge ?? this.accelerateNearEdge,
      maxMoveDistance: maxMoveDistance ?? this.maxMoveDistance,
    );
  }
}
