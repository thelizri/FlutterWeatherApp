import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/networking.dart';

import '../services/location.dart';
import 'subscriber.dart';

class MyGlobalState {
  Location? location;
  Position? currentPosition;
  String API_key = 'f917144d92b39856f84099ffab7d0142';
  String weatherData = 'NULL';
  String forecastData = 'NULL';
  List<Subscriber>? subscribers;

  MyGlobalState() {
    location = Location();
    subscribers = <Subscriber>[];
  }

  void subscribe(Subscriber subscriber) {
    subscribers?.add(subscriber);
  }

  void notifySubscribers() {
    subscribers?.forEach((subscriber) {
      subscriber.update();
    });
  }

  Future getLocationAndWeather() async {
    currentPosition = await location!.getCurrentLocation();

    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${currentPosition!.latitude}&lon=${currentPosition!.longitude}&appid=${API_key}&units=metric';
    NetworkHelper weatherHelper = NetworkHelper(url);
    this.weatherData = await weatherHelper.getWeatherData();

    String url2 =
        'https://api.openweathermap.org/data/2.5/forecast?lat=${currentPosition!.latitude}&lon=${currentPosition!.longitude}&appid=${API_key}&units=metric';
    NetworkHelper forecastHelper = NetworkHelper(url2);
    this.forecastData = await forecastHelper.getWeatherData();

    notifySubscribers();
  }
}
