import 'dart:async';
import 'dart:ui';

class StopwatchLogic {
  Duration duration = Duration.zero;
  Timer? _timer;
  bool isRunning = false;

  void start(VoidCallback onUpdate) {
    if (isRunning) return;
    isRunning = true;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      duration += const Duration(milliseconds: 10);
      onUpdate();
    });
  }

  void pause(VoidCallback onUpdate) {
    _timer?.cancel();
    isRunning = false;
    onUpdate();
  }

  void reset(VoidCallback onUpdate) {
    _timer?.cancel();
    duration = Duration.zero;
    isRunning = false;
    onUpdate();
  }

  String formattedTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final centiseconds = twoDigits((duration.inMilliseconds.remainder(1000) ~/ 10));
    return '$minutes:$seconds.$centiseconds';
  }
}
