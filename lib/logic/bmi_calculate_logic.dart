
import 'dart:ui';

class BMILogic {
  final int weight;
  final double height;

  BMILogic({required this.weight, required this.height});

  double _calculateBMI() {

    double heightInMeters = height * 0.3048;

    return weight / (heightInMeters * heightInMeters);
  }

  Map<String, dynamic> getBMIInterpretation() {
    double bmi = _calculateBMI();

    if (bmi < 18.5) {
      return {'bmi': bmi.toStringAsFixed(1), 'status': 'Underweight', 'color': const Color(0xFF1976D2)}; // Darker Blue
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return {'bmi': bmi.toStringAsFixed(1), 'status': 'Normal', 'color': const Color(0xFF4CAF50)}; // Green
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      return {'bmi': bmi.toStringAsFixed(1), 'status': 'Overweight', 'color': const Color(0xFFFBC02D)}; // Darker Yellow
    } else {
      return {'bmi': bmi.toStringAsFixed(1), 'status': 'Obese', 'color': const Color(0xFFD32F2F)}; // Darker Red
    }
  }

  String getHealthyWeightRange() {
    double heightInMeters = height * 0.3048;
    double minWeight = 18.5 * (heightInMeters * heightInMeters);
    double maxWeight = 24.9 * (heightInMeters * heightInMeters);

    return '${minWeight.toStringAsFixed(1)} kg - ${maxWeight.toStringAsFixed(1)} kg';
  }
}