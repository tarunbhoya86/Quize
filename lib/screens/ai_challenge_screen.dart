// lib/screens/ai_challenge_screen.dart

import 'package:flutter/material.dart';
import '../services/mock_ai_service.dart';
import '../theme/app_styles.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class AiChallengeScreen extends StatefulWidget {
  final AiChallengeCategory category;
  final Color color;

  const AiChallengeScreen({
    super.key,
    required this.category,
    required this.color,
  });

  @override
  State<AiChallengeScreen> createState() => _AiChallengeScreenState();
}

class _AiChallengeScreenState extends State<AiChallengeScreen> {
  final MockAiService _aiService = MockAiService();
  final TextEditingController _answerController = TextEditingController();

  bool _isLoading = true;
  bool _isEvaluated = false;
  Map<String, dynamic>? _currentQuestion;
  Map<String, dynamic>? _evaluationResult;

  @override
  void initState() {
    super.initState();
    _loadNewQuestion();
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _loadNewQuestion() async {
    setState(() {
      _isLoading = true;
      _isEvaluated = false;
      _currentQuestion = null;
      _evaluationResult = null;
      _answerController.clear();
    });

    final question = await _aiService.getAiChallengeQuestion(widget.category);

    setState(() {
      _currentQuestion = question;
      _isLoading = false;
    });
  }

  void _submitAnswer() {
    if (_answerController.text.trim().isEmpty || _currentQuestion == null) {
      return;
    }

    final result = _aiService.evaluateAnswerAccuracy(
      userAnswer: _answerController.text,
      keywords: _currentQuestion!['keywords'],
    );

    setState(() {
      _evaluationResult = result;
      _isEvaluated = true;
    });
  }

  String _getCategoryName() {
    switch (widget.category) {
      case AiChallengeCategory.android: return 'Android';
      case AiChallengeCategory.flutter: return 'Flutter';
      case AiChallengeCategory.python: return 'Python';
      case AiChallengeCategory.politics: return 'Politics';
      case AiChallengeCategory.php: return 'PHP';
      case AiChallengeCategory.science: return 'Science';
      case AiChallengeCategory.sports: return 'Sports';
      case AiChallengeCategory.movie: return 'Movie';
      case AiChallengeCategory.java: return 'Java';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text('AI Challenge: ${_getCategoryName()}'),
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: widget.color))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildQuestionCard(),
            const SizedBox(height: 30),
            TextField(
              controller: _answerController,
              readOnly: _isEvaluated,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Your Answer',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                hintText: 'Type your detailed answer here...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.black.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: widget.color, width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (!_isEvaluated)
              ElevatedButton(
                onPressed: _submitAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  foregroundColor: AppStyles.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Submit Answer', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            if (_isEvaluated)
              Column(
                children: [
                  _buildResultCard(),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _loadNewQuestion,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next Question'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Card(
      elevation: 8,
      color: AppStyles.surfaceColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.psychology_outlined, size: 40, color: widget.color),
            const SizedBox(height: 10),
            Text(
              'AI Asks:',
              style: AppStyles.heading.copyWith(fontSize: 16, color: widget.color),
            ),
            const SizedBox(height: 10),
            Text(
              _currentQuestion?['question'] ?? '',
              textAlign: TextAlign.center,
              style: AppStyles.title.copyWith(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    if (_evaluationResult == null) return const SizedBox.shrink();

    final double accuracy = _evaluationResult!['accuracy'];
    final List foundKeywords = _evaluationResult!['foundKeywords'];
    final List missedKeywords = _evaluationResult!['missedKeywords'];

    return Card(
      color: AppStyles.surfaceColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Evaluation Result', style: AppStyles.title.copyWith(fontSize: 20)),
            const SizedBox(height: 16),
            Text(
              'Accuracy: ${accuracy.toStringAsFixed(0)}%',
              style: AppStyles.heading.copyWith(fontSize: 18, color: widget.color),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: accuracy / 100,
                minHeight: 12,
                backgroundColor: Colors.black.withOpacity(0.2),
                // **THE FIX: Changed progress bar color to match category color**
                valueColor: AlwaysStoppedAnimation<Color>(widget.color),
              ),
            ),
            const Divider(height: 30, color: Colors.white24),
            if (foundKeywords.isNotEmpty) ...[
              const Text('Keywords Found:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: foundKeywords
                // **THE FIX: Changed Chip color to match category color**
                    .map((kw) => Chip(label: Text(kw), backgroundColor: widget.color.withOpacity(0.8), labelStyle: const TextStyle(color: Colors.white)))
                    .toList(),
              ),
              const SizedBox(height: 16),
            ],
            if (missedKeywords.isNotEmpty) ...[
              const Text('Keywords Missed:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: missedKeywords
                    .map((kw) => Chip(
                  label: Text(kw),
                  backgroundColor: AppStyles.incorrectColor.withOpacity(0.5),
                  labelStyle: const TextStyle(color: Colors.white),
                  shape: StadiumBorder(side: BorderSide(color: AppStyles.incorrectColor.withOpacity(0.6))),
                ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}