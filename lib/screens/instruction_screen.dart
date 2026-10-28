// lib/screens/instruction_screen.dart

import 'package:flutter/material.dart';
import '../theme/app_styles.dart';
import 'package:flutter_animate/flutter_animate.dart';

class InstructionScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> instructions;
  final VoidCallback onStartQuiz;

  const InstructionScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.instructions,
    required this.onStartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text(title, style: AppStyles.title.copyWith(fontSize: 22)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                Icon(icon, color: color, size: 100, shadows: [AppStyles.neonGlow(color)])
                    .animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                const SizedBox(height: 20),
                Text(
                  'Let\'s Play',
                  style: AppStyles.heading.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppStyles.surfaceColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: instructions.map((instruction) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle_outline, color: color, size: 20),
                          const SizedBox(width: 12),
                          Expanded(child: Text(instruction, style: AppStyles.body)),
                        ],
                      ),
                    )).toList(),
                  ),
                ).animate(delay: 200.ms).fadeIn(duration: 500.ms),
              ],
            ),
            SizedBox(height: 100,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onStartQuiz,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Quiz'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: color,
                  foregroundColor: AppStyles.backgroundColor,
                ),
              ),
            ).animate().slideY(delay: 400.ms, begin: 2, curve: Curves.easeOutCubic)
          ],
        ),
      ),
    );
  }
}