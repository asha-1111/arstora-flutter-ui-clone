import 'package:flutter/material.dart';
import '../models/pin.dart';
import 'pin_image.dart';
import 'save_button.dart';

/// One reusable pin tile used on Home, Search, Saved and Details.
class PinCard extends StatelessWidget {
  final Pin pin;
  final VoidCallback onTap;
  const PinCard({super.key, required this.pin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: pin.heroTag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 1 / pin.aspect,
                      child: PinImage(pin: pin),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: SaveButton(pin: pin, compact: true),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 6, 4, 0),
              child: Text(
                pin.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
