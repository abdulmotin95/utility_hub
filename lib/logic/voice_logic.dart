import 'dart:async';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class VoiceRecorderLogic {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer player = FlutterSoundPlayer();

  bool isRecording = false;
  bool isPlaying = false;
  String? filePath;
  List<String> recordings = [];

  Timer? _timer;
  int recordDuration = 0;

  Future<void> initAudio() async {
    await Permission.microphone.request();
    await Permission.storage.request();
    await recorder.openRecorder();
    await player.openPlayer();

    Directory dir = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = dir.listSync();
    recordings = files
        .where((f) => f.path.endsWith('.aac'))
        .map((f) => f.path)
        .toList()
      ..sort((a, b) => b.compareTo(a));
  }

  Future<void> startRecording(Function updateState) async {
    Directory dir = await getApplicationDocumentsDirectory();
    filePath = '${dir.path}/record_${DateTime.now().millisecondsSinceEpoch}.aac';
    await recorder.startRecorder(toFile: filePath);

    isRecording = true;
    recordDuration = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      recordDuration++;
      updateState();
    });
    updateState();
  }


  Future<void> stopRecording(Function updateState) async {
    await recorder.stopRecorder();
    _timer?.cancel();

    isRecording = false;
    if (filePath != null) {
      recordings.insert(0, filePath!);
    }
    updateState();
  }

  Future<void> playRecording(String path, Function updateState) async {
    if (isPlaying) {
      await player.stopPlayer();
      isPlaying = false;
    } else {
      isPlaying = true;
      await player.startPlayer(fromURI: path, whenFinished: () {
        isPlaying = false;
        updateState();
      });
    }
    updateState();
  }

  String formatTime(int seconds) {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return "$min:$sec";
  }

  void dispose() {
    recorder.closeRecorder();
    player.closePlayer();
    _timer?.cancel();
  }
  void deleteRecording(String path) {
    File(path).delete();
    recordings.remove(path);
  }
}
