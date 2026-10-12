import 'package:flutter/material.dart';
import '../models/pin.dart';
import '../utils/routes.dart';
import '../widgets/masonry_grid.dart';
import '../widgets/pin_image.dart';
import '../widgets/save_button.dart';
import '../widgets/theme_toggle.dart';
import 'full_image_screen.dart';

/// Opens the details screen with a slide transition.
void openPin(BuildContext context, Pin pin) {
  Navigator.of(context).push(SlideRoute(page: PinDetailsScreen(pin: pin)));
}

class PinDetailsScreen extends StatelessWidget {
  final Pin pin;
  const PinDetailsScreen({super.key, required this.pin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [ThemeToggle()]),
      body: LayoutBuilder(builder: (context, constraints) {
        final image = _DetailImage(pin: pin);
        final info = _PinInfo(pin: pin);
        if (constraints.maxWidth >= 800) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: image,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: info,
                ),
              ),
            ],
          );
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [image, const SizedBox(height: 16), info],
        );
      }),
    );
  }
}

class _DetailImage extends StatelessWidget {
  final Pin pin;
  const _DetailImage({required this.pin});

  void _zoom(BuildContext context) {
    Navigator.of(context).push(FadeRoute(page: FullImageScreen(pin: pin)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _zoom(context),
      child: Stack(
        children: [
          Hero(
            tag: pin.heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AspectRatio(
                aspectRatio: 1 / pin.aspect,
                child: PinImage(pin: pin),
              ),
            ),
          ),
          const Positioned(right: 12, bottom: 12, child: _ZoomBadge()),
        ],
      ),
    );
  }
}

class _ZoomBadge extends StatelessWidget {
  const _ZoomBadge();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: Colors.white.withAlpha(225),
      child: const Icon(Icons.zoom_out_map, size: 18, color: Colors.black87),
    );
  }
}

class _PinInfo extends StatelessWidget {
  final Pin pin;
  const _PinInfo({required this.pin});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final related = samplePins
        .where((p) => p.id != pin.id && p.category == pin.category)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
            child: Text(
              pin.title,
              style: t.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SaveButton(pin: pin),
        ]),
        _AuthorRow(author: pin.author),
        Text(pin.description, style: t.bodyLarge),
        const SizedBox(height: 24),
        Text('More like this', style: t.titleMedium),
        const SizedBox(height: 8),
        MasonryGrid(pins: related, onTap: (p) => openPin(context, p)),
      ],
    );
  }
}

class _AuthorRow extends StatelessWidget {
  final String author;
  const _AuthorRow({required this.author});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(child: Text(author[0])),
      title: Text(author),
      subtitle: const Text('1.2k followers'),
      trailing: OutlinedButton(
        onPressed: () {},
        child: const Text('Follow'),
      ),
    );
  }
}
