import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherAPI {
  static Future<Map<String, dynamic>> fetchWeather(String apiKey, String location) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$location,in&appid=$apiKey&units=metric';
    return _fetchData(url);
  }

  static Future<Map<String, dynamic>> fetchWeatherByCoordinates(
      String apiKey, double latitude, double longitude) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    return _fetchData(url);
  }

  static Future<Map<String, dynamic>> _fetchData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }
}
