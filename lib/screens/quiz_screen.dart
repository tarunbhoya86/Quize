// lib/screens/quiz_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/question_model.dart';
import '../providers/quiz_provider.dart';
import 'quiz_result_screen.dart';
import '../theme/app_styles.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late QuizProvider _quizProvider;

  @override
  void initState() {
    super.initState();
    _quizProvider = Provider.of<QuizProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text(_quizProvider.selectedCategory?.name.capitalize() ?? ''),
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          if (quizProvider.quizCompleted) {
            Future.microtask(() => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const QuizResultScreen())));
            return const Center(child: CircularProgressIndicator());
          }

          if (quizProvider.totalQuestions == 0) {
            return const Center(child: Text('No questions for this category.', style: AppStyles.body));
          }

          // THE FIX: Get the category color from the provider, with a fallback
          final Color categoryColor = quizProvider.selectedCategoryColor ?? AppStyles.primaryColor;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _SimpleQuizHeader(quizProvider: quizProvider, color: categoryColor),
                    const SizedBox(height: 50),
                    Text(
                      quizProvider.currentQuestion.questionText,
                      textAlign: TextAlign.center,
                      style: AppStyles.title,
                    ).animate(key: ValueKey('question_${quizProvider.currentQuestionIndex}')).fadeIn(duration: 500.ms),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      key: ValueKey('answers_${quizProvider.currentQuestionIndex}'),
                      children: quizProvider.currentQuestion.options.map((option) {
                        return _AnswerButton(
                          text: option,
                          isSelected: quizProvider.selectedAnswer == option,
                          isCorrect: quizProvider.currentQuestion.correctAnswer == option,
                          showFeedback: quizProvider.showFeedback,
                          color: categoryColor, // Pass color to buttons
                          onTap: () {
                            quizProvider.setSelectedAnswer(option);
                          },
                        );
                      }).toList()
                          .animate(interval: 100.ms)
                          .slideX(begin: -0.5, duration: 400.ms, curve: Curves.easeOut),
                    ),
                    const SizedBox(height: 60),
                    if (quizProvider.showFeedback)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => quizProvider.nextQuestion(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: categoryColor, // Use dynamic color
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

                          ),


                          child: Text(
                            quizProvider.currentQuestionIndex < quizProvider.totalQuestions - 1
                                ? 'Next Question'
                                : 'Finish Quiz',
                            style: AppStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 1)
                    else
                      const SizedBox(height: 58),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SimpleQuizHeader extends StatelessWidget {
  final QuizProvider quizProvider;
  final Color color; // Added color parameter
  const _SimpleQuizHeader({required this.quizProvider, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Question ${quizProvider.currentQuestionIndex + 1} of ${quizProvider.totalQuestions}',
          style: AppStyles.body.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: (quizProvider.currentQuestionIndex + 1) / quizProvider.totalQuestions,
          minHeight: 8,
          backgroundColor: AppStyles.surfaceColor,
          valueColor: AlwaysStoppedAnimation<Color>(color), // Use dynamic color
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool showFeedback;
  final Color color; // Added color parameter
  final VoidCallback onTap;

  const _AnswerButton({
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.showFeedback,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = color; // Use dynamic color as default
    Color glowColor = Colors.transparent;

    if (showFeedback) {
      if (isCorrect) {
        borderColor = AppStyles.correctColor;
        glowColor = AppStyles.correctColor;
      } else if (isSelected) {
        borderColor = AppStyles.incorrectColor;
        glowColor = AppStyles.incorrectColor;
      } else {
        borderColor = AppStyles.surfaceColor;
      }
    }

    return InkWell(
      onTap: showFeedback ? null : onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: AppStyles.neonBorder(borderColor),
          borderRadius: BorderRadius.circular(12),
          color: AppStyles.surfaceColor.withOpacity(0.8),
          boxShadow: [AppStyles.neonGlow(glowColor)],
        ),
        child: Text(text, textAlign: TextAlign.center, style: AppStyles.body.copyWith(fontSize: 18)),
      ),
    );
  }
}