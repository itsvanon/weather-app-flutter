import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('INSERT API KEY');
  Weather? _weather;

  _fetchWeather() async {
    String? cityName = await _weatherService.getCurrentCity();

    final weather = await _weatherService.getWeather(cityName);

    setState(() {
        _weather = weather;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String getWeatherAnimation(String? mainCondition) {
    if( mainCondition == null) return 'assets/sunny.json';

    switch(mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName.toUpperCase() ?? 'loading city...',
              style: const TextStyle(fontWeight: FontWeight.w400, height: 5, fontSize: 25),
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text(
              '${_weather?.temperature.round()}°C',
              style: const TextStyle(fontWeight: FontWeight.normal, height: 5, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}