import 'package:flutter/material.dart';

/// Light and dark themes based on the Terra palette.
class AppTheme {
  static final light = _build(const ColorScheme.light(
    primary: Color(0xFFAE0253),
    onPrimary: Colors.white,
    secondary: Color(0xFFCA3D0C),
    tertiary: Color(0xFFE7AB1E),
    surface: Color(0xFFFFFBF0),
    onSurface: Color(0xFF1E1A14),
    surfaceContainerHighest: Color(0xFFF1EAD0),
  ));

  static final dark = _build(const ColorScheme.dark(
    primary: Color(0xFFE0407F),
    onPrimary: Colors.white,
    secondary: Color(0xFFE2683A),
    tertiary: Color(0xFFE7AB1E),
    surface: Color(0xFF14110F),
    onSurface: Color(0xFFF5EFE0),
    surfaceContainerHighest: Color(0xFF2A241E),
  ));

  static ThemeData _build(ColorScheme cs) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: cs.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cs.surface,
        indicatorColor: cs.primary.withAlpha(50),
      ),
    );
  }
}
