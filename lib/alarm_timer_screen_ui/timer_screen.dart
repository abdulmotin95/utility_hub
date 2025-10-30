import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../logic/timer_logic.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final TimerLogic logic = TimerLogic();

  final List<Color> _gradientColors = [
    const Color(0xFF5C91D4),
    const Color(0xFF4451C8),
    const Color(0xFF1F4ABE),
  ];

  void _showCompletionNotification() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.alarm, color: Color(0xFF1F4ABE), size: 48),
              const SizedBox(height: 12),
              const Text(
                "Timer Complete!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              const Text(
                "Your set time has elapsed.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F4ABE),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    logic.reset();
                    setState(() {});
                  },
                  child: const Text("OK", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  void _startStopTimer() {
    if (logic.isRunning) {
      logic.stop();
    } else {
      logic.start(() => setState(() {}), _showCompletionNotification);
    }
    setState(() {});
  }

  Widget _buildPicker(int value, int maxValue, Function(int) onChanged, bool isDisabled) {
    final List<int> values = List<int>.generate(maxValue + 1, (i) => i);
    return SizedBox(
      width: 80,
      height: 200,
      child: AbsorbPointer(
        absorbing: isDisabled,
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(initialItem: value),
          itemExtent: 50,
          onSelectedItemChanged: onChanged,
          looping: true,
          children: values.map((i) => Center(
            child: Text(
              i.toString().padLeft(2,'0'),
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: isDisabled ? Colors.white38 : Colors.white,
              ),
            ),
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildLabel(String label, bool isDisabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(label, style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isDisabled ? Colors.white38 : Colors.white70,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDisabled = logic.isRunning;
    bool isTimeSet = logic.isTimeSet;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Timer',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _gradientColors,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 150,),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPicker(logic.hours, 99, (v) => setState(() => logic.hours = v), isDisabled),
                    _buildLabel('h', isDisabled),
                    _buildPicker(logic.minutes, 59, (v) => setState(() => logic.minutes = v), isDisabled),
                    _buildLabel('m', isDisabled),
                    _buildPicker(logic.seconds, 59, (v) => setState(() => logic.seconds = v), isDisabled),
                    _buildLabel('s', isDisabled),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              // Circular progress below picker
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background circle
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white12,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    // Gradient Circular Progress
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: logic.totalDuration > 0
                            ? (logic.totalDuration - logic.remainingSeconds) / logic.totalDuration
                            : 0,
                        strokeWidth: 8,
                        valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF42A5F5)),
                        backgroundColor: Colors.white70,
                      ),
                    ),
                    // Center small circle
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF1F4ABE),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: isTimeSet ? () { logic.reset(); setState(() {}); } : null,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: isTimeSet ? Colors.white12 : Colors.white10,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isTimeSet ? Colors.white38 : Colors.white24,
                            width: 1.5,
                          ),
                        ),
                        child: Icon(Icons.refresh, color: isTimeSet ? Colors.white : Colors.white38, size: 28),
                      ),
                    ),
                    // Start/Pause button
                    InkWell(
                      onTap: isTimeSet || logic.isRunning ? _startStopTimer : null,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 60,
                        height: 70,
                        decoration: BoxDecoration(
                          color: isTimeSet || logic.isRunning ? Colors.white : Colors.white12,
                          shape: BoxShape.circle,
                          boxShadow: isTimeSet || logic.isRunning
                              ? [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))]
                              : [],
                        ),
                        child: Icon(
                          logic.isRunning ? Icons.pause : Icons.play_arrow,
                          color: isTimeSet || logic.isRunning ? Color(0xFF1F4ABE) : Colors.white38,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
