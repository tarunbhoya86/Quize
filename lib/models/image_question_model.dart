// lib/models/image_question_model.dart

class ImageQuestion {
  // CHANGED: from imagePath back to imageUrl
  final String imageUrl;
  final List<String> options;
  final String correctAnswer;

  ImageQuestion({
    required this.imageUrl,
    required this.options,
    required this.correctAnswer,
  });
}