import 'package:flutter/material.dart';
import '../models/pin.dart';

/// "Today's inspiration" banner at the top of Home.
class FeaturedBanner extends StatelessWidget {
  final Pin pin;
  final VoidCallback onTap;
  const FeaturedBanner({super.key, required this.pin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 720;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          height: wide ? 220 : 170,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: pin.colors,
            ),
          ),
          child: Row(
            children: [
              Expanded(child: _BannerText(pin: pin)),
              Icon(
                pin.icon,
                size: wide ? 96 : 72,
                color: Colors.white.withAlpha(200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerText extends StatelessWidget {
  final Pin pin;
  const _BannerText({required this.pin});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "TODAY'S INSPIRATION",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            letterSpacing: 1.6,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          pin.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Explore',
            style: TextStyle(
              color: pin.colors.last,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}