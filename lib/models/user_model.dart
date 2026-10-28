class MockUser {
  final String uid;
  final String? email;
  final String? password; // Stored for mock authentication only
  final String? displayName;
  final String? photoUrl;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;
  final List<String>? completedQuizzes;
  final int? totalScore;

  MockUser({
    required this.uid,
    this.email,
    this.password,
    this.displayName,
    this.photoUrl,
    this.createdAt,
    this.lastLoginAt,
    this.completedQuizzes,
    this.totalScore,
  });

  MockUser copyWith({
    String? uid,
    String? email,
    String? password,
    String? displayName,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    List<String>? completedQuizzes,
    int? totalScore,
  }) {
    return MockUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      completedQuizzes: completedQuizzes ?? this.completedQuizzes,
      totalScore: totalScore ?? this.totalScore,
    );
  }
}