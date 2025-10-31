import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:hello/splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  try {
    cameras = await availableCameras();
  } catch (e) {
    debugPrint("Error initializing cameras: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi-Utility Hub',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFDFF6FF),
      ),
      home: const SplashScreen(),
    );
  }
}
