import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/about_screen.dart';
import 'package:weather_app/screens/forecast_screen.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/utilities/bottom_navigation_bar.dart';
import 'package:weather_app/utilities/my_global_state.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationAndWeather();
  }

  void getLocationAndWeather() async {
    MyGlobalState myGlobalState = MyGlobalState();
    await myGlobalState.getLocationAndWeather();

    final List<Widget> pages = [
      WeatherScreen(myGlobalState),
      ForecastScreen(myGlobalState),
      AboutScreen(),
    ];

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return BottomNavigationBarWeather(pages);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitSpinningLines(
        color: Colors.green,
      ),
    );
  }
}
