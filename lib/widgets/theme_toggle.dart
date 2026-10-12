import 'package:flutter/material.dart';
import '../state/app_state.dart';

/// Sun / moon button that switches between light and dark mode.
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return IconButton(
      tooltip: 'Toggle theme',
      onPressed: state.toggleTheme,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) => RotationTransition(
          turns: anim,
          child: FadeTransition(opacity: anim, child: child),
        ),
        child: Icon(
          state.isDark ? Icons.light_mode : Icons.dark_mode,
          key: ValueKey(state.isDark),
        ),
      ),
    );
  }
}
