import 'package:flutter/material.dart';
import '../logic/stop_watch_logic.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final StopwatchLogic logic = StopwatchLogic();

  final List<Color> _gradientColors = [
    const Color(0xFF5C91D4),
    const Color(0xFF4451C8),
    const Color(0xFF1F4ABE),
  ];

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isPrimary,
  }) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isPrimary ? Colors.white : Colors.white12,
        boxShadow: isPrimary
            ? [
          BoxShadow(
            color: Colors.black26,
            offset: const Offset(0, 4),
            blurRadius: 6,
          )
        ]
            : null,
      ),
      child: IconButton(
        icon: Icon(icon, size: 28),
        color: isPrimary ? const Color(0xFF1F4ABE) : Colors.white70,
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = logic.formattedTime();
    final bool hasStarted = logic.duration > Duration.zero;

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
          'Stopwatch',
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
        child: Column(
          children: [
            const SizedBox(height: kToolbarHeight + 20),
            Expanded(
              child: Center(
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.white12, Colors.white24],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    icon: Icons.refresh,
                    onPressed: hasStarted && !logic.isRunning ? () => logic.reset(() => setState(() {})) : null,
                    isPrimary: false,
                  ),
                  _buildActionButton(
                    icon: logic.isRunning ? Icons.pause : Icons.play_arrow,
                    onPressed: logic.isRunning
                        ? () => logic.pause(() => setState(() {}))
                        : () => logic.start(() => setState(() {})),
                    isPrimary: true,
                  ),
                  _buildActionButton(
                    icon: Icons.flag_outlined,
                    onPressed: logic.isRunning ? () => print('Lap at $formattedTime') : null,
                    isPrimary: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
