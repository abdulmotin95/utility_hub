import 'dart:ui';
import 'package:flutter/material.dart';
import '../logic/voice_logic.dart';

class VoiceRecorderPage extends StatefulWidget {
  const VoiceRecorderPage({super.key});

  @override
  State<VoiceRecorderPage> createState() => _VoiceRecorderPageState();
}

class _VoiceRecorderPageState extends State<VoiceRecorderPage> {
  final VoiceRecorderLogic logic = VoiceRecorderLogic();

  @override
  void initState() {
    super.initState();
    logic.initAudio().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5C91D4),
              Color(0xFF4451C8),
              Color(0xFF1F4ABE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Top Row
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "     🎙️ Voice Recorder",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Voice Icon Circle
                Center(
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                        width: 1.5,
                      ),
                    ),
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Center(
                          child: Icon(
                            logic.isRecording ? Icons.mic : Icons.mic_none,
                            color: logic.isRecording
                                ? Colors.redAccent
                                : Colors.white,
                            size: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                ElevatedButton.icon(
                  onPressed: () {
                    if (logic.isRecording) {
                      logic.stopRecording(() => setState(() {}));
                    } else {
                      logic.startRecording(() => setState(() {}));
                    }
                  },
                  icon: Icon(
                    logic.isRecording ? Icons.stop : Icons.mic,
                    color: Colors.white,
                  ),
                  label: Text(
                    logic.isRecording ? "Stop Recording" : "Start Recording",
                    style: const TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    logic.isRecording ? Colors.redAccent : const Color(0xFF00B4DB),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                ),

                const SizedBox(height: 40),
                const Divider(color: Colors.white54),
                const Text(
                  "🎧 Saved Recordings",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: logic.recordings.isEmpty
                      ? const Center(
                    child: Text(
                      "No recordings yet!",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  )
                      : ListView.builder(
                    itemCount: logic.recordings.length,
                    itemBuilder: (context, index) {
                      final path = logic.recordings[index];
                      final name = path.split('/').last;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.25),
                              ),
                            ),
                            child: ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  logic.isPlaying
                                      ? Icons.stop_circle
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  logic.playRecording(
                                      path, () => setState(() {}));
                                },
                              ),
                              title: Text(
                                name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                path,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white70),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent),
                                onPressed: () {
                                  logic.deleteRecording(path);
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
