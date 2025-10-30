import 'package:flutter/material.dart';
import 'package:hello/alarm_timer_screen_ui/stop_watch_sreen.dart';
import 'package:hello/alarm_timer_screen_ui/timer_screen.dart';
import 'clock_screen.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  bool _hasAlarms = false;

  final List<Color> _gradientColors = [
    const Color(0xFF5C91D4),
    const Color(0xFF4451C8),
    const Color(0xFF1F4ABE),
  ];

  final String _emptyStateImageUrl =
      'https://ouch-cdn2.icons8.com/d0bYp2qg_j-wYQ6F1gYn1hR9xK6a4B9FfB4xLpM-13Q/rs:fit:368:368/czM6Ly9pY29uczguY3Nkbi5pby9wZ2cvNDA5LzI0ZjgxMDdlLTAxYjUtNDg5Zi05ZTcyLWU4YjY5YjJjNWUyNS5wbmc.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Alarm',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
              child: _hasAlarms
                  ? const Center(
                child: Text(
                  'Alarm List will go here',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              )
                  : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      _emptyStateImageUrl,
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, color: Colors.red, size: 80),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          height: 200,
                          width: 200,
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white)),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'No Alarms',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 45),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildNavItem(Icons.alarm, 'Alarm', true, () {}),


                  _buildNavItem(Icons.access_time, 'Clock', false, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClockScreen()),
                    );
                  }),


                  _buildNavItem(Icons.add_circle, '', false, () {
                    setState(() {
                      _hasAlarms = !_hasAlarms;
                    });
                    }, iconSize: 50, isAddButton: true),


                  _buildNavItem(Icons.timer, 'Timer', false, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimerScreen()),
                    );
                  }),



                  _buildNavItem(Icons.watch_later_outlined, 'Stopwatch', false, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StopwatchScreen()),
                    );
                  }),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected, VoidCallback onTap,
      {double iconSize = 30, bool isAddButton = false}) {
    final color = isSelected ? Colors.white : Colors.white54;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isAddButton ? Colors.white : color, size: iconSize),
          if (!isAddButton) ...[
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}
