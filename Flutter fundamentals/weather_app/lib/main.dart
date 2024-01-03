// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

// Add image URLs for different weather descriptions
const String clearSkyImage = 'https://www.istockphoto.com/en/search/2/image?mediatype=&phrase=weather&utm_source=pixabay&utm_medium=affiliate&utm_campaign=SRP_image_sponsored&utm_content=https%3A%2F%2Fpixabay.com%2Fimages%2Fsearch%2Fweather%2F&utm_term=weather';
const String cloudyImage = 'data:image/jpeg;base64,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';
const String rainyImage = 'https://media.istockphoto.com/id/1458311785/photo/rain-rainy-season-sky.webp?b=1&s=170667a&w=0&k=20&c=TDzHDCbYlQu6voaM4CxCemh3eqITd7jVLxJRCpmPal0=';

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

  Widget _buildWeatherDetails() {
    if (_selectedWeatherInfo == null) return Container();

    String backgroundImageUrl;
    switch (_selectedWeatherInfo!.description.toLowerCase()) {
      case 'clear sky':
        backgroundImageUrl = clearSkyImage;
        break;
      case 'clouds':
        backgroundImageUrl = cloudyImage;
        break;
      case 'rain':
        backgroundImageUrl = rainyImage;
        break;
      default:
        backgroundImageUrl = clearSkyImage; // Default to clear sky image
        break;
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(backgroundImageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getDayOfWeek(_selectedWeatherInfo!.date.weekday),
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
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
                _buildWeatherDetails(),
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
