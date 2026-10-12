import 'package:flutter/material.dart';
import '../models/pin.dart';

/// Gradient "photo" placeholder, so the app works fully offline.
/// Swap for Image.asset(...) if you add real pictures.
class PinImage extends StatelessWidget {
  final Pin pin;
  const PinImage({super.key, required this.pin});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: pin.colors,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: -30,
            bottom: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(35),
              ),
            ),
          ),
          Center(
            child: Icon(
              pin.icon,
              size: 44,
              color: Colors.white.withAlpha(230),
            ),
          ),
        ],
      ),
    );
  }
}
