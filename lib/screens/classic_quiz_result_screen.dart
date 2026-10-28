// lib/screens/classic_quiz_result_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/leaderboard_entry_model.dart';
import '../models/user_model.dart';
import '../providers/classic_quiz_provider.dart';
import '../services/leaderboard_service.dart';
import '../services/mock_auth_service.dart';
import '../theme/app_styles.dart';

// NEW: Converted to a StatefulWidget to handle score submission
class ClassicQuizResultScreen extends StatefulWidget {
  const ClassicQuizResultScreen({super.key});

  @override
  State<ClassicQuizResultScreen> createState() => _ClassicQuizResultScreenState();
}

class _ClassicQuizResultScreenState extends State<ClassicQuizResultScreen> {
  bool _hasSubmittedScore = false;

  @override
  void initState() {
    super.initState();
    // Submit score when the screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addScoreToServices();
    });
  }

  // NEW: Method to submit score to the leaderboard and update user stats
  void _addScoreToServices() {
    if (_hasSubmittedScore) return;

    final quizProvider = Provider.of<ClassicQuizProvider>(context, listen: false);
    final authService = Provider.of<MockAuthService>(context, listen: false);
    final leaderboardService = Provider.of<LeaderboardService>(context, listen: false);

    final MockUser? currentUser = authService.currentUser;
    final int score = quizProvider.score * 10;

    if (currentUser != null) {
      // Add to leaderboard
      final entry = LeaderboardEntry(
        name: currentUser.displayName ?? 'Anonymous',
        score: score,
        date: DateTime.now(),
      );
      leaderboardService.addEntry(entry);

      // Update user's personal total score and completed quiz list
      authService.updateUserQuizStats(
        score: score,
        quizName: quizProvider.selectedCategory?.name ?? 'Classic Quiz',
      );

      setState(() {
        _hasSubmittedScore = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<ClassicQuizProvider>();
    final score = quizProvider.score;
    final total = quizProvider.totalQuestions;

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text('Quiz Results', style: AppStyles.title.copyWith(fontSize: 22)),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'You Scored $score out of $total',
              style: AppStyles.heading.copyWith(color: AppStyles.primaryColor),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: quizProvider.questions.length,
              itemBuilder: (context, index) {
                final question = quizProvider.questions[index];
                final userAnswer = quizProvider.userAnswers[index];
                final isCorrect = userAnswer == question.correctAnswer;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppStyles.surfaceColor,
                    borderRadius: BorderRadius.circular(15),
                    border: AppStyles.neonBorder(isCorrect ? AppStyles.correctColor : AppStyles.incorrectColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Q${index + 1}: ${question.questionText}',
                        style: AppStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Divider(height: 20, color: Colors.white24),
                      Text(
                        'Your Answer: ${userAnswer ?? "Not answered"}',
                        style: AppStyles.body.copyWith(color: isCorrect ? AppStyles.correctColor : AppStyles.incorrectColor),
                      ),
                      if (!isCorrect)
                        Text(
                          'Correct Answer: ${question.correctAnswer}',
                          style: AppStyles.body.copyWith(color: AppStyles.correctColor),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                quizProvider.resetQuiz();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Back to Home'),
            ),
          )
        ],
      ),
    );
  }
}