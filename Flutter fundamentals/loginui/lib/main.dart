import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: WeatherScreen(),
      ),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class WeatherInfo {
  final DateTime date;
  final String description;
  final int temperature;

  WeatherInfo({
    required this.date,
    required this.description,
    required this.temperature,
  });
}

class _WeatherScreenState extends State<WeatherScreen> {
  final String clearSkyImage =
'https://media.istockphoto.com/id/1458311785/photo/rain-rainy-season-sky.webp?b=1&s=170667a&w=0&k=20&c=TDzHDCbYlQu6voaM4CxCemh3eqITd7jVLxJRCpmPal0=';
  final String cloudyImage =
'https://media.istockphoto.com/id/1458311785/photo/rain-rainy-season-sky.webp?b=1&s=170667a&w=0&k=20&c=TDzHDCbYlQu6voaM4CxCemh3eqITd7jVLxJRCpmPal0=';
  final String rainyImage =
'https://media.istockphoto.com/id/1458311785/photo/rain-rainy-season-sky.webp?b=1&s=170667a&w=0&k=20&c=TDzHDCbYlQu6voaM4CxCemh3eqITd7jVLxJRCpmPal0=';

  List<WeatherInfo> _weeklyWeather = [
    WeatherInfo(date: DateTime.now(), description: 'Clear Sky', temperature: 25),
    WeatherInfo(date: DateTime.now().add(Duration(days: 1)), description: 'Clouds', temperature: 20),
    WeatherInfo(date: DateTime.now().add(Duration(days: 2)), description: 'Rain', temperature: 15),
    // Add more weather information for the week
  ];

  WeatherInfo? _selectedWeatherInfo;

  @override
  void initState() {
    super.initState();
    _selectedWeatherInfo = _weeklyWeather.first;
  }

  String _getDayOfWeek(int weekday) {
    const List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return daysOfWeek[weekday - 1];
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
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: _buildWeatherDetails(),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final WeatherInfo weatherInfo;

  const WeatherCard({required this.weatherInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather Details',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text('Date: ${weatherInfo.date}'),
          Text('Description: ${weatherInfo.description}'),
          Text('Temperature: ${weatherInfo.temperature}°C'),
        ],
      ),
    );
  }
}
