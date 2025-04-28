import 'package:flutter/material.dart';
import 'weather_service.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String city = 'London';
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    WeatherService service = WeatherService();
    var data = await service.fetchWeather(city);
    setState(() {
      weatherData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: weatherData == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city,
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${weatherData!['main']['temp']}°C',
                      style: TextStyle(fontSize: 48),
                    ),
                    Text(
                      weatherData!['weather'][0]['description'],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          city = 'New York'; // Example city, replace it with user input
                          fetchWeather();
                        });
                      },
                      child: Text('Get Weather for New York'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
