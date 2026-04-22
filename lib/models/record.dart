class Record {
  final int? id;
  final DateTime date;
  final int seconds;

  Record({this.id, required this.date, required this.seconds});

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date.toIso8601String(),
        'seconds': seconds,
      };

  factory Record.fromMap(Map<String, dynamic> map) => Record(
        id: map['id'],
        date: DateTime.parse(map['date']),
        seconds: map['seconds'],
      );
}
