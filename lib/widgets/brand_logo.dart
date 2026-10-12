import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Flower emblem (Arstora logo mark), drawn with CustomPaint.
class BrandMark extends StatelessWidget {
  final double size;
  const BrandMark({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _FlowerPainter()),
    );
  }
}

class _FlowerPainter extends CustomPainter {
  static const _colors = [
    Color(0xFFAE0253),
    Color(0xFFCA3D0C),
    Color(0xFFE7AB1E),
    Color(0xFFBBB62F),
  ];
  static const _petals = 8;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.width / 2;
    for (var i = 0; i < _petals; i++) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(i * 2 * math.pi / _petals);
      final petal = Rect.fromCenter(
        center: Offset(0, -r * 0.52),
        width: r * 0.52,
        height: r * 0.95,
      );
      final color = _colors[i % _colors.length].withAlpha(235);
      canvas.drawOval(petal, Paint()..color = color);
      canvas.restore();
    }
    final cream = Paint()..color = const Color(0xFFFFF6E0);
    final dot = Paint()..color = const Color(0xFFAE0253);
    canvas.drawCircle(center, r * 0.2, cream);
    canvas.drawCircle(center, r * 0.09, dot);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// "Arstora" text with a gradient fill. Uses theme colors unless [colors] is set.
class BrandWordmark extends StatelessWidget {
  final double fontSize;
  final double letterSpacing;
  final List<Color>? colors;

  const BrandWordmark({
    super.key,
    this.fontSize = 24,
    this.letterSpacing = 1.5,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fill = colors ?? [cs.primary, cs.secondary];
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(colors: fill).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        'Arstora',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}