class VoteListsItem {
  final int number;
  final String title;
  final String fullName;
  VoteListsItem({
    required this.number,
    required this.title,
    required this.fullName,
  });

  factory VoteListsItem.fromJson(Map<String, dynamic> json) {
    return VoteListsItem(
      number: json['number'],
      title: json['title'],
      fullName: json['fullName'],
    );
  }

}