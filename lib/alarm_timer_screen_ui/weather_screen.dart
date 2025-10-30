import 'package:flutter/material.dart';
import '../api_service/weather_api_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> with SingleTickerProviderStateMixin {
  Map<String, dynamic>? weatherData;
  bool isLoading = true;
  final WeatherService _weatherService = WeatherService();

  late AnimationController _controller;
  late Animation<Color?> _bgAnimation;

  @override
  void initState() {
    super.initState();
    _loadWeather();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _bgAnimation = ColorTween(
      begin: const Color(0xFF5C91D4),
      end: const Color(0xFF1F4ABE),
    ).animate(_controller);
  }

  Future<void> _loadWeather() async {
    final data = await _weatherService.fetchWeather();
    setState(() {
      weatherData = data;
      isLoading = false;
    });
  }

  String _getWeatherIcon(String main) {
    switch (main.toLowerCase()) {
      case "clear":
        return "☀️";
      case "clouds":
        return "☁️";
      case "rain":
        return "🌧️";
      case "snow":
        return "❄️";
      case "thunderstorm":
        return "⛈️";
      case "drizzle":
        return "🌦️";
      case "mist":
      case "fog":
        return "🌫️";
      default:
        return "🌡️";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bgAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _bgAnimation.value,
          body: SafeArea(
            child: isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : weatherData == null
                ? const Center(
              child: Text(
                "Failed to load weather data",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
                : SingleChildScrollView(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: const Text(
                      'Weather App',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    weatherData!['name'],
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.1)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          _getWeatherIcon(weatherData!['weather'][0]['main']),
                          style: const TextStyle(fontSize: 50),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${weatherData!['main']['temp'].toString()} °C",
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          weatherData!['weather'][0]['description'],
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _weatherInfoCard(
                        title: "Humidity",
                        value: "${weatherData!['main']['humidity']}%",
                        icon: Icons.water_drop,
                      ),
                      _weatherInfoCard(
                        title: "Wind",
                        value: "${weatherData!['wind']['speed']} m/s",
                        icon: Icons.air,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _weatherInfoCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
