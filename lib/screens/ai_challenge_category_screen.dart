// lib/screens/ai_challenge_category_screen.dart

import 'package:flutter/material.dart';
import 'package:quiz_app/screens/instruction_screen.dart';
import '../services/mock_ai_service.dart';
import 'ai_challenge_screen.dart';
import '../theme/app_styles.dart';
import '../widgets/feature_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:particles_flutter/particles_flutter.dart';

class AiChallengeCategoryScreen extends StatelessWidget {
  const AiChallengeCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final categoryData = {
      AiChallengeCategory.android: {'title': 'Android', 'subtitle': 'Test your OS knowledge', 'color': const Color(0xFFA4C639), 'icon': Icons.android},
      AiChallengeCategory.flutter: {'title': 'Flutter', 'subtitle': 'The Widget Showdown', 'color': const Color(0xFF027DFD), 'icon': Icons.layers},
      AiChallengeCategory.java: {'title': 'Java', 'subtitle': 'The Code Gauntlet', 'color': const Color(0xFFF89820), 'icon': Icons.coffee},
      AiChallengeCategory.movie: {'title': 'Movies', 'subtitle': 'Test Your Film Fame', 'color': const Color(0xFFD9006C), 'icon': Icons.theaters},
      AiChallengeCategory.php: {'title': 'PHP', 'subtitle': 'Backend Battle', 'color': const Color(0xFF7A86B8), 'icon': Icons.code},
      AiChallengeCategory.politics: {'title': 'Politics', 'subtitle': 'The Global Gauntlet', 'color': const Color(0xFFB22234), 'icon': Icons.account_balance},
      AiChallengeCategory.sports: {'title': 'Sports', 'subtitle': 'The Champion\'s Challenge', 'color': const Color(0xFFFFB600), 'icon': Icons.sports_score},
      AiChallengeCategory.python: {'title': 'Python', 'subtitle': 'A Coder\'s Conundrum', 'color': const Color(0xFF306998), 'icon': Icons.insights},
      AiChallengeCategory.science: {'title': 'Science', 'subtitle': 'Explore the natural world', 'color': AppStyles.correctColor, 'icon': Icons.science},
    };

    final availableCategories = MockAiService().availableCategories;

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text('AI Challenge', style: AppStyles.title.copyWith(fontSize: 22)),
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
            particleColor: AppStyles.secondaryColor.withAlpha(120),
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => InstructionScreen(
                      title: catData['title'] as String,
                      icon: catData['icon'] as IconData,
                      color: color,
                      instructions: const [
                        'The AI will ask an open-ended question.',
                        'Type your answer in the text box.',
                        'Your answer is graded on keywords.',
                        'Be as detailed as you can!'
                      ],
                      onStartQuiz: () {
                        // UPDATED: Pass the selected color to the AiChallengeScreen
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => AiChallengeScreen(
                            category: categoryEnum,
                            color: color,
                          ),
                        ));
                      },
                    ),
                  ));
                },
              );
            },
          ).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideX(begin: -0.2)
        ],
      ),
    );
  }
}