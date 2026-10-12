# Arstora: Where ideas become inspiration (Flutter UI clone)

A five-screen Pinterest clone built with **core Flutter widgets only** (no third-party packages, no backend).
Styled with a custom "Terra" palette (#BBB62F, #AE0253, #CA3D0C, #E7AB1E).

## Screens
0. **Splash**: animated Arstora intro (logo, wordmark, tagline), then fades into the app
1. **Home**: category chips and staggered (masonry) pin feed
2. **Search**: search bar, topic tiles, live results
3. **Pin Details**: Hero image, save, follow, "More like this"
4. **Saved**: boards strip and saved-pins grid (empty state included)
5. **Profile**: stats, dark mode switch, settings list

## Requirements checklist
| Requirement | Where |
|---|---|
| 5+ screens | `lib/screens/` |
| Reusable components | `lib/widgets/` (PinCard, MasonryGrid, SaveButton, CategoryChips, AppSearchBar, ThemeToggle, TopicGrid, BoardCard) |
| build() <= 50 lines | every widget is split into small classes |
| MediaQuery | `home_screen.dart`, `profile_screen.dart` |
| LayoutBuilder | `masonry_grid.dart`, `app_shell.dart`, `pin_details_screen.dart` |
| Page transitions | `utils/routes.dart` (SlideRoute, FadeRoute), Hero image, AnimatedSwitcher on tabs |
| Dark/light toggle | `ThemeToggle` + Profile switch, themes in `theme/app_theme.dart` |
| State | `ChangeNotifier` + `InheritedNotifier` (core Flutter) |

## Run
```bash
flutter create .      # generates android/ios/web folders (keeps lib/ and pubspec.yaml)
flutter pub get
flutter run -d chrome
```

## Structure
```
lib/
  main.dart
  models/pin.dart
  state/app_state.dart
  theme/app_theme.dart
  utils/routes.dart
  screens/   (app_shell, home, search, pin_details, saved, profile)
  widgets/   (reusable components)
```
