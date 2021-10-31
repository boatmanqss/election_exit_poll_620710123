class VoteScItem {
  final int number;
  final String title;
  final String fullName;
  final int score;
  VoteScItem({
    required this.number,
    required this.title,
    required this.fullName,
    required this.score,
  });

  factory VoteScItem.fromJson(Map<String, dynamic> json) {
    return VoteScItem(
      number: json['number'],
      title: json['title'],
      fullName: json['fullName'],
      score: json['score'],
    );
  }

}