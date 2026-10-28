// lib/screens/quiz_review_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/question_model.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_styles.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuizReviewScreen extends StatelessWidget {
  const QuizReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final List<Question> questions = quizProvider.completedQuizQuestions;
    final Map<int, String> userAnswers = quizProvider.userAnswers;

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text('Review Answers', style: AppStyles.title.copyWith(fontSize: 22)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          final userAnswer = userAnswers[index];
          final bool isCorrect = userAnswer == question.correctAnswer;

          return Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppStyles.surfaceColor,
              borderRadius: BorderRadius.circular(15),
              border: AppStyles.neonBorder(isCorrect ? AppStyles.correctColor : AppStyles.incorrectColor),
              boxShadow: [
                AppStyles.neonGlow(isCorrect ? AppStyles.correctColor.withOpacity(0.4) : AppStyles.incorrectColor.withOpacity(0.4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'QUESTION ${index + 1}:',
                  style: AppStyles.heading.copyWith(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  question.questionText,
                  style: AppStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),
                _buildAnswerDetail(
                  context,
                  title: 'YOUR ANSWER:',
                  answer: userAnswer ?? 'No Answer',
                  isCorrect: isCorrect,
                  isUserAnswer: true,
                ),
                const SizedBox(height: 15),
                if (!isCorrect)
                  _buildAnswerDetail(
                    context,
                    title: 'CORRECT ANSWER:',
                    answer: question.correctAnswer,
                    isCorrect: true,
                    isUserAnswer: false,
                  ),
              ],
            ),
          ).animate().fadeIn(delay: (index * 150).ms).slideY(begin: 0.1);
        },
      ),
    );
  }

  Widget _buildAnswerDetail(
      BuildContext context, {
        required String title,
        required String answer,
        required bool isCorrect,
        required bool isUserAnswer,
      }) {
    Color detailColor;
    if (isUserAnswer) {
      detailColor = isCorrect ? AppStyles.correctColor : AppStyles.incorrectColor;
    } else {
      detailColor = AppStyles.correctColor;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: detailColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: detailColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isUserAnswer ? (isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined) : Icons.check_circle,
            color: detailColor,
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppStyles.body.copyWith(color: detailColor.withOpacity(0.8), fontSize: 13)),
                Text(answer, style: AppStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}