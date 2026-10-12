import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/routes.dart';
import '../widgets/brand_logo.dart';
import 'app_shell.dart';

/// First screen: animated Arstora intro, then fades into the app.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2800),
  )..forward();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 3300), _goNext);
  }

  void _goNext() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(FadeRoute(page: const AppShell()));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1409),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _GlowBackground(),
          Center(child: _SplashContent(animation: _controller)),
          Positioned(
            left: 0,
            right: 0,
            bottom: 48,
            child: _ProgressLine(animation: _controller),
          ),
        ],
      ),
    );
  }
}

class _GlowBackground extends StatelessWidget {
  const _GlowBackground();

  Widget _glow(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withAlpha(110), color.withAlpha(0)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0F1409), Color(0xFF1B2208)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -120,
            left: -100,
            child: _glow(const Color(0xFFBBB62F), 360),
          ),
          Positioned(
            bottom: -140,
            right: -120,
            child: _glow(const Color(0xFF6B7312), 400),
          ),
        ],
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  final Animation<double> animation;
  const _SplashContent({required this.animation});

  Animation<double> _step(double a, double b, [Curve c = Curves.easeOut]) {
    return CurvedAnimation(parent: animation, curve: Interval(a, b, curve: c));
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 720;
    final logo = _step(0, 0.5, Curves.easeOutBack);
    final name = _step(0.3, 0.75);
    final tag = _step(0.6, 1.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeTransition(
          opacity: _step(0, 0.4),
          child: ScaleTransition(
            scale: logo,
            child: BrandMark(size: wide ? 120 : 96),
          ),
        ),
        const SizedBox(height: 28),
        FadeTransition(
          opacity: name,
          child: AnimatedBuilder(
            animation: name,
            builder: (context, _) => BrandWordmark(
              fontSize: wide ? 64 : 46,
              letterSpacing: 18 - 14 * name.value,
              colors: const [Colors.white, Color(0xFFE7AB1E)],
            ),
          ),
        ),
        const SizedBox(height: 12),
        FadeTransition(
          opacity: tag,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.6),
              end: Offset.zero,
            ).animate(tag),
            child: const Text(
              'Where ideas become inspiration',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                letterSpacing: 1.6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressLine extends StatelessWidget {
  final Animation<double> animation;
  const _ProgressLine({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => Center(
        child: SizedBox(
          width: 120,
          height: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: animation.value,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation(Color(0xFFE7AB1E)),
            ),
          ),
        ),
      ),
    );
  }
}