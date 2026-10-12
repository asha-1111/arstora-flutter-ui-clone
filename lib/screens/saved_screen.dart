import 'package:flutter/material.dart';
import '../models/pin.dart';
import '../state/app_state.dart';
import '../widgets/board_card.dart';
import '../widgets/saved_tile.dart';
import 'pin_details_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  /// Removes a pin and offers Undo in a SnackBar.
  void _remove(BuildContext context, AppState state, Pin pin) {
    state.toggleSave(pin.id);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Removed "${pin.title}"'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => state.toggleSave(pin.id),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final pins = state.savedPins;
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: pins.isEmpty
          ? const _EmptySaved()
          : SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Boards', style: t.titleLarge),
            const SizedBox(height: 8),
            BoardStrip(savedPins: pins),
            const SizedBox(height: 20),
            Text('All saved pins (${pins.length})', style: t.titleLarge),
            const Text('Swipe left to remove'),
            const SizedBox(height: 8),
            SavedList(
              pins: pins,
              onTap: (p) => openPin(context, p),
              onRemove: (p) => _remove(context, state, p),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptySaved extends StatelessWidget {
  const _EmptySaved();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.push_pin_outlined, size: 64),
          const SizedBox(height: 12),
          Text('No saved pins yet', style: t.titleMedium),
          const SizedBox(height: 4),
          const Text('Tap the heart on any pin to save it.'),
        ],
      ),
    );
  }
}