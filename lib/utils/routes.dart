import 'package:flutter/material.dart';

/// Reusable slide-in-from-right page transition.
class SlideRoute<T> extends PageRouteBuilder<T> {
  SlideRoute({required Widget page})
      : super(
          transitionDuration: const Duration(milliseconds: 350),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            );
          },
        );
}

/// Reusable fade page transition.
class FadeRoute<T> extends PageRouteBuilder<T> {
  FadeRoute({required Widget page})
      : super(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
        );
}
