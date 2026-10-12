import 'package:flutter/material.dart';
import '../models/pin.dart';

/// Holds theme mode and saved pins. Core Flutter only (ChangeNotifier).
class AppState extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;
  final Set<int> _saved = {};

  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;
  int get savedCount => _saved.length;

  List<Pin> get savedPins =>
      samplePins.where((p) => _saved.contains(p.id)).toList();

  bool isSaved(int id) => _saved.contains(id);

  void toggleTheme() {
    _mode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void toggleSave(int id) {
    if (!_saved.remove(id)) _saved.add(id);
    notifyListeners();
  }
}

/// Makes [AppState] available to the whole widget tree.
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppScope>()!
        .notifier!;
  }
}
