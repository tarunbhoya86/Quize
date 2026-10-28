// lib/screens/kids_challenge_quiz_screen.dart

import 'package:flutter/material.dart';
import '../models/image_question_model.dart';
import '../theme/app_styles.dart';
import '../widgets/starfield_background.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';

class KidsChallengeQuizScreen extends StatefulWidget {
  final String category;
  const KidsChallengeQuizScreen({super.key, required this.category});

  @override
  State<KidsChallengeQuizScreen> createState() => _KidsChallengeQuizScreenState();
}

class _KidsChallengeQuizScreenState extends State<KidsChallengeQuizScreen> {
  final FlutterTts flutterTts = FlutterTts();

  final Map<String, Color> _categoryColors = {
    'animals': const Color(0xFF48CFAE),
    'fruits': const Color(0xFFF8A083),
    'birds': const Color(0xFF63C5EA),
    'numbers': const Color(0xFFF6D167),
    'colors': const Color(0xFFB490F0),
    'plants': const Color(0xFF90D26D),
    'vegetables': const Color(0xFFF9B55C),
  };

  final Map<String, List<ImageQuestion>> _allQuestions = {
    'animals': [
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/c7/42/53/c742535cd0d5d9cc2ad898d25f855910.jpg'
          , options: ['Lion', 'Tiger'], correctAnswer: 'Lion'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/e7/97/69/e79769f8206ec72c705b102fcc677e4c.jpg'
          , options: ['Hippo', 'Elephant'], correctAnswer: 'Elephant'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/a0/9c/7c/a09c7cb6b7e00f0a442d0776bd1c4be4.jpg'
          , options: ['Monkey', 'Bear'], correctAnswer: 'Monkey'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/c3/54/20/c354202a4f8af278a5e5c32488710e9a.jpg'
          , options: ['Donkey', 'Giraffe'], correctAnswer: 'Giraffe'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/63/2b/c8/632bc8344e7720be1a820f1391cf806a.jpg'
          , options: ['Cat', 'Dog'], correctAnswer: 'Cat'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/e6/29/06/e629064e4520dafbb38e6adc1179aa41.jpg'
          , options: ['Cow', 'Zebra'], correctAnswer: 'Cow'),
    ],
    'birds': [
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/cd/93/be/cd93be2fc9f0b25bb73e872dc976c741.jpg'
          , options: ['Eagle', 'Owl'], correctAnswer: 'Eagle'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/0d/10/16/0d10160ea4242e74c89f1d2be5792d63.jpg'
          , options: ['Sparrow', 'Parrot'], correctAnswer: 'Parrot'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/a8/4e/9e/a84e9e05df41e5e0b719516010e98a4b.jpg'
          , options: ['Pigeon', 'Owl'], correctAnswer: 'Pigeon'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/21/d8/88/21d888d42d52e476e3be8786a1413e71.jpg'
          , options: ['Peacock', 'Woodpecker'], correctAnswer: 'Peacock'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/2f/0c/a0/2f0ca0b890a8d2dfa163dea0d1196147.jpg'
          , options: ['Owl', 'Parrot'], correctAnswer: 'Owl'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/b6/60/15/b660158b8f2aefac1cf5b733668d12d3.jpg' ,
          options: ['Woodpecker', 'Eagle'], correctAnswer: 'Woodpecker'),
    ],
    'fruits': [
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/0a/44/85/0a4485c6784b961bb9b6ccc25be09df4.jpg'
          , options: ['Apple', 'Orange'], correctAnswer: 'Apple'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/ff/8a/af/ff8aaf10360fec617ffdac652c7f6d48.jpg'
          , options: ['Lemon', 'Mango'], correctAnswer: 'Mango'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/42/01/cf/4201cf9132063826b83007a7685b0bea.jpg'
          , options: ['Watermelon', 'Papaya'], correctAnswer: 'Watermelon'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/2f/fa/2a/2ffa2a31eb649588e6272492aff5e2cf.jpg'
          , options: ['Dragon Fruit', 'Watermelon'], correctAnswer: 'Dragon Fruit'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/bc/a6/3c/bca63ce15a635710f2dc2faa17da10f0.jpg'
          , options: ['Berry', 'Pomegranate '], correctAnswer: 'Pomegranate '),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/39/69/77/3969777c09b30a6186ce022fa3fb733a.jpg' ,
          options: ['Strawberry', 'Apple'], correctAnswer: 'Strawberry'),
    ],
    'colors': [
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/0f/36/c6/0f36c6379fc40fd9693974c417fae12e.jpg'
          , options: ['Orange', 'Red'], correctAnswer: 'Red'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/76/27/ef/7627ef9292ecbd5c1019c79c9b9a5a9f.jpg'
          , options: ['Yellow', 'Blue'], correctAnswer: 'Yellow'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/55/94/64/5594648d0c366ae0fd7cde93e334d02f.jpg'
          , options: ['Blue', 'Red'], correctAnswer: 'Blue'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/81/1f/cb/811fcb6c5028f0b969b9bce656a4b52b.jpg'
          , options: ['Gray', 'Green'], correctAnswer: 'Green'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/26/2f/b9/262fb9d9a820357401d62b6d5e5ffcc6.jpg'
          , options: ['Purple', 'Gray'], correctAnswer: 'Gray'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/b3/ad/ab/b3adab9a34fb77a9580d56a279a64586.jpg' ,
          options: ['Black', 'Brown'], correctAnswer: 'Black'),
    ],'plants': [
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/98/d2/d0/98d2d0a3ef742dc825a835c53f51c029.jpg'
          , options: ['Apple Tree', 'Guava Tree'], correctAnswer: 'Guava Tree'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/aa/b6/1f/aab61f1dc66e8c949c473e613f11eb35.jpg'
          , options: ['Banyan Tree', 'Palm Tree'], correctAnswer: 'Banyan Tree'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/38/42/e9/3842e90dc8caa8b3c0e8a177b208a8e2.jpg'
          , options: ['Guava Tree', 'Oak Tree'], correctAnswer: 'Oak Tree'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/de/07/d2/de07d2bd49e7cbe35f8f7350855a33f5.jpg'
          , options: ['Neem Tree', 'Coconut Tree'], correctAnswer: 'Coconut Tree'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/97/e6/5e/97e65ed4dd2c7d26a13621e2aeb9b787.jpg'
          , options: ['Pine Tree', 'Peepal'], correctAnswer: 'Pine Tree'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/37/ab/cc/37abccf92f62ce96edacbc09990bf5ad.jpg'
          , options: ['Cedar', 'Orange'], correctAnswer: 'Orange'),
    ],
    'vegetables': [
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/ee/23/55/ee235528b5d17a95b9547a19d0d94ed2.jpg'
          , options: ['Potato', 'Pumpkin'], correctAnswer: 'Pumpkin'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/13/dc/c4/13dcc4d6c9bdf984fb77e4bdd9e0bbd5.jpg'
          , options: ['Tomato', 'Capsicum'], correctAnswer: 'Tomato'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/a7/2e/9a/a72e9aa0ef9055ffc083b7c22ae278c0.jpg'
          , options: ['Carrot', 'Pea'], correctAnswer: 'Carrot'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/02/57/c3/0257c3bcb948a314f13c704c124178ab.jpg'
          , options: ['Potato', 'Onion'], correctAnswer: 'Onion'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/fb/41/86/fb4186302e96754eaaef09233e60f6cb.jpg'
          , options: ['Pea', 'Carrot'], correctAnswer: 'Pea'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/fc/9d/c7/fc9dc7d0b30b752d93790d7e9b0808a0.jpg'
          , options: ['Cabbage', 'Banana'], correctAnswer: 'Cabbage'),
    ],
    'numbers': [
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/6e/2e/50/6e2e50e4d63f73108840cc7b6630461d.jpg'
          , options: ['One', 'Eleven'], correctAnswer: 'One'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/7f/75/e5/7f75e5e80d0c63fc9e7a751b04295483.jpg'
          , options: ['Two', 'Three'], correctAnswer: 'Three'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/ca/bb/e6/cabbe6f8a42c94f98a4c831e9aa521ce.jpg'
          , options: ['Eight', 'Nine'], correctAnswer: 'Eight'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/736x/f1/9c/ec/f19cec596875ff0d08c7f66e/04351469.jpg'
          , options: ['Seven', 'Four'], correctAnswer: 'Seven'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/f7/10/9f/f7109f02e43603f342c6038ca8e173a6.jpg'
          , options: ['Six', 'Five'], correctAnswer: 'Five'),
      ImageQuestion(imageUrl: 'https://i.pinimg.com/1200x/18/61/e3/1861e3bc5af86e5c68cdc1309880feb9.jpg'
          , options: ['Five', 'Two'], correctAnswer: 'Two'),
    ],
  };

  late List<ImageQuestion> _currentQuizQuestions;
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  bool _showFeedback = false;

  @override
  void initState() {
    super.initState();
    _currentQuizQuestions = _allQuestions[widget.category] ?? [];
    _setupTts();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  void _setupTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  void _handleAnswer(String answer) {
    if (_showFeedback) return;
    final currentQuestion = _currentQuizQuestions[_currentQuestionIndex];
    setState(() {
      _selectedAnswer = answer;
      _showFeedback = true;
    });
    _speak(currentQuestion.correctAnswer);
    Future.delayed(const Duration(seconds: 2), () {
      if (_currentQuestionIndex < _currentQuizQuestions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedAnswer = null;
          _showFeedback = false;
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E2C), // Dark dialog
            title: Text('Great Job!', style: AppStyles.title.copyWith(color: AppStyles.primaryColor)),
            content: Text('You finished the ${widget.category} challenge!', style: AppStyles.body.copyWith(color: Colors.white)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuizQuestions.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: const Center(child: Text("No questions available.", style: AppStyles.body)),
      );
    }
    final currentQuestion = _currentQuizQuestions[_currentQuestionIndex];
    final categoryColor = _categoryColors[widget.category] ?? AppStyles.primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.toUpperCase(), style: AppStyles.title.copyWith(fontSize: 22, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const StarfieldBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("What is this?", style: AppStyles.heading.copyWith(color: Colors.white, shadows: [Shadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, offset: const Offset(0, 2))])),
                  const SizedBox(height: 80,),
                  Container(
                    height: 280,
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: categoryColor, width: 4),
                      boxShadow: [BoxShadow(color: categoryColor.withOpacity(0.4), blurRadius: 12, spreadRadius: 1)],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        currentQuestion.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(child: CircularProgressIndicator(color: categoryColor));
                        },
                        errorBuilder: (context, error, stacktrace) {
                          return const Center(child: Icon(Icons.error, color: AppStyles.incorrectColor, size: 50));
                        },
                      ),
                    ),
                  ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
                  const SizedBox(height: 100,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: currentQuestion.options.map((option) {
                      Color color = categoryColor; // Default color

                      // ▼▼▼▼▼ CHANGE IS HERE ▼▼▼▼▼
                      // This is the new logic to only show feedback on the selected answer.
                      if (_showFeedback) {
                        bool isSelectedOption = _selectedAnswer == option;
                        if (isSelectedOption) {
                          bool isCorrect = currentQuestion.correctAnswer == _selectedAnswer;
                          color = isCorrect ? AppStyles.correctColor : AppStyles.incorrectColor;
                        }
                        // If it's not the selected option, it keeps the default category color.
                        // The correct answer is no longer revealed if an incorrect one is picked.
                      }
                      // ▲▲▲▲▲ CHANGE IS HERE ▲▲▲▲▲

                      return _AnswerButton(
                        text: option,
                        color: color,
                        onTap: () => _handleAnswer(option),
                      );
                    }).toList(),
                  ).animate().slideY(delay: 200.ms, duration: 500.ms, begin: 1).fadeIn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const _AnswerButton({required this.text, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 2),
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 10,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: AppStyles.title.copyWith(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}