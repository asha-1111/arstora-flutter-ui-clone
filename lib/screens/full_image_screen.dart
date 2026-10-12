import 'package:flutter/material.dart';
import '../models/pin.dart';
import '../widgets/pin_image.dart';

/// Full-screen image with pinch / scroll zoom.
class FullImageScreen extends StatelessWidget {
  final Pin pin;
  const FullImageScreen({super.key, required this.pin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pin.title), leading: const CloseButton()),
      body: Center(
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: AspectRatio(
              aspectRatio: 1 / pin.aspect,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: PinImage(pin: pin),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text('Pinch or scroll to zoom', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}