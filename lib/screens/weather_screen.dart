import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/utilities/my_global_state.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen(this.myGlobalState);
  MyGlobalState myGlobalState;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  int temperature = 0;
  String city = 'NULL';
  String country = 'NULL';
  String date = 'NULL';
  String icon = '10d';
  String description = 'NULL';
  String location_background = 'images/location_background.jpg';
  String API_key = 'f917144d92b39856f84099ffab7d0142';
  String weatherData = 'NULL';

  @override
  void initState() {
    super.initState();
    weatherData = widget.myGlobalState.weatherData;
    updateUI();
  }

  void updateUI() {
    setState(() {
      var jsonData = jsonDecode(weatherData);
      temperature = jsonData['main']['temp'].round();
      city = jsonData['name'];
      country = jsonData['sys']['country'];
      date = DateFormat('EEE, MMM d, y - kk:mm').format(DateTime.now());
      icon = jsonData['weather'][0]['icon'];
      description = jsonData['weather'][0]['description'];
    });
  }

  void getLocationAndWeather() async {
    await widget.myGlobalState.getLocationAndWeather();
    weatherData = widget.myGlobalState.weatherData;
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(location_background),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      ),
      constraints: BoxConstraints.expand(),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    getLocationAndWeather();
                  },
                  child: Icon(
                    Icons.update,
                    size: 50.0,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${temperature.toString()}°C",
                    style: headerTextStyle,
                  ),
                  Flexible(
                    child: Image(
                      image: NetworkImage(
                          'https://openweathermap.org/img/wn/$icon@2x.png'),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                date,
                textAlign: TextAlign.center,
                style: bodyTextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                "It's $description in $city, $country!",
                textAlign: TextAlign.center,
                style: bodyTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
