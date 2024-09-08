import 'dart:convert';

class Workout {
  final String id;
  final String name;
  final String imagePath;
  final DateTime date;
  final bool isCompletedToday;
  final int? value;

  Workout({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.date,
    required this.isCompletedToday,
    this.value,
  });

  Workout copyWith({
    String? id,
    String? name,
    String? imagePath,
    DateTime? date,
    bool? isCompletedToday,
    int? value,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      date: date ?? this.date,
      isCompletedToday: isCompletedToday ?? this.isCompletedToday,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imagePath': imagePath,
    'date': date.toIso8601String(),
    'isCompletedToday': isCompletedToday,
    'value': value,
  };

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
    id: json['id'],
    name: json['name'],
    imagePath: json['imagePath'],
    date: DateTime.parse(json['date']),
    isCompletedToday: json['isCompletedToday'],
    value: json['value'],
  );
}
