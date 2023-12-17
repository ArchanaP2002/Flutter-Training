import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _zipController = TextEditingController();
  String _weather = '';

Future<void> _getWeather(String zipCode) async {
  final apiKey = '1386de923ccb808fc0965373473f8df5';  
  final url = 'https://api.openweathermap.org/data/2.5/weather?zip=$zipCode&appid=$apiKey';

  // try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String cityName = data['name'];
      final double temperature = data['main']['temp'];
      final String description = data['weather'][0]['description'];

      setState(() {
        _weather = 'City: $cityName\nTemperature: $temperature°C\nDescription: $description';
      });
    } else {
      setState(() {
        _weather = 'Error fetching weather data: ${response.statusCode}';
      });
    }
  // } catch (e) {
  //   setState(() {
  //     _weather = 'Error: $e';
  //   });
  // }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _zipController,
              decoration: InputDecoration(labelText: 'Enter ZIP Code'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _getWeather(_zipController.text);
              },
              child: Text('Get Weather'),
            ),
            SizedBox(height: 16.0),
            Text(
              _weather,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
