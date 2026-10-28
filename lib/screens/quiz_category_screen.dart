// lib/screens/quiz_category_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/instruction_screen.dart';
import '../providers/quiz_provider.dart';
import 'quiz_screen.dart';
import '../theme/app_styles.dart';
import '../widgets/feature_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:particles_flutter/particles_flutter.dart';

class QuizCategoryScreen extends StatelessWidget {
  const QuizCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final categoryData = {
      QuizCategory.generalKnowledge: {'title': 'General Knowledge', 'subtitle': 'A broad range of topics', 'color': AppStyles.primaryColor, 'icon': Icons.public},
      QuizCategory.science: {'title': 'Science', 'subtitle': 'Explore the natural world', 'color': AppStyles.correctColor, 'icon': Icons.science},
      QuizCategory.history: {'title': 'History', 'subtitle': 'Journey through the past', 'color': AppStyles.secondaryColor, 'icon': Icons.history_edu},
      QuizCategory.android: {'title': 'Android', 'subtitle': 'Test your OS knowledge', 'color': const Color(0xFFA4C639), 'icon': Icons.android},
      QuizCategory.flutter: {'title': 'Flutter', 'subtitle': 'The Widget Showdown', 'color': const Color(0xFF027DFD), 'icon': Icons.layers},
      QuizCategory.java: {'title': 'Java', 'subtitle': 'The Code Gauntlet', 'color': const Color(0xFFF89820), 'icon': Icons.coffee},
      QuizCategory.movie: {'title': 'Movies', 'subtitle': 'Test Your Film Fame', 'color': const Color(0xFFD9006C), 'icon': Icons.theaters},
      QuizCategory.politics: {'title': 'Politics', 'subtitle': 'The Global Gauntlet', 'color': const Color(0xFFB22234), 'icon': Icons.account_balance},
      QuizCategory.python: {'title': 'Python', 'subtitle': 'A Coder\'s Conundrum', 'color': const Color(0xFF306998), 'icon': Icons.insights},
      QuizCategory.sports: {'title': 'Sports', 'subtitle': 'The Champion\'s Challenge', 'color': const Color(0xFFFFB600), 'icon': Icons.sports_score},
    };

    final availableCategories = Provider.of<QuizProvider>(context, listen: false).availableCategories;

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text('Select Category', style: AppStyles.title.copyWith(fontSize: 22)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          CircularParticle(
            key: UniqueKey(),
            numberOfParticles: 80,
            speedOfParticles: 0.7,
            height: screenHeight,
            width: screenWidth,
            particleColor: AppStyles.primaryColor.withAlpha(120),
            connectDots: false,
            isRandomColor: false,
            maxParticleSize: 3,
          ),
          ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: availableCategories.length,
            itemBuilder: (context, index) {
              final categoryEnum = availableCategories[index];
              final catData = categoryData[categoryEnum]!;
              final color = catData['color'] as Color;

              return FeatureCard(
                icon: catData['icon'] as IconData,
                title: catData['title'] as String,
                subtitle: catData['subtitle'] as String,
                color: color,
                onTap: () {
                  // UPDATED: Pass the category's color to the provider
                  Provider.of<QuizProvider>(context, listen: false).selectCategory(categoryEnum, color);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => InstructionScreen(
                      title: catData['title'] as String,
                      icon: catData['icon'] as IconData,
                      color: color,
                      instructions: const [
                        'Select an answer for each question.',
                        'Your answer is locked in instantly.',
                        'Press the Next button to continue.',
                        'Good luck!'
                      ],
                      onStartQuiz: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const QuizScreen()));
                      },
                    ),
                  ));
                },
              );
            },
          ).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideX(begin: -0.2),
        ],
      ),
    );
  }
}