part of 'timeline_theme.dart';

/// How marks should be aligned on the time scale
enum MarksAlign {
  /// Marks are centered
  center,

  /// Marks are aligned on the left side
  left,

  /// Marks are aligned on the right side
  right,
}

/// Position of time labels on the scale
enum TimeScaleLabelPosition {
  /// Labels on the left side only
  left,

  /// Labels on the right side only
  right,

  /// Labels on both sides
  both,

  /// No labels
  none,
}

String _defaultHourFormatter(DateTime value) => DateFormat.Hm().format(value);

/// Wrapper for the TimeScale view customization parameters
class TimeScaleTheme extends Equatable {
  /// Customize the TimeScale with the parameters
  const TimeScaleTheme({
    this.width = 56,
    this.hourExtent = 100,
    this.currentTimeMarkTheme = const TimeMarkTheme(
      length: 48,
      color: Colors.red,
    ),
    this.drawHalfHourMarks = true,
    this.halfHourMarkTheme = const TimeMarkTheme(length: 16),
    this.drawQuarterHourMarks = true,
    this.quarterHourMarkTheme = const TimeMarkTheme(length: 8),
    this.hourFormatter = _defaultHourFormatter,
    this.textStyle = const TextStyle(
      fontSize: 12,
      color: Colors.black,
    ),
    this.marksAlign = MarksAlign.left,
    this.startHour = 0,
    this.endHour = 24,
    this.labelPosition = TimeScaleLabelPosition.left,
    this.showHalfHourLabels = false,
    this.showCurrentTimeMark = true,
    this.backgroundColor,
    this.decoration,
  }) : assert(
          startHour >= 0 && startHour < 24,
          'startHour must be between 0 and 23',
        ),
       assert(
          endHour > 0 && endHour <= 24,
          'endHour must be between 1 and 24',
        ),
       assert(
          startHour < endHour,
          'startHour must be less than endHour',
        );

  /// Width of the view (is needed to set a padding)
  final double width;

  /// Distance between two hours
  final double hourExtent;

  /// Current time mark customization parameters
  final TimeMarkTheme currentTimeMarkTheme;

  /// Whether a half of an hour mark is need to show
  final bool drawHalfHourMarks;

  /// A half of an hour mark customization parameters
  final TimeMarkTheme halfHourMarkTheme;

  /// Whether a quarter of an hour mark is need to show
  final bool drawQuarterHourMarks;

  /// A quarter of an hour mark customization parameters
  final TimeMarkTheme quarterHourMarkTheme;

  /// Hour string formatter
  final DateFormatter hourFormatter;

  /// Hour text style
  final TextStyle? textStyle;

  /// Scale marks alignment
  final MarksAlign marksAlign;

  /// Starting hour for the visible timeline (0-23).
  /// Default: 0 (midnight)
  final int startHour;

  /// Ending hour for the visible timeline (1-24).
  /// Default: 24 (end of day)
  final int endHour;

  /// Position of time labels on the scale.
  /// Default: TimeScaleLabelPosition.left
  final TimeScaleLabelPosition labelPosition;

  /// Whether to show labels at half-hour marks.
  /// Default: false
  final bool showHalfHourLabels;

  /// Whether to show the current time indicator mark.
  /// Default: true
  final bool showCurrentTimeMark;

  /// Background color for the time scale column.
  final Color? backgroundColor;

  /// Custom decoration for the time scale column.
  /// Overrides [backgroundColor] if provided.
  final Decoration? decoration;

  /// Returns the number of visible hours.
  int get visibleHours => endHour - startHour;

  /// Returns the total height of the visible timeline.
  double get totalHeight => visibleHours * hourExtent;

  /// Checks if the given hour is within the visible range.
  bool isHourVisible(int hour) => hour >= startHour && hour < endHour;

  @override
  List<Object?> get props => [
        width,
        hourExtent,
        currentTimeMarkTheme,
        drawHalfHourMarks,
        halfHourMarkTheme,
        drawQuarterHourMarks,
        quarterHourMarkTheme,
        hourFormatter,
        textStyle,
        marksAlign,
        startHour,
        endHour,
        labelPosition,
        showHalfHourLabels,
        showCurrentTimeMark,
        backgroundColor,
        decoration,
      ];

  /// Creates a copy of this theme but with the given fields replaced with
  /// the new values
  TimeScaleTheme copyWith({
    double? width,
    double? hourExtent,
    TimeMarkTheme? currentTimeMarkTheme,
    bool? drawHalfHourMarks,
    TimeMarkTheme? halfHourMarkTheme,
    bool? drawQuarterHourMarks,
    TimeMarkTheme? quarterHourMarkTheme,
    DateFormatter? hourFormatter,
    TextStyle? textStyle,
    MarksAlign? marksAlign,
    int? startHour,
    int? endHour,
    TimeScaleLabelPosition? labelPosition,
    bool? showHalfHourLabels,
    bool? showCurrentTimeMark,
    Color? backgroundColor,
    Decoration? decoration,
  }) {
    return TimeScaleTheme(
      width: width ?? this.width,
      hourExtent: hourExtent ?? this.hourExtent,
      currentTimeMarkTheme: currentTimeMarkTheme ?? this.currentTimeMarkTheme,
      drawHalfHourMarks: drawHalfHourMarks ?? this.drawHalfHourMarks,
      halfHourMarkTheme: halfHourMarkTheme ?? this.halfHourMarkTheme,
      drawQuarterHourMarks: drawQuarterHourMarks ?? this.drawQuarterHourMarks,
      quarterHourMarkTheme: quarterHourMarkTheme ?? this.quarterHourMarkTheme,
      hourFormatter: hourFormatter ?? this.hourFormatter,
      textStyle: textStyle ?? this.textStyle,
      marksAlign: marksAlign ?? this.marksAlign,
      startHour: startHour ?? this.startHour,
      endHour: endHour ?? this.endHour,
      labelPosition: labelPosition ?? this.labelPosition,
      showHalfHourLabels: showHalfHourLabels ?? this.showHalfHourLabels,
      showCurrentTimeMark: showCurrentTimeMark ?? this.showCurrentTimeMark,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      decoration: decoration ?? this.decoration,
    );
  }
}
