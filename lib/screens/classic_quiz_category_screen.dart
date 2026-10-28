// lib/screens/classic_quiz_category_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/classic_quiz_provider.dart';
import 'package:quiz_app/screens/classic_quiz_screen.dart';
import 'package:quiz_app/screens/instruction_screen.dart';
import '../theme/app_styles.dart';
import '../widgets/feature_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:particles_flutter/particles_flutter.dart';

class ClassicQuizCategoryScreen extends StatelessWidget {
  const ClassicQuizCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final categories = [
      {'key': ClassicQuizCategory.generalKnowledge, 'title': 'General Knowledge', 'subtitle': 'A broad range of topics', 'color': AppStyles.primaryColor, 'icon': Icons.public},
      {'key': ClassicQuizCategory.science, 'title': 'Science', 'subtitle': 'Explore the natural world', 'color': AppStyles.correctColor, 'icon': Icons.science},
      {'key': ClassicQuizCategory.history, 'title': 'History', 'subtitle': 'Journey through the past', 'color': AppStyles.secondaryColor, 'icon': Icons.history_edu},
      {'key': ClassicQuizCategory.android, 'title': 'Android', 'subtitle': 'Test Your Mobile Mastery', 'color': const Color(0xFFA4C639), 'icon': Icons.android},
      {'key': ClassicQuizCategory.python, 'title': 'Python', 'subtitle': 'A Coders Conundrum', 'color': const Color(0xFF306998), 'icon': Icons.insights},
      {'key': ClassicQuizCategory.flutter, 'title': 'Flutter', 'subtitle': 'Dart & UI Brain Teasers', 'color': const Color(0xFF027DFD), 'icon': Icons.layers},
      {'key': ClassicQuizCategory.sports, 'title': 'Sports', 'subtitle': 'The Champions Challenge', 'color': const Color(0xFFFFB600), 'icon': Icons.sports_score},
      {'key': ClassicQuizCategory.movie, 'title': 'Movie', 'subtitle': 'Test Your Film Fame', 'color': const Color(0xFFD9006C), 'icon': Icons.theaters_outlined},
      {'key': ClassicQuizCategory.politics, 'title': 'Politics', 'subtitle': 'The Global Gauntlet', 'color': const Color(0xFFB22234), 'icon': Icons.account_balance},
      {'key': ClassicQuizCategory.java, 'title': 'Java', 'subtitle': 'Are You a Java Genius?', 'color': const Color(0xFFF89820), 'icon': Icons.coffee},
    ];

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text('Select Classic Category', style: AppStyles.title.copyWith(fontSize: 22)),
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
            particleColor: Colors.teal.withAlpha(120),
            connectDots: false,
            isRandomColor: false,
            maxParticleSize: 3,
          ),
          ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              final categoryKey = cat['key'] as ClassicQuizCategory;
              final categoryColor = cat['color'] as Color;

              return FeatureCard(
                icon: cat['icon'] as IconData,
                title: cat['title'] as String,
                subtitle: cat['subtitle'] as String,
                color: categoryColor,
                onTap: () {
                  Provider.of<ClassicQuizProvider>(context, listen: false).selectCategory(categoryKey, categoryColor);

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => InstructionScreen(
                      title: cat['title'] as String,
                      icon: cat['icon'] as IconData,
                      color: categoryColor,
                      instructions: const [
                        'Each question has a 15-second timer.',
                        'You can change your answer anytime.',
                        'Press Next or wait for the timer to finish.',
                        'Good luck!'
                      ],
                      onStartQuiz: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ClassicQuizScreen()));
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