import 'package:flutter/material.dart';
import 'package:hello/all_screen_ui/scanner_pdf_page.dart';
import 'package:hello/all_screen_ui/voice_recorder.dart';
import '../alarm_timer_screen_ui/alarm_home_screen.dart';
import '../alarm_timer_screen_ui/bangla_calendar_screen.dart';
import '../alarm_timer_screen_ui/news_screen.dart';
import '../alarm_timer_screen_ui/weather_screen.dart';
import '../alarm_timer_screen_ui/step_screen.dart';
import 'calculator_page.dart';
import 'compas_page.dart';
import 'note_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                expandedHeight: 130,
                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'Multi-Utility Hub',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 20,
                  children: [
                    _Tile(
                      title: 'Voice Record',
                      subtitle: 'Audio Capture',
                      icon: Icons.mic_none_rounded,
                      color: Colors.blueAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const VoiceRecorderPage()),
                        );
                      },
                    ),
                    _Tile(
                      title: 'Scanner/PDF',
                      subtitle: 'Document Convert',
                      icon: Icons.document_scanner_outlined,
                      color: Colors.redAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScannerPDFPage()),
                        );
                      },
                    ),
                    _Tile(
                      title: 'Note Taker',
                      subtitle: 'Text Only',
                      icon: Icons.sticky_note_2_outlined,
                      color: Colors.purpleAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NotesHomePage()),
                        );
                      },
                    ),
                    _Tile(
                      title: 'Calculator',
                      subtitle: 'Quick Math',
                      icon: Icons.calculate,
                      color: Colors.tealAccent.shade700,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CalculatorHome()),
                        );
                      },
                    ),
                    _Tile(
                      title: 'Compass',
                      subtitle: 'Find Directions',
                      icon: Icons.explore_outlined,
                      color: Colors.indigoAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  CompassScreen()),
                        );
                      },
                    ),
                    _Tile(
                      title: 'Alarm/Timer',
                      subtitle: 'Set Alarm',
                      icon: Icons.alarm,
                      color: Colors.pinkAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AlarmPage()),
                        );
                      },
                    ),
                    _Tile(
                      title: 'News',
                      subtitle: 'Bangladesh News',
                      icon: Icons.newspaper,
                      color: Colors.cyan,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NewsPage()),
                        );
                      },
                    ),
                    _Tile(
                      title: 'Weather Info',
                      subtitle: 'Local Weather',
                      icon: Icons.wb_sunny_outlined,
                      color: Colors.orangeAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const WeatherScreen()),
                        );
                      },
                    ),
                    _Tile(
                      title: 'Bangla Calendar',
                      subtitle: 'Know Bangla Date',
                      icon: Icons.calendar_month,
                      color: Colors.deepPurpleAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  BanglaCalendarScreen()),
                        );
                      },
                    ),
                    _Tile(
                      title: 'Health',
                      subtitle: 'Care Your Health',
                      icon: Icons.health_and_safety,
                      color: Colors.lightBlueAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StepCounterPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tile extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _Tile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  State<_Tile> createState() => _TileState();
}

class _TileState extends State<_Tile> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.93);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withOpacity(0.15),
                border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(widget.icon, size: 26, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              widget.subtitle,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
