// lib/widgets/starfield_background.dart

import 'package:flutter/material.dart';
import 'dart:math';

class StarfieldBackground extends StatefulWidget {
  const StarfieldBackground({super.key});

  @override
  State<StarfieldBackground> createState() => _StarfieldBackgroundState();
}

class _StarfieldBackgroundState extends State<StarfieldBackground> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Star> _stars;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _stars = List.generate(100, (index) => Star(_random)); // Generate 100 stars
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Animation duration
    )..repeat(); // Loop the animation

    _controller.addListener(() {
      setState(() {
        for (var star in _stars) {
          star.update(); // Update each star's position
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StarfieldPainter(_stars, _controller.value),
      child: Container(),
    );
  }
}

class _StarfieldPainter extends CustomPainter {
  final List<Star> stars;
  final double animationValue;

  _StarfieldPainter(this.stars, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Background gradient (same as before)
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF161a25), Color(0xFF000000)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw stars
    for (var star in stars) {
      final starPaint = Paint()
        ..color = star.color.withOpacity(star.opacity)
        ..style = PaintingStyle.fill;

      // Apply parallax effect based on size and animation
      final double x = (star.x + star.speed * animationValue) % size.width;
      final double y = (star.y + star.speed * animationValue) % size.height;

      canvas.drawCircle(Offset(x, y), star.size, starPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint on every animation frame
  }
}

class Star {
  double x, y;
  double size;
  double speed;
  Color color;
  double opacity;
  Random random;

  Star(this.random)
      : x = random.nextDouble() * 500, // Initial position, can be adjusted
        y = random.nextDouble() * 800,
        size = random.nextDouble() * 1.5 + 0.5, // Small stars
        speed = random.nextDouble() * 0.5 + 0.1, // Different speeds for parallax
        color = Colors.white,
        opacity = random.nextDouble() * 0.7 + 0.3; // Varying opacity for twinkling effect

  void update() {
    // This update is primarily handled by the CustomPainter's animationValue
    // but individual star properties like opacity could be animated here for twinkling
    opacity = random.nextDouble() * 0.7 + 0.3; // Simple twinkling
  }
}