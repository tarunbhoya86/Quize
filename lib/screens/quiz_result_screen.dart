// lib/screens/quiz_result_screen.dart

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'quiz_review_screen.dart';
import '../theme/app_styles.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:particles_flutter/particles_flutter.dart';

class QuizResultScreen extends StatefulWidget {
  const QuizResultScreen({super.key});
  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showConfetti();
    });
  }

  // REMOVED: The logic to add scores to the leaderboard and update user stats is gone.
  // This screen is now just for showing results.

  void _showConfetti() {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    if (quizProvider.score / quizProvider.totalQuestions >= 0.7) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final int score = quizProvider.score;
    final int totalQuestions = quizProvider.totalQuestions;
    final double percentage = totalQuestions > 0 ? (score / totalQuestions) : 0.0;

    String resultMessage;
    Color resultColor;
    if (percentage == 1) {
      resultMessage = 'PERFECT SCORE!';
      resultColor = AppStyles.correctColor;
    } else if (percentage >= 0.7) {
      resultMessage = 'GREAT JOB!';
      resultColor = AppStyles.primaryColor;
    } else if (percentage >= 0.4) {
      resultMessage = 'GOOD EFFORT!';
      resultColor = AppStyles.secondaryColor;
    } else {
      resultMessage = 'KEEP PRACTICING!';
      resultColor = AppStyles.incorrectColor;
    }

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text('Quiz Results', style: AppStyles.title.copyWith(fontSize: 22)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          CircularParticle(
            key: UniqueKey(),
            numberOfParticles: 50,
            speedOfParticles: 0.5,
            height: screenHeight,
            width: screenWidth,
            particleColor: resultColor.withAlpha(80),
            connectDots: true,
            isRandomColor: false,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [AppStyles.primaryColor, AppStyles.secondaryColor, AppStyles.correctColor, Colors.white],
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: AppStyles.surfaceColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(resultMessage, style: AppStyles.title.copyWith(color: resultColor)),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [AppStyles.neonGlow(resultColor.withOpacity(0.5))],
                      ),
                      child: CircularPercentIndicator(
                        radius: 80.0,
                        lineWidth: 15.0,
                        percent: percentage,
                        center: Text('${score * 10}', style: AppStyles.score),
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: AppStyles.surfaceColor,
                        progressColor: resultColor,
                        animation: true,
                        animationDuration: 1500,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("You answered $score of $totalQuestions correctly.", style: AppStyles.body, textAlign: TextAlign.center),
                    const SizedBox(height: 40),
                    _buildActionButton(
                      context,
                      text: 'PLAY AGAIN',
                      icon: Icons.refresh,
                      color: AppStyles.primaryColor,
                      onPressed: () { quizProvider.resetQuiz(); Navigator.of(context).pop(); },
                    ),
                    const SizedBox(height: 15),
                    _buildActionButton(
                      context,
                      text: 'REVIEW ANSWERS',
                      icon: Icons.rate_review_outlined,
                      color: AppStyles.secondaryColor,
                      onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (_) => const QuizReviewScreen())); },
                    ),
                    const SizedBox(height: 15),
                    TextButton.icon(
                      onPressed: () { quizProvider.resetQuiz(); Navigator.of(context).popUntil((route) => route.isFirst); },
                      icon: const Icon(Icons.home, color: Colors.white70),
                      label: Text('RETURN TO HOME', style: AppStyles.body.copyWith(color: Colors.white70)),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.9, 0.9)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, { required String text, required IconData icon, required Color color, required VoidCallback onPressed }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [AppStyles.neonGlow(color.withOpacity(0.5))],
        border: AppStyles.neonBorder(color),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(text, style: AppStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppStyles.surfaceColor.withOpacity(0.7),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),
    );
  }
}