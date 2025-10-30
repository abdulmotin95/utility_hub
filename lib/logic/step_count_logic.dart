import 'package:pedometer/pedometer.dart';

class StepCounterLogic {
  late Stream<StepCount> _stepCountStream;
  int _initialStep = 0;
  int _steps = 0;

  final double stepLengthInMeters;
  final double kcalPerStep;

  StepCounterLogic({this.stepLengthInMeters = 0.762, this.kcalPerStep = 0.04});

  Stream<int> getStepCountStream() {
    _stepCountStream = Pedometer.stepCountStream;

    return _stepCountStream.map((event) {
      if (_initialStep == 0) {
        _initialStep = event.steps;
      }
      _steps = event.steps - _initialStep;
      if (_steps < 0) _steps = 0;
      return _steps;
    });
  }

  double get distanceKm => _steps * stepLengthInMeters / 1000;
  double get kcal => _steps * kcalPerStep;
  double get cal => kcal * 0.01;
}
