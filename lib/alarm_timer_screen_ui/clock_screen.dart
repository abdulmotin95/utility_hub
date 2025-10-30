import 'dart:math';
import 'package:flutter/material.dart';
import '../logic/clock_logic_page.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  final ClockLogic logic = ClockLogic();

  final List<Color> _gradientColors = [
    const Color(0xFF5C91D4),
    const Color(0xFF4451C8),
    const Color(0xFF1F4ABE),
  ];

  @override
  void initState() {
    super.initState();
    logic.startTimer(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    logic.stopTimer();
    super.dispose();
  }

  Future<void> _editTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: logic.currentDateTime.hour, minute: logic.currentDateTime.minute),
    );
    if (picked != null) {
      logic.setCustomTime(picked.hour, picked.minute);
      setState(() {});
    }
  }

  Future<void> _editDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: logic.currentDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      logic.setCustomDate(picked.year, picked.month, picked.day);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeString = logic.formatTime().split(' ');
    final digitalTime = timeString[0];
    final ampm = timeString[1];
    final dateString = logic.formatDate();

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
          'Clock',
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
          padding: const EdgeInsets.only(top: kToolbarHeight + 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _editTime,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          digitalTime,
                          style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w300, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          ampm,
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: _editDate,
                      child: Column(
                        children: [
                          const Text(
                            'Bangladesh Standard Time',
                            style: TextStyle(fontSize: 14, color: Colors.white70),
                          ),
                          Text(
                            dateString,
                            style: const TextStyle(fontSize: 14, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: CustomPaint(
                      painter: AnalogClockPainter(logic.currentDateTime),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnalogClockPainter extends CustomPainter {
  final DateTime dateTime;
  AnalogClockPainter(this.dateTime);

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX, centerY);
    final double clockRadius = radius * 0.95;

    Paint ringPaint = Paint()
      ..color = Colors.white12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(center, clockRadius, ringPaint);

    Paint tickPaint = Paint()
      ..color = Colors.white54
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 12; i++) {
      final double angle = i * 30 * pi / 180;
      final double tickLength = i % 3 == 0 ? 15 : 8;
      final double x1 = centerX + clockRadius * cos(angle - pi / 2);
      final double y1 = centerY + clockRadius * sin(angle - pi / 2);
      final double x2 = centerX + (clockRadius - tickLength) * cos(angle - pi / 2);
      final double y2 = centerY + (clockRadius - tickLength) * sin(angle - pi / 2);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), tickPaint);
    }

    double hourAngle = (dateTime.hour % 12 + dateTime.minute / 60) * 30 - 90;
    double hourX = centerX + radius * 0.4 * cos(hourAngle * pi / 180);
    double hourY = centerY + radius * 0.4 * sin(hourAngle * pi / 180);
    canvas.drawLine(center, Offset(hourX, hourY), Paint()
      ..color = const Color(0xFF333333)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round);

    double minuteAngle = (dateTime.minute + dateTime.second / 60) * 6 - 90;
    double minX = centerX + radius * 0.65 * cos(minuteAngle * pi / 180);
    double minY = centerY + radius * 0.65 * sin(minuteAngle * pi / 180);
    canvas.drawLine(center, Offset(minX, minY), Paint()
      ..color = const Color(0xFF42A5F5)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round);

    double secondAngle = dateTime.second * 6 - 90;
    double secX = centerX + radius * 0.8 * cos(secondAngle * pi / 180);
    double secY = centerY + radius * 0.8 * sin(secondAngle * pi / 180);
    canvas.drawLine(center, Offset(secX, secY), Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round);

    canvas.drawCircle(center, 12, Paint()..color = Colors.white);
    canvas.drawCircle(center, 8, Paint()..color = const Color(0xFF42A5F5));

    final textStyle = TextStyle(
      color: Colors.white70,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    final numbers = {0: '12', 3: '3', 6: '6', 9: '9'};
    numbers.forEach((hour, text) {
      double angle = hour * 30 * pi / 180 - pi / 2;
      double x = centerX + (clockRadius - 30) * cos(angle);
      double y = centerY + (clockRadius - 30) * sin(angle);
      final textSpan = TextSpan(text: text, style: textStyle);
      final tp = TextPainter(text: textSpan, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
    });
  }

  @override
  bool shouldRepaint(covariant AnalogClockPainter oldDelegate) {
    return oldDelegate.dateTime.second != dateTime.second;
  }
}
