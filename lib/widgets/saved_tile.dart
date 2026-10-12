import 'package:flutter/material.dart';
import '../models/pin.dart';
import 'pin_image.dart';

/// List of saved pins; swipe a row to the left to remove it.
class SavedList extends StatelessWidget {
  final List<Pin> pins;
  final ValueChanged<Pin> onTap;
  final ValueChanged<Pin> onRemove;

  const SavedList({
    super.key,
    required this.pins,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final p in pins)
          Dismissible(
            key: ValueKey('saved-${p.id}'),
            direction: DismissDirection.endToStart,
            background: const _SwipeBackground(),
            onDismissed: (_) => onRemove(p),
            child: SavedTile(pin: p, onTap: () => onTap(p)),
          ),
      ],
    );
  }
}

class SavedTile extends StatelessWidget {
  final Pin pin;
  final VoidCallback onTap;
  const SavedTile({super.key, required this.pin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: onTap,
          leading: Hero(
            tag: pin.heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 56,
                height: 56,
                child: PinImage(pin: pin),
              ),
            ),
          ),
          title: Text(pin.title),
          subtitle: Text(pin.category),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

class _SwipeBackground extends StatelessWidget {
  const _SwipeBackground();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: cs.error,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(Icons.delete_outline, color: cs.onError),
    );
  }
}