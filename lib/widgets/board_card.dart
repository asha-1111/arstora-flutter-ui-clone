import 'package:flutter/material.dart';
import '../models/pin.dart';

/// Horizontal strip of boards (one per category) on the Saved screen.
class BoardStrip extends StatelessWidget {
  final List<Pin> savedPins;
  const BoardStrip({super.key, required this.savedPins});

  @override
  Widget build(BuildContext context) {
    final boards = categories.skip(1).toList();
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: boards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) => BoardCard(
          name: boards[i],
          count: savedPins.where((p) => p.category == boards[i]).length,
          colors: brandPalettes[i % brandPalettes.length],
        ),
      ),
    );
  }
}

class BoardCard extends StatelessWidget {
  final String name;
  final int count;
  final List<Color> colors;

  const BoardCard({
    super.key,
    required this.name,
    required this.count,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: colors),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '$count pins',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
