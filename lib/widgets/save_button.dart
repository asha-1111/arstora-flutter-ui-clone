import 'package:flutter/material.dart';
import '../models/pin.dart';
import '../state/app_state.dart';

/// Wishlist button. Compact = heart icon on cards, full = "Save" button.
class SaveButton extends StatelessWidget {
  final Pin pin;
  final bool compact;
  const SaveButton({super.key, required this.pin, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final saved = state.isSaved(pin.id);
    final cs = Theme.of(context).colorScheme;
    void toggle() => state.toggleSave(pin.id);

    if (compact) {
      return IconButton.filled(
        onPressed: toggle,
        visualDensity: VisualDensity.compact,
        style: IconButton.styleFrom(
          backgroundColor: saved ? cs.primary : Colors.white.withAlpha(225),
          foregroundColor: saved ? cs.onPrimary : Colors.black87,
        ),
        icon: Icon(saved ? Icons.favorite : Icons.favorite_border, size: 18),
      );
    }
    return FilledButton.icon(
      onPressed: toggle,
      icon: Icon(saved ? Icons.check : Icons.push_pin_outlined),
      label: Text(saved ? 'Saved' : 'Save'),
    );
  }
}
