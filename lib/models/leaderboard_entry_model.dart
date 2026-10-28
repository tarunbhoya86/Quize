class LeaderboardEntry {
  final String name;
  final int score;
  final DateTime date;

  LeaderboardEntry({
    required this.name,
    required this.score,
    required this.date,
  });

  // Method to convert a LeaderboardEntry instance to a Map (for JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'score': score,
      'date': date.toIso8601String(),
    };
  }

  // Factory constructor to create a LeaderboardEntry from a Map (from JSON decoding)
  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      name: json['name'],
      score: json['score'],
      date: DateTime.parse(json['date']),
    );
  }
}