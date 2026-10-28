// lib/widgets/animal_background.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';

class AnimalBackground extends StatelessWidget {
  const AnimalBackground({super.key});

  @override
  Widget build(BuildContext context) {
    // Only animal-themed icons
    final animalIcons = [
      Icons.pets,
      Icons.egg_alt, // Represents a hatching animal
      Icons.fingerprint, // Can represent paw prints
      Icons.bug_report,
      Icons.flutter_dash, // Looks like a butterfly/bird
      Icons.phishing,
      Icons.catching_pokemon,
    ];

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        // CHANGE: More vibrant and kid-friendly gradient
        gradient: LinearGradient(
          colors: [
            Color(0xFF87CEEB), // Sky Blue
            Color(0xFFADD8E6), // Light Blue
            Color(0xFFAFE4FF), // Very Light Blue
            Color(0xFFB0E0E6), // Powder Blue
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: List.generate(50, (index) { // INCREASED amount of animations
          final iconData = animalIcons[index % animalIcons.length];
          final size = Random().nextDouble() * 35 + 25; // Slightly larger animals
          final color = Colors.white.withOpacity(Random().nextDouble() * 0.5 + 0.2); // Brighter animals

          return Animate(
            onPlay: (controller) => controller.repeat(), // ENSURES continuous animation
            delay: (Random().nextInt(2000)).milliseconds, // Stagger initial start
            effects: [
              // Path ensures they move across the screen
              FollowPathEffect(
                path: _createRandomPath(context),
                duration: (Random().nextInt(15) + 15).seconds, // Adjusted duration for continuous flow
                curve: Curves.linear, // Linear for consistent speed
              ),
              FadeEffect(
                curve: Curves.easeInOut,
                duration: (Random().nextInt(8) + 4).seconds,
              )
            ],
            child: Icon(iconData, size: size, color: color),
          );
        }),
      ),
    );
  }

  Path _createRandomPath(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final random = Random();
    final path = Path();

    // Start animals from random points off the left or right edge
    double startX = random.nextBool() ? -50 : size.width + 50;
    double startY = random.nextDouble() * size.height;

    // End animals off the opposite edge
    double endX = startX < 0 ? size.width + 50 : -50;
    double endY = random.nextDouble() * size.height;

    path.moveTo(startX, startY);

    // Create a gentle curve across the screen
    path.quadraticBezierTo(
      random.nextDouble() * size.width,
      random.nextDouble() * size.height,
      endX,
      endY,
    );
    return path;
  }
}