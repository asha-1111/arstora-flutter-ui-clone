import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() => runApp(const PinterestCloneApp());

class PinterestCloneApp extends StatefulWidget {
  const PinterestCloneApp({super.key});

  @override
  State<PinterestCloneApp> createState() => _PinterestCloneAppState();
}

class _PinterestCloneAppState extends State<PinterestCloneApp> {
  final AppState _state = AppState();

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _state,
      child: ListenableBuilder(
        listenable: _state,
        builder: (context, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Arstora',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: _state.mode,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
