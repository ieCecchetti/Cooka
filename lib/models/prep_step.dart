import 'package:cooka/data/difficulty.dart';

class PrepStep {
  int id; // also the step number
  String title;
  String description;
  String? image;
  int? time;
  Difficulty? difficulty;

  PrepStep({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    this.time,
    this.difficulty,
  });

  PrepStep copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    int? time,
    Difficulty? difficulty,
  }) {
    return PrepStep(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      time: time ?? this.time,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  @override
  String toString() {
    return 'PrepStep{id:$id, description: $description, image: $image, time: $time, difficulty: $difficulty}';
  }
}
