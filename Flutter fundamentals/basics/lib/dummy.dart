import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'api.dart';

class BasicScreen extends StatefulWidget {
  const BasicScreen({super.key});

  @override
  State<BasicScreen> createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen> {
  late String temperature;
  late String description;
  late String windSpeed;
  late String humidity;
  late String locationName;
  late String formattedDate;
  late String formattedTime;
  late String formattedDay;
  late String date;
  late String day;

  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDefaultLocationAndData();
    // fetchData();
  }

  Future<void> fetchDefaultLocationAndData() async {
    try {
      // Fetch the current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final apiKey = '1386de923ccb808fc0965373473f8df5';

      // Check if a custom location is already provided
      // String location = locationController.text.isNotEmpty
      //     ? locationController.text
      //     : '${position.latitude},${position.longitude}';

      final data = await WeatherAPI.fetchWeatherByCoordinates(
          apiKey, position.latitude, position.longitude);

      setState(() {
        temperature = data['main']['temp'].toString();
        description = data['weather'][0]['description'];
        windSpeed = data['wind']['speed'].toString();
        humidity = data['main']['humidity'].toString();
        locationName = data['name'];
        date = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000)
            .toLocal()
            .toString();
        formattedDate = (DateTime.parse(date).month == 1)
            ? DateFormat('d MMM ,yy').format(DateTime.parse(date))
            : DateFormat('d MMMM ,yy').format(DateTime.parse(date));
      });
      formattedTime = DateFormat('hh:mm a').format(DateTime.parse(date));
      formattedDay = DateFormat('EEEE').format(DateTime.parse(date));
    } catch (e) {
      // Handle the error
      print('Error: $e');
    }
  }

  Future<void> fetchData() async {
    final apiKey = '1386de923ccb808fc0965373473f8df5';
    //final location = 'Chennai';
    final location = locationController.text.isNotEmpty
        ? locationController.text
        : 'Chennai';

    try {
      final data = await WeatherAPI.fetchWeather(apiKey, location);
      setState(() {
        temperature = data['main']['temp'].toString();
        description = data['weather'][0]['description'];
        windSpeed = data['wind']['speed'].toString();
        humidity = data['main']['humidity'].toString();
        locationName = data['name'];
               date = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000)
            .toLocal()
            .toString();
        formattedDate = (DateTime.parse(date).month == 1)
            ? DateFormat('d MMM ,yy').format(DateTime.parse(date))
            : DateFormat('d MMMM ,yy').format(DateTime.parse(date));
      });
      formattedTime = DateFormat('hh:mm a').format(DateTime.parse(date));
      formattedDay = DateFormat('EEEE').format(DateTime.parse(date));
        //  day = DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000));
    } catch (e) {
      // Handle the error
      print('Error: $e');
    }
  }

  // Function to open a search dialog
  Future<void> _openSearchDialog() async {
    String searchQuery = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Location'),
          content: TextField(
            controller: locationController,
            decoration:
                const InputDecoration(labelText: 'Enter Location or Zip Code'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(locationController.text);
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );

    if (searchQuery.isNotEmpty) {
      // Update the location and fetch data
      locationController.text = searchQuery;
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Basics"),
        //   centerTitle: true,
        // ),
        body: Stack(
      //Stack can position widgets over one another.
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [Colors.blue, Colors.blueGrey.shade900]),
          // ),
          child: Image.network(
            'https://cdn.pixabay.com/photo/2023/05/30/15/53/clouds-8029036_1280.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            // search icon
            top: 10,
            left: 20,
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 32,
              ),
              onPressed: _openSearchDialog,
            )),
        Positioned(
            // menu icon
            top: 10,
            right: 20,
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {},
            )),
        Positioned(
          top: 100,
          left: 30,
          // child: Text(
          //   'Location',
          //   style: TextStyle(color: Colors.white, fontSize: 20),
          // )
          child: Column(
            children: [
              Text(
                '$locationName',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                '$formattedTime - $formattedDay $formattedDate ',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
        // temperature
        Positioned(
            top: 300,
            left: 30,
            child: Text(
              '$temperature',
              style: TextStyle(color: Colors.white, fontSize: 60),
            )),

        // Description
        Positioned(
            top: 380,
            left: 50,
            child: Row(
              children: [
                const Icon(
                  Icons.cloud,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  ' $description',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            )),

        // Divider line
        Positioned(
          top: 440,
          left: 30,
          right: 30,
          child: Container(
            color: Colors.transparent,
            child: const Divider(
              // color: Colors.white,
              thickness: 2,
            ),
          ),
        ),

// Wind
        Positioned(
          top: 480,
          left: 20,
          right: 280,
          child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  const Text(
                    'Wind',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Text('$windSpeed',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const Text('Km/h \n',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  const Divider(
                    // color: Colors.white,
                    thickness: 1,
                  ),
                ],
              )),
        ),

//Temperature
        Positioned(
          top: 480,
          left: 140,
          right: 160,
          child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  const Text(
                    'Temp',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Text('$temperature',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const Text('%\n',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  const Divider(
                    // color: Colors.white,
                    thickness: 1,
                  ),
                ],
              )),
        ),

        //Humidity
        Positioned(
          top: 480,
          left: 260,
          right: 20,
          child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  const Text(
                    'Humidity',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Text('$humidity',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const Text('% \n',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  const Divider(
                    // color: Colors.white,
                    thickness: 1,
                  ),
                ],
              )),
        )
      ],
    ));
  }
}
