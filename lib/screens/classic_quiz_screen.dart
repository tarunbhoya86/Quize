// lib/screens/classic_quiz_screen.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/classic_quiz_provider.dart';
import 'classic_quiz_result_screen.dart';
import '../theme/app_styles.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ClassicQuizScreen extends StatefulWidget {
  const ClassicQuizScreen({super.key});

  @override
  State<ClassicQuizScreen> createState() => _ClassicQuizScreenState();
}

class _ClassicQuizScreenState extends State<ClassicQuizScreen> with TickerProviderStateMixin {
  late AnimationController _timerController;
  late ClassicQuizProvider _quizProvider;
  int _questionIndexTracker = 0;

  @override
  void initState() {
    super.initState();
    _quizProvider = Provider.of<ClassicQuizProvider>(context, listen: false);
    _timerController = AnimationController(vsync: this, duration: const Duration(seconds: 15))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _quizProvider.submitAndMoveNext();
        }
      });
    _timerController.forward();
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text(
            _quizProvider.selectedCategory?.name.toUpperCase() ?? 'Classic Quiz',
            style: AppStyles.title.copyWith(fontSize: 22)
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<ClassicQuizProvider>(
        builder: (context, quizProvider, child) {
          if (quizProvider.currentQuestionIndex != _questionIndexTracker) {
            _questionIndexTracker = quizProvider.currentQuestionIndex;
            _timerController.reset();
            _timerController.forward();
          }

          if (quizProvider.quizCompleted) {
            Future.microtask(() => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const ClassicQuizResultScreen())));
            return const Center(child: CircularProgressIndicator());
          }

          final isLastQuestion = quizProvider.currentQuestionIndex == quizProvider.totalQuestions - 1;
          final categoryColor = quizProvider.selectedCategoryColor ?? AppStyles.primaryColor;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _QuizHeader(
                  quizProvider: quizProvider,
                  timerController: _timerController,
                  color: categoryColor,
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          quizProvider.currentQuestion.questionText,
                          textAlign: TextAlign.center,
                          style: AppStyles.title,
                        ).animate(key: ValueKey(quizProvider.currentQuestionIndex)).fadeIn(duration: 500.ms),
                        const SizedBox(height: 50),
                        Column(
                          key: ValueKey('classic_answers_${quizProvider.currentQuestionIndex}'),
                          children: quizProvider.currentQuestion.options.map((option) {
                            return _AnswerButton(
                              text: option,
                              isSelected: quizProvider.userAnswers[quizProvider.currentQuestionIndex] == option,
                              onTap: () {
                                quizProvider.selectAnswer(option);
                              },
                              color: categoryColor,
                            );
                          }).toList()
                              .animate(interval: 100.ms)
                              .slideX(begin: -0.5, duration: 400.ms, curve: Curves.easeOut),
                        ),
                      ],
                    ),
                  ),
                ),
                _NavigationControls(
                  onNext: () {
                    _timerController.stop();
                    quizProvider.submitAndMoveNext();
                  },
                  isLastQuestion: isLastQuestion,
                  color: categoryColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _QuizHeader extends StatelessWidget {
  final ClassicQuizProvider quizProvider;
  final AnimationController timerController;
  final Color color;

  const _QuizHeader({required this.quizProvider, required this.timerController, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question ${quizProvider.currentQuestionIndex + 1} of ${quizProvider.totalQuestions}',
              style: AppStyles.body.copyWith(color: Colors.white),
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: AnimatedBuilder(
                animation: timerController,
                builder: (context, child) => CustomPaint(
                  painter: _HexagonTimerPainter(
                      progress: 1 - timerController.value,
                      color: timerController.value > 0.7
                          ? AppStyles.incorrectColor
                          : color), // Use dynamic color
                  child: Center(
                    child: Text(
                      (timerController.duration!.inSeconds * (1 - timerController.value)).ceil().toString(),
                      style: AppStyles.body.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
  final VoidCallback onTap;
  final Color color;

  const _AnswerButton({ required this.text, required this.isSelected, required this.onTap, required this.color });

  @override
  Widget build(BuildContext context) {
    // THE FIX: Use the dynamic category color for the border and selection glow.
    Color borderColor = color;
    Color glowColor = isSelected ? color : Colors.transparent;

    return InkWell(
      onTap: onTap,
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
        child: Text(text, textAlign: TextAlign.center, style: AppStyles.body.copyWith(fontSize: 18, color: Colors.white)),
      ),
    );
  }
}

class _NavigationControls extends StatelessWidget {
  final VoidCallback onNext;
  final bool isLastQuestion;
  final Color color;

  const _NavigationControls({
    required this.onNext,
    required this.isLastQuestion,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onNext,
          label: Icon(isLastQuestion ? Icons.check_circle : Icons.arrow_forward_ios),
          icon: Text(isLastQuestion ? 'Finish Quiz' : 'Next'),
          style: ElevatedButton.styleFrom(
            backgroundColor: isLastQuestion ? AppStyles.correctColor : color, // Use dynamic color
            foregroundColor: AppStyles.backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}

class _HexagonTimerPainter extends CustomPainter {
  final double progress;
  final Color color;

  _HexagonTimerPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final backgroundPaint = Paint()
      ..color = AppStyles.surfaceColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (pi / 3) * i - (pi / 2);
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, backgroundPaint);

    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      canvas.drawPath(
        metric.extractPath(0, metric.length * progress),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HexagonTimerPainter oldDelegate) => oldDelegate.progress != progress;
}