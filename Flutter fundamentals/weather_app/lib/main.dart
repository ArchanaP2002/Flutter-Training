// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _pinController = TextEditingController();
  List<WeatherInfo> _weeklyWeather = [];
  WeatherInfo? _selectedWeatherInfo;
  bool _showWeatherInfo = false;

  void _setDefaultWeather() {
    final DateTime currentDate = DateTime.now().toLocal();
    final DateTime currentDateWithoutTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day);

    _selectedWeatherInfo = _weeklyWeather.firstWhere(
      (weather) {
        final DateTime weatherDateWithoutTime =
            DateTime(weather.date.year, weather.date.month, weather.date.day);
        return weatherDateWithoutTime.isAtSameMomentAs(currentDateWithoutTime);
      },
      orElse: () =>
          _weeklyWeather.first, // Default to the first entry if not found
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getWeeklyWeather(String location) async {
    const apiKey = '1386de923ccb808fc0965373473f8df5';
    final isZipCode = int.tryParse(location) != null;

    final url = isZipCode
        ? 'https://api.openweathermap.org/data/2.5/forecast?zip=$location,in&units=metric&appid=$apiKey'
        : 'https://api.openweathermap.org/data/2.5/forecast?q=$location&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> dailyData = data['list'];

        Map<int, WeatherInfo> dailyWeatherMap = {};

        for (var dayData in dailyData) {
          final DateTime date =
              DateTime.fromMillisecondsSinceEpoch(dayData['dt'] * 1000);
          final int dayOfWeek = date.weekday;

          final String iconCode = dayData['weather'][0]['icon'];
          final double temperature = dayData['main']['temp'];
          final double humidity = dayData['main']['humidity'];
          final String description = dayData['weather'][0]['description'];

          dailyWeatherMap[dayOfWeek] = WeatherInfo(
            iconCode: iconCode,
            date: date,
            temperature: temperature,
            humidity: humidity,
            description: description,
          );
        }

        setState(() {
          _weeklyWeather = dailyWeatherMap.values.toList();
          _showWeatherInfo = true;
          _setDefaultWeather(); // Set the default weather for the current day
        });
      } else {
        setState(() {
          _weeklyWeather.clear();
          _selectedWeatherInfo = null;
          _showWeatherInfo = false;
        });
      }
    } catch (e) {
      setState(() {
        _weeklyWeather.clear();
        _selectedWeatherInfo = null;
        _showWeatherInfo = false;
      });
    }
  }

/*
  Future<void> _getWeeklyWeather(String pinCode) async {
    const apiKey = '1386de923ccb808fc0965373473f8df5';
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?zip=$pinCode,in&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> dailyData = data['list'];

        Map<int, WeatherInfo> dailyWeatherMap = {};

        for (var dayData in dailyData) {
          final DateTime date =
              DateTime.fromMillisecondsSinceEpoch(dayData['dt'] * 1000);
          final int dayOfWeek = date.weekday;

          final String iconCode = dayData['weather'][0]['icon'];
          final double temperature = dayData['main']['temp'];
          final double humidity = dayData['main']['humidity'];
          final String description = dayData['weather'][0]['description'];

          dailyWeatherMap[dayOfWeek] = WeatherInfo(
            iconCode: iconCode,
            date: date,
            temperature: temperature,
            humidity: humidity,
            description: description,
          );
        }

        setState(() {
          _weeklyWeather = dailyWeatherMap.values.toList();
          _setDefaultWeather(); // Set the default weather for the current day
          _showWeatherInfo = true;
        });
      } else {
        setState(() {
          _weeklyWeather.clear();
          _selectedWeatherInfo = null;
          _showWeatherInfo = false;
        });
      }
    } catch (e) {
      setState(() {
        _weeklyWeather.clear();
        _selectedWeatherInfo = null;
        _showWeatherInfo = false;
      });
    }
  }
*/
  String _getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Sunday';
      case 2:
        return 'Monday';
      case 3:
        return 'Tuesday';
      case 4:
        return 'Wednesday';
      case 5:
        return 'Thursday';
      case 6:
        return 'Friday';
      case 7:
        return 'Saturday';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.grey.shade900],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_showWeatherInfo) ...[
                Container(
                  child: Image.network(
                    'https://openweathermap.org/img/w/${_selectedWeatherInfo!.iconCode}.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '${_selectedWeatherInfo!.temperature}°C',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  height: 40.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _weeklyWeather.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedWeatherInfo = _weeklyWeather[index];
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: _selectedWeatherInfo?.date.weekday ==
                                    _weeklyWeather[index].date.weekday
                                ? Colors.blue.shade200
                                : Colors.blue,
                          ),
                          child: Text(
                            _getDayOfWeek(_weeklyWeather[index].date.weekday),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                WeatherCard(weatherInfo: _selectedWeatherInfo!),
              ] else ...[
                TextField(
                  controller: _pinController,
                  decoration: InputDecoration(
                    labelText: 'Enter PIN Code Or Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: const TextStyle(color: Colors.blue),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _getWeeklyWeather(_pinController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                  ),
                  child: const Text(
                    'Get Weather',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherDetailsScreen extends StatelessWidget {
  final List<WeatherInfo> weeklyWeather;
  final Function(WeatherInfo) onDaySelected;

  const WeatherDetailsScreen({
    Key? key,
    required this.weeklyWeather,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
      ),
      body: ListView.builder(
        itemCount: weeklyWeather.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onDaySelected(weeklyWeather[index]);
            },
            child: WeatherCard(weatherInfo: weeklyWeather[index]),
          );
        },
      ),
    );
  }
}

class WeatherInfo {
  final DateTime date;
  final double temperature;
  final double humidity;
  final String description;
  final String iconCode;

  WeatherInfo({
    required this.date,
    required this.temperature,
    required this.humidity,
    required this.description,
    required this.iconCode,
  });
}

class WeatherCard extends StatelessWidget {
  final WeatherInfo weatherInfo;

  const WeatherCard({Key? key, required this.weatherInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildWeatherDetails(),
            _buildWeatherIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getDayOfWeek(weatherInfo.date.weekday),
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Date: ${weatherInfo.date.toLocal()}',
          style: const TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        const SizedBox(height: 8.0),
        _buildIconWithText(
          Icons.thermostat,
          'Temperature  ',
          '${weatherInfo.temperature}°C  ',
        ),
        _buildIconWithText(
          Icons.opacity,
          'Humidity ',
          '${weatherInfo.humidity}%  ',
        ),
        _buildIconWithText(
          Icons.description,
          'Description',
          weatherInfo.description,
        ),
      ],
    );
  }

  Widget _buildWeatherIcon() {
    return Image.network(
      'https://openweathermap.org/img/w/${weatherInfo.iconCode}.png',
      scale: 2.0,
    );
  }

  Widget _buildIconWithText(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 24.0, color: Colors.white),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14.0, color: Colors.white),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Sunday';
      case 2:
        return 'Monday';
      case 3:
        return 'Tuesday';
      case 4:
        return 'Wednesday';
      case 5:
        return 'Thursday';
      case 6:
        return 'Friday';
      case 7:
        return 'Saturday';
      default:
        return '';
    }
  }
}
