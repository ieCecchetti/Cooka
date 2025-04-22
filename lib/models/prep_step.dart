import 'package:cooka/data/difficulty.dart';

class PrepStep {
  int id; // also the step number
  String description;
  String? image;
  int? time; 
  Difficulty? difficulty;

  PrepStep({
    required this.id,
    required this.description,
    this.image,
    this.time,
    this.difficulty,
  });

  @override
  String toString() {
    return 'PrepStep{id:$id, description: $description, image: $image, time: $time, difficulty: $difficulty}';
  }
}
