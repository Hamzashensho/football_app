class ChampionModel {
  final String championId;
  final String title;
  final DateTime date;

  ChampionModel({
    required this.championId,
    required this.title,
    required this.date,
  });

  factory ChampionModel.fromMap(Map<String, dynamic> map, String id) {
    return ChampionModel(
      championId: id,
      title: map['title'],
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date.toIso8601String(),
    };
  }
}
