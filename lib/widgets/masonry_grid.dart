import 'package:flutter/material.dart';
import '../models/pin.dart';
import 'fade_slide_in.dart';
import 'pin_card.dart';

/// Pinterest-style staggered grid built from core widgets only.
/// LayoutBuilder decides the column count from the available width.
class MasonryGrid extends StatelessWidget {
  final List<Pin> pins;
  final ValueChanged<Pin> onTap;
  const MasonryGrid({super.key, required this.pins, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final cols = (constraints.maxWidth / 190).floor().clamp(2, 6);
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final column in _split(cols))
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    for (final p in column)
                      FadeSlideIn(
                        key: ValueKey(p.id),
                        child: PinCard(pin: p, onTap: () => onTap(p)),
                      ),
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }

  /// Puts each pin into the currently shortest column.
  List<List<Pin>> _split(int cols) {
    final out = List.generate(cols, (_) => <Pin>[]);
    final heights = List.filled(cols, 0.0);
    for (final p in pins) {
      final shortest = heights.reduce((a, b) => a < b ? a : b);
      final i = heights.indexOf(shortest);
      out[i].add(p);
      heights[i] += p.aspect + 0.3;
    }
    return out;
  }
}
