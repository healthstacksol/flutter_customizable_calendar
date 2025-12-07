# Cruft Candidates for Review

This document lists code elements that may be unnecessary for the target application (preptime) and can potentially be removed or simplified.

---

## Removal Candidates

### 1. TaskDue Event Type

**Location:** `lib/src/domain/models/calendar_event.dart:105-131`

**Purpose:** A specialized event type representing a task due at a specific point in time (zero duration or whole day).

**Why Candidate for Removal:**
- Specialized use case not needed for lesson scheduling
- The `wholeDay` flag complicates rendering logic
- SimpleEvent with 0 duration could serve same purpose

**Dependencies:**
- `lib/src/ui/custom_widgets/events/task_due_view.dart` - Rendering widget
- `lib/src/ui/custom_widgets/events/events.dart` - Export

**Impact if Removed:**
- Remove TaskDue class
- Remove TaskDueView widget
- Update EventView._createBody map
- Minor: ~50 lines removed

---

### 2. Break Event Type (Hatched Block)

**Location:** `lib/src/domain/models/calendar_event.dart:95-103`

**Purpose:** Non-editable event displayed with hatched pattern, typically representing unavailable time.

**Why Candidate for Removal:**
- Preptime likely uses different unavailability representation
- The hatched CustomPainter is fairly specialized
- Could be replaced with CalendarEvent subclass + custom builder

**Dependencies:**
- `lib/src/ui/custom_widgets/events/break_view.dart` - Hatched rendering
- `lib/src/ui/custom_widgets/events_layout.dart:146-151` - Special layout handling
- Schedule list view break handling

**Impact if Removed:**
- Remove Break class
- Remove BreakView widget (with _HatchingPainter)
- Simplify EventsLayout to only handle FloatingCalendarEvent
- ~100 lines removed

**Alternative:** Keep Break but make hatching pattern themeable

---

### 3. ScheduleListView

**Location:** `lib/src/ui/views/schedule_list_view/schedule_list_view.dart`

**Purpose:** Agenda-style list view showing events grouped by day.

**Why Candidate for Review:**
- Preptime may not need this view
- Uses ScrollablePositionedList (external dependency)
- Has its own controller and theme system

**Dependencies:**
- `lib/src/ui/controllers/schedule_list_view_controller.dart`
- `lib/src/ui/controllers/schedule_list_view_controller_state.dart`
- `lib/src/ui/themes/schedule_list_view_theme.dart`
- `lib/src/utils/positioned_list_utils.dart`
- `scrollable_positioned_list` package dependency

**Impact if Removed:**
- Remove entire schedule_list_view folder
- Remove controller and state files
- Remove theme file
- Remove positioned_list_utils.dart
- Could remove `scrollable_positioned_list` dependency
- ~500+ lines removed

**Recommendation:** Keep as optional export, don't remove entirely

---

## Simplification Candidates

### 4. DisplayedPeriodPicker Theme Hierarchy

**Location:**
- `lib/src/ui/themes/displayed_period_picker_theme.dart`
- `lib/src/ui/themes/displayed_period_picker_button_theme.dart`

**Current Structure:**
```dart
DisplayedPeriodPickerTheme
├── margin, elevation, backgroundColor, foregroundColor
├── shape, width, height
├── periodFormatter, textStyle
├── prevButtonTheme: DisplayedPeriodPickerButtonTheme
└── nextButtonTheme: DisplayedPeriodPickerButtonTheme

DisplayedPeriodPickerButtonTheme
├── color, padding, borderRadius
└── child: Widget
```

**Why Candidate for Simplification:**
- Two separate classes for essentially one component
- prevButtonTheme and nextButtonTheme often identical
- Could be merged into single theme with button styling

**Proposed Simplification:**
```dart
DisplayedPeriodPickerTheme
├── // existing properties
├── buttonColor, buttonPadding, buttonBorderRadius
├── prevButtonIcon, nextButtonIcon (optional overrides)
```

**Impact:** ~50 lines reduced, simpler API

---

### 5. DaysListTheme / DaysListItemTheme Separation

**Location:**
- `lib/src/ui/themes/days_list_theme.dart`
- `lib/src/ui/themes/days_list_item_theme.dart`

**Current Structure:**
```dart
DaysListTheme
├── padding, height, physics, itemExtent
└── itemTheme: DaysListItemTheme

DaysListItemTheme (25+ properties)
├── margin, elevation
├── background, backgroundFocused
├── foreground, foregroundFocused
├── shape, shapeFocused
├── numberFormatter, numberStyle, numberStyleFocused
├── hideWeekday, weekdayFormatter
└── weekdayStyle, weekdayStyleFocused
```

**Why Candidate for Simplification:**
- DaysListTheme is very thin (5 properties)
- Could merge into DaysListItemTheme
- Reduce nesting

**Alternative:** Keep separate but document clearly

---

### 6. Saver Widget

**Location:** `lib/src/ui/custom_widgets/saver.dart`

**Purpose:** Floating action button for confirming event edits after drag/drop.

**Why Candidate for Review:**
- Preptime may auto-save or use different confirmation UI
- SaverConfig allows custom child widget
- The positioning is hard-coded (uses Alignment)

**Dependencies:**
- `DraggableEventOverlay` uses SaverConfig
- Appears after `_edited = true` state

**Recommendation:** Keep but:
- Make entirely optional via flag
- Allow full position customization
- Consider callback-only mode (no UI)

---

### 7. SimpleAllDayEventView

**Location:** `lib/src/ui/custom_widgets/events/simple_all_day_event_view.dart`

**Purpose:** Default rendering for all-day events.

**Why Candidate for Review:**
- Very simple widget (just Container with Text)
- Event builders can override entirely
- May not need dedicated view

**Contents:**
```dart
Container(
  height: 24,  // Hard-coded
  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),  // Hard-coded
  child: Text(event.title, style: theme.textStyle),
)
```

**Recommendation:** Keep but extract hard-coded values to theme

---

## Hard-Coded Values to Theme Classes

These aren't "cruft" but should be moved to configurable options:

### In SimpleEventView (`simple_event_view.dart`)

```dart
// Lines 41-58 - Hard-coded padding per view type
EdgeInsets _getPadding() {
  switch (viewType) {
    case CalendarView.days:
      return const EdgeInsets.symmetric(vertical: 4, horizontal: 8);
    case CalendarView.week:
      return const EdgeInsets.symmetric(vertical: 4);
    // ...
  }
}
```

**Action:** Move to ViewEventTheme

### In TaskDueView (`task_due_view.dart`)

```dart
// Lines 26-31 - Hard-coded padding and text
padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
child: Text('Task Due', ...) // Hard-coded text!
```

**Action:** If keeping TaskDue, make text configurable

### In BreakView (`break_view.dart`)

```dart
// Line 11 - Default stroke width
this.strokeWidth = 5,
```

**Action:** Move to theme if keeping Break

---

## Unused/Dead Code

### ClockNotifier Singleton

**Location:** `lib/src/utils/clock_notifier.dart`

Uses `clock` package but creates singleton per call:
```dart
static ClockNotifier instance() => ClockNotifier._();
```

**Issue:** Not truly a singleton, creates new instance each call.

**Action:** Fix singleton pattern or use proper service locator

### NumExtension

**Location:** `lib/src/utils/num.dart`

Contains `comparePrecision` extension used only in `schedule_list_view.dart`.

**Action:** If removing ScheduleListView, remove this file

---

## Summary Table

| Item | Type | Lines | Recommendation |
|------|------|-------|----------------|
| TaskDue | Event type | ~50 | Remove |
| Break | Event type | ~100 | Keep but simplify |
| ScheduleListView | View | ~500 | Keep as optional |
| DisplayedPeriodPickerTheme split | Theme | ~50 | Merge |
| DaysListTheme/ItemTheme | Theme | - | Keep separate |
| Saver | Widget | ~60 | Keep, make optional |
| SimpleAllDayEventView | Widget | ~30 | Keep, fix hard-coded |
| ClockNotifier singleton | Utility | ~30 | Fix pattern |
| NumExtension | Utility | ~15 | Conditional on ScheduleListView |

**Total potential reduction:** ~750+ lines if aggressive cleanup

---

## Decision Required

Before removing any code:

1. **Confirm TaskDue not needed** - Does preptime have due-date-only events?
2. **Confirm Break replacement strategy** - How will unavailable time be shown?
3. **Confirm ScheduleListView not needed** - Any agenda view requirements?
4. **Confirm auto-save vs Saver** - How should event edits be confirmed?
