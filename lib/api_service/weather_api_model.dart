import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "509079b22fae7e954dff8403ef5eba0e";
  final double lat = 24.886436;
  final double lon = 91.880722;

  Future<Map<String, dynamic>?> fetchWeather() async {
    final String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}
