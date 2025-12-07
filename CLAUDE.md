# flutter_customizable_calendar Fork - Development Instructions

## Project Context

This is a **forked customization project** of flutter_customizable_calendar. The goal is to strip down hard-coded theming/UX elements while preserving drag-and-drop functionality.

**Reference Documents:**
- `CUSTOMIZATION_PLAN.md` - 8-phase implementation roadmap
- `CRUFT_CANDIDATES.md` - Code removal/simplification candidates

---

## Autonomous Execution Permissions

### Allowed Operations (No Confirmation Required)

**File Operations:**
- Read, write, edit ANY file in this repository
- Create new theme classes in `lib/src/ui/themes/`
- Create new configuration classes in `lib/src/domain/models/`
- Modify existing views in `lib/src/ui/views/`
- Modify custom widgets in `lib/src/ui/custom_widgets/`
- Update exports in barrel files (`themes.dart`, `views.dart`, etc.)

**Code Quality Commands:**
- `flutter analyze` - Run static analysis
- `flutter test` - Run all tests
- `flutter pub get` - Update dependencies
- `dart format` - Format code
- `dart fix --apply` - Apply automated fixes

**Git Operations:**
- `git status`, `git diff`, `git log` - Read operations
- `git add` - Stage changes
- `git commit` - Commit with descriptive messages
- `git branch`, `git checkout` - Branch management
- `git push`, `git pull`, `git fetch` - Remote operations
- `git stash`, `git stash pop` - Stash operations

**Analysis Commands:**
- `find`, `grep`, `wc` - File searching and counting
- `cat`, `head`, `tail` - File viewing

---

## Quality Requirements

### Before Any Commit

1. **Run `flutter analyze`** - Must pass with zero warnings
   - Info-level deprecation notices are acceptable
   - Warnings or errors MUST be fixed

2. **Run `flutter test`** - All tests must pass
   - If adding new functionality, add corresponding tests
   - If modifying existing code, ensure existing tests pass

3. **Code Style**
   - Follow existing patterns in the codebase
   - Use `dart format` before committing
   - Maintain consistent naming conventions

---

## Development Workflow

### When Implementing Plan Phases

1. **Read the relevant phase** from `CUSTOMIZATION_PLAN.md`
2. **Create a feature branch** for the phase: `git checkout -b phase-N-description`
3. **Implement changes** following the phase deliverables
4. **Run quality checks** before committing
5. **Commit with descriptive message** referencing the phase

### Commit Message Format

```
Phase N: Brief description

- Specific change 1
- Specific change 2

Refs: CUSTOMIZATION_PLAN.md Phase N
```

---

## Critical Preservation Rules

### NEVER Modify (Without Explicit Approval)

These components are critical for drag-and-drop functionality:

1. **Core D&D Logic** (`draggable_event_overlay.dart`)
   - `onEventLongPressStart` method
   - `_timelineHitTest` method
   - `_getTimePointAt` method
   - `_updateEventOriginAndStart` method

2. **Hit Testing Infrastructure**
   - `RenderIdProvider` class
   - `Constants.elevatedEventId`, `sizerId`, `layoutId`
   - `RenderId` generic class

3. **Critical Formulas**
   ```dart
   // Time snapping - DO NOT MODIFY
   (minutes / _cellExtent).round() * _cellExtent

   // Minute extent - DO NOT MODIFY
   size.height / Duration.minutesPerDay
   ```

4. **State Management**
   - `FloatingEventNotifier` class
   - `RectNotifier` class
   - View controller state classes

### Safe to Modify

- Theme classes (add properties, change defaults)
- Hard-coded values (extract to configuration)
- Widget rendering (use theme values)
- Animation durations (make configurable)
- Color values (make themeable)

---

## Testing After Changes

### Drag-Drop Verification Checklist

After any modification to views or event handling:

- [ ] Long-press initiates drag in Days view
- [ ] Long-press initiates drag in Week view
- [ ] Long-press initiates drag in Month view
- [ ] Drag to new time works
- [ ] Drag to new day works (Week view)
- [ ] Event resize via sizer handle works
- [ ] Auto-scroll during drag works
- [ ] Event snaps to grid on drop
- [ ] Save/discard callbacks fire

### Run Full Test Suite

```bash
flutter test
```

---

## File Organization

When creating new files:

```
lib/src/ui/themes/
├── animation_config.dart      # NEW: Animation durations
├── grid_cell_theme.dart       # NEW: Cell/grid styling
├── drag_scroll_config.dart    # NEW: Drag scroll behavior
└── [existing theme files]

lib/src/domain/models/
├── visible_days_config.dart   # NEW: Day filtering
├── time_increment_config.dart # NEW: Custom time marks
└── [existing model files]
```

---

## Dependency Notes

**Do Not Remove:**
- `flutter_bloc` - Core state management
- `equatable` - Event equality
- `intl` - Date formatting
- `clock` - Time utilities

**Can Remove If ScheduleListView Removed:**
- `scrollable_positioned_list`

**Can Remove If Simplifying Animations:**
- `animations` (evaluate usage first)
