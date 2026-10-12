import 'package:flutter/material.dart';
import '../widgets/featured_banner.dart';

class CategoryChips extends StatelessWidget {
  final List<String> items;
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryChips({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isSelected = items[i] == selected;
          return ChoiceChip(
            label: Text(
              items[i],
              style: TextStyle(
                color: isSelected ? cs.onPrimary : cs.onSurface,
              ),
            ),
            selected: isSelected,
            showCheckmark: false,
            selectedColor: cs.primary,
            onSelected: (_) => onSelected(items[i]),
          );
        },
      ),
    );
  }
}
