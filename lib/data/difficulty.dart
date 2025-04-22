import 'package:flutter/material.dart';

enum Difficulty {
  easy,
  medium,
  hard,
}

extension DifficultyExtension on Difficulty {
  String get getText {
    switch (this) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.hard:
        return 'Hard';
    }
  }

  Widget get getIcon {
    switch (this) {
      case Difficulty.easy:
        return Icon(Icons.check_circle_outline, color: Colors.green);
      case Difficulty.medium:
        return Icon(Icons.warning_amber_outlined, color: Colors.orange);
      case Difficulty.hard:
        return Icon(Icons.error_outline, color: Colors.red);
    }
  }

  Color get getColor {
    switch (this) {
      case Difficulty.easy:
        return Colors.green; // Green
      case Difficulty.medium:
        return Colors.orange; // Yellow
      case Difficulty.hard:
        return Colors.red; // Red
    }
  }
}