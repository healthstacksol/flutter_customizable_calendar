import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_customizable_calendar/src/domain/models/calendar_event.dart';

/// Edge position for the agenda preview drawer.
enum AgendaDrawerEdge {
  /// Slides from the left edge of the screen.
  left,

  /// Slides from the right edge of the screen.
  right,

  /// Slides from the bottom edge of the screen.
  bottom,
}

/// Configuration for the Agenda Preview drawer component.
///
/// The Agenda Preview shows events for the selected date in a slide-out
/// drawer/modal pattern. It slides from a configurable edge of the screen
/// and displays events in a Day view style layout.
class AgendaPreviewTheme extends Equatable {
  /// Creates a new agenda preview theme.
  const AgendaPreviewTheme({
    // Drawer behavior
    this.edge = AgendaDrawerEdge.right,
    this.mobileEdge = AgendaDrawerEdge.bottom,
    this.mobileBreakpoint = 600,
    this.width = 320,
    this.bottomSheetHeight = 0.6,
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeOutCubic,
    this.dismissOnOutsideTap = true,
    this.showOverlay = true,
    this.overlayColor,
    this.overlayOpacity = 0.3,
    // Header
    this.showHeader = true,
    this.headerBackgroundColor,
    this.headerPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    this.dateHeaderStyle,
    this.dateHeaderFormatter,
    this.showCloseButton = true,
    this.closeButtonIcon = Icons.close,
    // Content
    this.backgroundColor,
    this.padding = const EdgeInsets.all(8),
    this.emptyText = 'No events',
    this.emptyTextStyle,
    this.scrollPhysics,
    // Event item styling
    this.eventItemPadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    this.eventItemMargin = const EdgeInsets.symmetric(vertical: 4),
    this.eventItemBackgroundColor,
    this.eventItemBorderRadius = 8,
    this.eventColorBarWidth = 4,
    this.eventColorBarBorderRadius = 2,
    this.eventTitleStyle,
    this.eventTimeStyle,
    this.eventDescriptionStyle,
    this.showEventTime = true,
    this.showEventDescription = false,
    this.eventTimeFormatter,
    this.eventItemBuilder,
    // Shadow/elevation
    this.drawerElevation = 16,
    this.drawerShadowColor,
  });

  // ─────────────────────────────────────────────────────────────────────────
  // Drawer Behavior
  // ─────────────────────────────────────────────────────────────────────────

  /// Edge from which the drawer slides on larger screens.
  /// Default: AgendaDrawerEdge.right
  final AgendaDrawerEdge edge;

  /// Edge from which the drawer slides on mobile devices.
  /// Default: AgendaDrawerEdge.bottom
  final AgendaDrawerEdge mobileEdge;

  /// Screen width breakpoint for mobile behavior.
  /// Below this width, [mobileEdge] is used.
  /// Default: 600
  final double mobileBreakpoint;

  /// Width of the drawer when sliding from left/right.
  /// Default: 320
  final double width;

  /// Height ratio for bottom sheet (0.0 to 1.0).
  /// Default: 0.6 (60% of screen height)
  final double bottomSheetHeight;

  /// Animation duration for slide in/out.
  /// Default: 250ms
  final Duration animationDuration;

  /// Animation curve for slide transitions.
  /// Default: Curves.easeOutCubic
  final Curve animationCurve;

  /// Whether tapping outside the drawer dismisses it.
  /// Default: true
  final bool dismissOnOutsideTap;

  /// Whether to show a semi-transparent overlay behind the drawer.
  /// Default: true
  final bool showOverlay;

  /// Color of the overlay.
  /// If null, uses Colors.black.
  final Color? overlayColor;

  /// Opacity of the overlay (0.0 to 1.0).
  /// Default: 0.3
  final double overlayOpacity;

  // ─────────────────────────────────────────────────────────────────────────
  // Header
  // ─────────────────────────────────────────────────────────────────────────

  /// Whether to show the header with date and close button.
  /// Default: true
  final bool showHeader;

  /// Background color for the header.
  /// If null, uses theme surface color.
  final Color? headerBackgroundColor;

  /// Padding around the header content.
  /// Default: EdgeInsets.symmetric(horizontal: 16, vertical: 12)
  final EdgeInsets headerPadding;

  /// Text style for the date header.
  /// If null, uses theme titleMedium.
  final TextStyle? dateHeaderStyle;

  /// Custom formatter for the date header.
  /// If null, uses "EEEE, MMMM d" format (e.g., "Thursday, December 18").
  final String Function(DateTime)? dateHeaderFormatter;

  /// Whether to show the close button (X icon).
  /// Default: true
  final bool showCloseButton;

  /// Icon for the close button.
  /// Default: Icons.close
  final IconData closeButtonIcon;

  // ─────────────────────────────────────────────────────────────────────────
  // Content
  // ─────────────────────────────────────────────────────────────────────────

  /// Background color for the drawer content area.
  /// If null, uses theme surface color.
  final Color? backgroundColor;

  /// Padding around the event list.
  /// Default: EdgeInsets.all(8)
  final EdgeInsets padding;

  /// Text shown when no events for selected date.
  /// Default: 'No events'
  final String emptyText;

  /// Text style for empty message.
  /// If null, uses theme bodyLarge with outline color.
  final TextStyle? emptyTextStyle;

  /// Scroll physics for the event list.
  /// If null, uses BouncingScrollPhysics.
  final ScrollPhysics? scrollPhysics;

  // ─────────────────────────────────────────────────────────────────────────
  // Event Item Styling
  // ─────────────────────────────────────────────────────────────────────────

  /// Padding inside each event item.
  /// Default: EdgeInsets.symmetric(horizontal: 12, vertical: 8)
  final EdgeInsets eventItemPadding;

  /// Margin around each event item.
  /// Default: EdgeInsets.symmetric(vertical: 4)
  final EdgeInsets eventItemMargin;

  /// Background color for event items.
  /// If null, uses theme surfaceContainerLow.
  final Color? eventItemBackgroundColor;

  /// Border radius for event items.
  /// Default: 8
  final double eventItemBorderRadius;

  /// Width of the colored bar on the left of event items.
  /// Default: 4
  final double eventColorBarWidth;

  /// Border radius for the color bar.
  /// Default: 2
  final double eventColorBarBorderRadius;

  /// Text style for event title.
  /// If null, uses theme bodyMedium with fontWeight 500.
  final TextStyle? eventTitleStyle;

  /// Text style for event time.
  /// If null, uses theme bodySmall with outline color.
  final TextStyle? eventTimeStyle;

  /// Text style for event description.
  /// If null, uses theme bodySmall.
  final TextStyle? eventDescriptionStyle;

  /// Whether to show event time below the title.
  /// Default: true
  final bool showEventTime;

  /// Whether to show event description.
  /// Default: false
  final bool showEventDescription;

  /// Custom formatter for event time display.
  /// If null, uses "HH:mm - duration" format.
  final String Function(CalendarEvent event)? eventTimeFormatter;

  /// Custom builder for event items.
  /// If provided, overrides all event item styling.
  final Widget Function(CalendarEvent event, Color eventColor)?
      eventItemBuilder;

  // ─────────────────────────────────────────────────────────────────────────
  // Shadow/Elevation
  // ─────────────────────────────────────────────────────────────────────────

  /// Elevation/shadow blur for the drawer.
  /// Default: 16
  final double drawerElevation;

  /// Shadow color for the drawer.
  /// If null, uses Colors.black with 0.2 opacity.
  final Color? drawerShadowColor;

  // ─────────────────────────────────────────────────────────────────────────
  // Helper Methods
  // ─────────────────────────────────────────────────────────────────────────

  /// Gets the effective edge based on screen width.
  AgendaDrawerEdge getEffectiveEdge(double screenWidth) {
    return screenWidth < mobileBreakpoint ? mobileEdge : edge;
  }

  /// Gets the slide offset based on edge.
  Offset getSlideBeginOffset(AgendaDrawerEdge drawerEdge) {
    switch (drawerEdge) {
      case AgendaDrawerEdge.left:
        return const Offset(-1, 0);
      case AgendaDrawerEdge.right:
        return const Offset(1, 0);
      case AgendaDrawerEdge.bottom:
        return const Offset(0, 1);
    }
  }

  /// Gets the shadow offset based on edge.
  Offset getShadowOffset(AgendaDrawerEdge drawerEdge) {
    switch (drawerEdge) {
      case AgendaDrawerEdge.left:
        return const Offset(4, 0);
      case AgendaDrawerEdge.right:
        return const Offset(-4, 0);
      case AgendaDrawerEdge.bottom:
        return const Offset(0, -4);
    }
  }

  @override
  List<Object?> get props => [
        edge,
        mobileEdge,
        mobileBreakpoint,
        width,
        bottomSheetHeight,
        animationDuration,
        animationCurve,
        dismissOnOutsideTap,
        showOverlay,
        overlayColor,
        overlayOpacity,
        showHeader,
        headerBackgroundColor,
        headerPadding,
        dateHeaderStyle,
        showCloseButton,
        closeButtonIcon,
        backgroundColor,
        padding,
        emptyText,
        emptyTextStyle,
        scrollPhysics,
        eventItemPadding,
        eventItemMargin,
        eventItemBackgroundColor,
        eventItemBorderRadius,
        eventColorBarWidth,
        eventColorBarBorderRadius,
        eventTitleStyle,
        eventTimeStyle,
        eventDescriptionStyle,
        showEventTime,
        showEventDescription,
        drawerElevation,
        drawerShadowColor,
      ];

  /// Creates a copy of this theme with the given fields replaced.
  AgendaPreviewTheme copyWith({
    AgendaDrawerEdge? edge,
    AgendaDrawerEdge? mobileEdge,
    double? mobileBreakpoint,
    double? width,
    double? bottomSheetHeight,
    Duration? animationDuration,
    Curve? animationCurve,
    bool? dismissOnOutsideTap,
    bool? showOverlay,
    Color? overlayColor,
    double? overlayOpacity,
    bool? showHeader,
    Color? headerBackgroundColor,
    EdgeInsets? headerPadding,
    TextStyle? dateHeaderStyle,
    String Function(DateTime)? dateHeaderFormatter,
    bool? showCloseButton,
    IconData? closeButtonIcon,
    Color? backgroundColor,
    EdgeInsets? padding,
    String? emptyText,
    TextStyle? emptyTextStyle,
    ScrollPhysics? scrollPhysics,
    EdgeInsets? eventItemPadding,
    EdgeInsets? eventItemMargin,
    Color? eventItemBackgroundColor,
    double? eventItemBorderRadius,
    double? eventColorBarWidth,
    double? eventColorBarBorderRadius,
    TextStyle? eventTitleStyle,
    TextStyle? eventTimeStyle,
    TextStyle? eventDescriptionStyle,
    bool? showEventTime,
    bool? showEventDescription,
    String Function(CalendarEvent)? eventTimeFormatter,
    Widget Function(CalendarEvent, Color)? eventItemBuilder,
    double? drawerElevation,
    Color? drawerShadowColor,
  }) {
    return AgendaPreviewTheme(
      edge: edge ?? this.edge,
      mobileEdge: mobileEdge ?? this.mobileEdge,
      mobileBreakpoint: mobileBreakpoint ?? this.mobileBreakpoint,
      width: width ?? this.width,
      bottomSheetHeight: bottomSheetHeight ?? this.bottomSheetHeight,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      dismissOnOutsideTap: dismissOnOutsideTap ?? this.dismissOnOutsideTap,
      showOverlay: showOverlay ?? this.showOverlay,
      overlayColor: overlayColor ?? this.overlayColor,
      overlayOpacity: overlayOpacity ?? this.overlayOpacity,
      showHeader: showHeader ?? this.showHeader,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      headerPadding: headerPadding ?? this.headerPadding,
      dateHeaderStyle: dateHeaderStyle ?? this.dateHeaderStyle,
      dateHeaderFormatter: dateHeaderFormatter ?? this.dateHeaderFormatter,
      showCloseButton: showCloseButton ?? this.showCloseButton,
      closeButtonIcon: closeButtonIcon ?? this.closeButtonIcon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
      emptyText: emptyText ?? this.emptyText,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      scrollPhysics: scrollPhysics ?? this.scrollPhysics,
      eventItemPadding: eventItemPadding ?? this.eventItemPadding,
      eventItemMargin: eventItemMargin ?? this.eventItemMargin,
      eventItemBackgroundColor:
          eventItemBackgroundColor ?? this.eventItemBackgroundColor,
      eventItemBorderRadius:
          eventItemBorderRadius ?? this.eventItemBorderRadius,
      eventColorBarWidth: eventColorBarWidth ?? this.eventColorBarWidth,
      eventColorBarBorderRadius:
          eventColorBarBorderRadius ?? this.eventColorBarBorderRadius,
      eventTitleStyle: eventTitleStyle ?? this.eventTitleStyle,
      eventTimeStyle: eventTimeStyle ?? this.eventTimeStyle,
      eventDescriptionStyle:
          eventDescriptionStyle ?? this.eventDescriptionStyle,
      showEventTime: showEventTime ?? this.showEventTime,
      showEventDescription: showEventDescription ?? this.showEventDescription,
      eventTimeFormatter: eventTimeFormatter ?? this.eventTimeFormatter,
      eventItemBuilder: eventItemBuilder ?? this.eventItemBuilder,
      drawerElevation: drawerElevation ?? this.drawerElevation,
      drawerShadowColor: drawerShadowColor ?? this.drawerShadowColor,
    );
  }
}
