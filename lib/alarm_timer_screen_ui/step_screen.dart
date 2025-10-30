import 'package:flutter/material.dart';
import 'package:hello/logic/step_count_logic.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../all_feature_screen.dart';

class StepCounterPage extends StatefulWidget {
  const StepCounterPage({Key? key}) : super(key: key);

  @override
  State<StepCounterPage> createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  final StepCounterLogic _logic = StepCounterLogic();
  int _steps = 0;

  @override
  void initState() {
    super.initState();
    _logic.getStepCountStream().listen((stepCount) {
      setState(() {
        _steps = stepCount;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const int totalStepsTarget = 10000;
    double progress = _steps / totalStepsTarget;
    if (progress > 1.0) progress = 1.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C91D4),
        title: const Text(
          "StepCounter",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 15.0,
                    percent: progress,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.directions_run, size: 80, color: Colors.white),
                        const SizedBox(height: 10),
                        Text(
                          "${(progress * 100).toInt()}%",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.white24,
                    progressColor: Colors.white,
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 800,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '$_steps',
                    style: const TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    "steps",
                    style: TextStyle(
                        fontSize: 20, color: Colors.white70, letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMetricCircle(
                        value: _logic.kcal.toStringAsFixed(0),
                        unit: "kcal",
                        icon: Icons.local_fire_department,
                        color: Colors.orange.shade200,
                        percent: (_logic.kcal / 500).clamp(0.0, 1.0),
                      ),
                      _buildMetricCircle(
                        value: _logic.distanceKm.toStringAsFixed(2),
                        unit: "km",
                        icon: Icons.route,
                        color: Colors.lightBlue.shade200,
                        percent: (_logic.distanceKm / 8).clamp(0.0, 1.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_fire_department,
                            color: Colors.orange.shade200, size: 30),
                        const SizedBox(width: 10),
                        Text(
                          _logic.cal.toStringAsFixed(0),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade200),
                        ),
                        const SizedBox(width: 5),
                        const Text("cal",
                            style: TextStyle(fontSize: 20, color: Colors.white70)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AllFeaturesPage()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF5C91D4),
                        Color(0xFF4451C8),
                        Color(0xFF1F4ABE),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white70, width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.more, size: 28, color: Colors.white),
                      SizedBox(width: 12),
                      Text(
                        "More Feature",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCircle({
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
    double percent = 0.7,
  }) {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 8.0,
      percent: percent,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87)),
          Text(unit, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
      backgroundColor: Colors.grey.shade300,
      progressColor: color,
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animationDuration: 600,
    );
  }
}
