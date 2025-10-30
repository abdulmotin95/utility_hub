import 'package:flutter/material.dart';
import 'package:hello/all_screen_ui/text_pdf_page.dart';
import 'image_pdf_page.dart';
import 'dart:math';

class ScannerPDFPage extends StatefulWidget {
  const ScannerPDFPage({super.key});

  @override
  State<ScannerPDFPage> createState() => _ScannerPDFPageState();
}

class _ScannerPDFPageState extends State<ScannerPDFPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _scaleAnimation =
        Tween<double>(begin: 0.8, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
          child: Stack(
            children: [

              const Positioned.fill(child: AnimatedCircles()),

              Column(
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
                              'Documents',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),

                  Expanded(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Column(
                          children: [
                            const Spacer(flex: 3),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Column(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const TextPdfPage()),
                                      );
                                    },
                                    icon: const Icon(Icons.text_fields, color: Colors.white),
                                    label: const Text(
                                      'Text PDF',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue.shade700,
                                      minimumSize: const Size.fromHeight(50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 5,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const CameraPdfPage()),
                                      );
                                    },
                                    icon: const Icon(Icons.image, color: Colors.white),
                                    label: const Text(
                                      'Image PDF',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green.shade700,
                                      minimumSize: const Size.fromHeight(50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 5,
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class AnimatedCircles extends StatefulWidget {
  const AnimatedCircles({super.key});

  @override
  State<AnimatedCircles> createState() => _AnimatedCirclesState();
}

class _AnimatedCirclesState extends State<AnimatedCircles>
    with SingleTickerProviderStateMixin {
  late AnimationController _circleController;

  @override
  void initState() {
    super.initState();
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _circleController,
      builder: (context, child) {
        return CustomPaint(
          painter: _CirclePainter(animationValue: _circleController.value),
          child: Container(),
        );
      },
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double animationValue;
  final Random random = Random();

  _CirclePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.1);

    final positions = [
      Offset(size.width * 0.2, size.height * 0.3 + 30 * sin(animationValue * 2 * pi)),
      Offset(size.width * 0.8, size.height * 0.5 + 40 * cos(animationValue * 2 * pi)),
      Offset(size.width * 0.5, size.height * 0.7 + 20 * sin(animationValue * 2 * pi)),
    ];

    for (var pos in positions) {
      canvas.drawCircle(pos, 50, paint);
    }


    final iconPainter = TextPainter(
      text: TextSpan(
        text: '📄',
        style: TextStyle(
          fontSize: 60,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    iconPainter.layout();


    final iconX = size.width * 0.5;
    final iconY = size.height * 0.45 + 20 * sin(animationValue * 2 * pi);

    iconPainter.paint(canvas, Offset(iconX - iconPainter.width / 2, iconY - iconPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant _CirclePainter oldDelegate) => true;
}
