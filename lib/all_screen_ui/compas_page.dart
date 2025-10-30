import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;
import '../logic/compass_logic.dart';

class CompassScreen extends StatelessWidget {
  CompassScreen({super.key});
  final CompassLogic logic = CompassLogic();

  Widget buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Compass not available: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        double? direction = snapshot.data!.heading;

        if (direction == null) {
          return const Center(
            child: Text(
              "Sorry, your device does not support compass.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        }

        double rotationAngle = logic.getRotationAngle(direction);
        String cardinalDirection = logic.getCardinalDirection(direction);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                '${direction.toStringAsFixed(0)}° $cardinalDirection',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey.shade700, Colors.grey.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              child: Transform.rotate(
                angle: rotationAngle,
                child: CustomPaint(
                  painter: CompassNeedlePainter(),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white24),
              ),
              child: const Text(
                'Guide:\n🔴 The red part always points to North. This is your actual direction.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
          ],
        );
      },
    );
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
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Digital Compass',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              Expanded(child: Center(child: buildCompass())),
            ],
          ),
        ),
      ),
    );
  }
}

class CompassNeedlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final redPaint = Paint()..color = Colors.red..style = PaintingStyle.fill;
    final greyPaint = Paint()..color = Colors.white70..style = PaintingStyle.fill;

    canvas.translate(center.dx, center.dy);

    Path northPath = Path()
      ..moveTo(0, -radius * 0.8)
      ..lineTo(radius * 0.1, 0)
      ..lineTo(-radius * 0.1, 0)
      ..close();
    canvas.drawPath(northPath, redPaint);

    Path southPath = Path()
      ..moveTo(0, radius * 0.8)
      ..lineTo(radius * 0.1, 0)
      ..lineTo(-radius * 0.1, 0)
      ..close();
    canvas.drawPath(southPath, greyPaint);

    final textStyle = const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

    _drawText(canvas, 'N', -100, 0, textStyle);
    _drawText(canvas, 'S', 100, 180, textStyle);
    _drawText(canvas, 'E', 100, 90, textStyle);
    _drawText(canvas, 'W', 100, 270, textStyle);
    _drawText(canvas, 'NE', -70, 45, textStyle);
    _drawText(canvas, 'SE', 70, 135, textStyle);
    _drawText(canvas, 'SW', 70, 225, textStyle);
    _drawText(canvas, 'NW', -70, 315, textStyle);

    canvas.translate(-center.dx, -center.dy);
  }

  void _drawText(Canvas canvas, String text, double offset, double angleDegrees, TextStyle style) {
    canvas.save();
    double angle = angleDegrees * (math.pi / 180);
    canvas.rotate(angle);
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout();
    double x = -textPainter.width / 2;
    double y = -offset - textPainter.height / 2;
    textPainter.paint(canvas, Offset(x, y));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
