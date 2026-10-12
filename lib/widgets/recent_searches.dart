import 'package:flutter/material.dart';

/// Chips for recent searches (tap to search again, ✕ to remove).
class RecentSearches extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onPick;
  final ValueChanged<String> onRemove;

  const RecentSearches({
    super.key,
    required this.items,
    required this.onPick,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent searches',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (final s in items)
                InputChip(
                  avatar: const Icon(Icons.history, size: 18),
                  label: Text(s),
                  onPressed: () => onPick(s),
                  onDeleted: () => onRemove(s),
                ),
            ],
          ),
        ],
      ),
    );
  }
}