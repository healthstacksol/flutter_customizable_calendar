part of 'timeline_theme.dart';

/// Wrapper for the draggable event view customization parameters
class DraggableEventTheme extends Equatable {
  /// Customize the draggable event view with the parameters
  const DraggableEventTheme({
    this.elevation,
    this.sizerTheme = const SizerTheme(),
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.fastOutSlowIn,
    this.dragScrollConfig = const DragScrollConfig(),
    this.enableDragToResize = true,
    this.enableDragToMove = true,
    this.showSizerOnHover = false,
    this.dragFeedbackOpacity = 0.7,
    this.monthViewDefaultTime = const Duration(hours: 12),
    this.monthRowHeightMultiplier = 1.5,
  });

  /// Elevation over a day view
  final double? elevation;

  /// Sizer view's customization parameters
  final SizerTheme sizerTheme;

  /// Duration of the view's animation
  final Duration animationDuration;

  /// Allows to change the animation's behavior
  /// (use a [Curve] which supports changing a value between [0...1])
  final Curve animationCurve;

  /// Configuration for auto-scroll behavior during drag operations.
  final DragScrollConfig dragScrollConfig;

  /// Whether to enable drag-to-resize functionality via sizer handle.
  /// Default: true
  final bool enableDragToResize;

  /// Whether to enable drag-to-move functionality.
  /// Default: true
  final bool enableDragToMove;

  /// Whether to show the sizer handle on hover (web/desktop).
  /// Default: false
  final bool showSizerOnHover;

  /// Opacity of the drag feedback widget.
  /// Default: 0.7
  final double dragFeedbackOpacity;

  /// Default time for events created from month view (no time info).
  /// Default: Duration(hours: 12) - noon
  final Duration monthViewDefaultTime;

  /// Multiplier for month view row height calculation.
  /// Default: 1.5
  final double monthRowHeightMultiplier;

  @override
  List<Object?> get props => [
        elevation,
        sizerTheme,
        animationDuration,
        animationCurve,
        dragScrollConfig,
        enableDragToResize,
        enableDragToMove,
        showSizerOnHover,
        dragFeedbackOpacity,
        monthViewDefaultTime,
        monthRowHeightMultiplier,
      ];

  /// Creates a copy of this theme but with the given fields replaced with
  /// the new values
  DraggableEventTheme copyWith({
    double? elevation,
    SizerTheme? sizerTheme,
    Duration? animationDuration,
    Curve? animationCurve,
    DragScrollConfig? dragScrollConfig,
    bool? enableDragToResize,
    bool? enableDragToMove,
    bool? showSizerOnHover,
    double? dragFeedbackOpacity,
    Duration? monthViewDefaultTime,
    double? monthRowHeightMultiplier,
  }) {
    return DraggableEventTheme(
      elevation: elevation ?? this.elevation,
      sizerTheme: sizerTheme ?? this.sizerTheme,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      dragScrollConfig: dragScrollConfig ?? this.dragScrollConfig,
      enableDragToResize: enableDragToResize ?? this.enableDragToResize,
      enableDragToMove: enableDragToMove ?? this.enableDragToMove,
      showSizerOnHover: showSizerOnHover ?? this.showSizerOnHover,
      dragFeedbackOpacity: dragFeedbackOpacity ?? this.dragFeedbackOpacity,
      monthViewDefaultTime: monthViewDefaultTime ?? this.monthViewDefaultTime,
      monthRowHeightMultiplier:
          monthRowHeightMultiplier ?? this.monthRowHeightMultiplier,
    );
  }
}
