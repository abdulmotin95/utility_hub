import 'dart:async';
import 'dart:ui';

class TimerLogic {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  bool isRunning = false;

  int totalDuration = 0;
  int remainingSeconds = 0;

  bool get isTimeSet => hours > 0 || minutes > 0 || seconds > 0;

  Timer? _timer;

  void start(VoidCallback onUpdate, VoidCallback onComplete) {
    totalDuration = hours * 3600 + minutes * 60 + seconds;
    remainingSeconds = totalDuration;
    isRunning = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        onUpdate();
      } else {
        stop();
        onComplete();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    isRunning = false;
  }

  void reset() {
    stop();
    hours = 0;
    minutes = 0;
    seconds = 0;
    totalDuration = 0;
    remainingSeconds = 0;
  }
}
