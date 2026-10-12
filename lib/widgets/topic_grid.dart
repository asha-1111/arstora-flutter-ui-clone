import 'package:flutter/material.dart';
import '../models/pin.dart';

/// "Ideas for you" tiles on the Search screen.
class TopicGrid extends StatelessWidget {
  final ValueChanged<String> onPick;
  const TopicGrid({super.key, required this.onPick});

  @override
  Widget build(BuildContext context) {
    final topics = categories.skip(1).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Text(
            'Ideas for you',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 240,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.7,
            ),
            itemCount: topics.length,
            itemBuilder: (context, i) => TopicTile(
              label: topics[i],
              colors: brandPalettes[i % brandPalettes.length],
              onTap: () => onPick(topics[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class TopicTile extends StatelessWidget {
  final String label;
  final List<Color> colors;
  final VoidCallback onTap;

  const TopicTile({
    super.key,
    required this.label,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: colors),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
