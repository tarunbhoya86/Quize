// lib/screens/kids_challenge_category_screen.dart

import 'package:flutter/material.dart';
import 'package:quiz_app/screens/instruction_screen.dart';
import '../theme/app_styles.dart';
import '../widgets/feature_card.dart';
import '../widgets/starfield_background.dart'; // Import the new widget
import 'kids_challenge_quiz_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class KidsChallengeCategoryScreen extends StatelessWidget {
  const KidsChallengeCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kidsPalette = [
      const Color(0xFF48CFAE), // Teal
      const Color(0xFFF8A083), // Coral Pink
      const Color(0xFF63C5EA), // Sky Blue
      const Color(0xFFF6D167), // Sunny Yellow
      const Color(0xFFB490F0), // Lavender
      const Color(0xFF90D26D), // Lime Green
      const Color(0xFFF9B55C), // Bright Orange
    ];

    final categories = [
      {'key': 'animals', 'title': 'Animals', 'subtitle': 'Guess the Creature! 🐾', 'color': kidsPalette[0], 'icon': Icons.pets},
      {'key': 'fruits', 'title': 'Fruits', 'subtitle': 'A Fresh & Fruity Challenge 🍓', 'color': kidsPalette[1], 'icon': Icons.apple},
      {'key': 'birds', 'title': 'Birds', 'subtitle': 'Guess the Bird! 🕊️', 'color': kidsPalette[2], 'icon': Icons.flutter_dash},
      {'key': 'numbers', 'title': 'Numbers', 'subtitle': 'A Numerical Brain Teaser 🔢', 'color': kidsPalette[3], 'icon': Icons.pin},
      {'key': 'colors', 'title': 'Colors', 'subtitle': 'A Colorful Conundrum 🎨', 'color': kidsPalette[4], 'icon': Icons.color_lens},
      {'key': 'plants', 'title': 'Plants', 'subtitle': 'A Botanical Brain Buster 🌱', 'color': kidsPalette[5], 'icon': Icons.local_florist},
      {'key': 'vegetables', 'title': 'Vegetables', 'subtitle': 'A Deliciously Devious Quiz 🥕', 'color': kidsPalette[6], 'icon': Icons.spa},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Kids Challenge', style: AppStyles.title.copyWith(fontSize: 22, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const StarfieldBackground(), // Use the animated starfield background
          SafeArea(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return FeatureCard(
                    icon: cat['icon'] as IconData,
                    title: cat['title'] as String,
                    subtitle: cat['subtitle'] as String,
                    color: cat['color'] as Color,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => InstructionScreen(
                          title: cat['title'] as String,
                          icon: cat['icon'] as IconData,
                          color: cat['color'] as Color,
                          instructions: const [
                            'Look at the picture.',
                            'Choose the correct name.',
                            'The app will say the answer out loud.',
                            'Have fun!'
                          ],
                          onStartQuiz: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => KidsChallengeQuizScreen(category: cat['key'] as String)));
                          },
                        ),
                      ));
                    },
                  );
                },
              ).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideX(begin: -0.2)
          ),
        ],
      ),
    );
  }
}