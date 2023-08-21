import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utilities/my_global_state.dart';
import 'package:weather_app/utilities/subscriber.dart';

class ForecastScreen extends StatefulWidget {
  ForecastScreen(this.myGlobalState, {super.key});
  MyGlobalState myGlobalState;

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> implements Subscriber {
  List<dynamic>? data;
  String city = 'NULL';
  String country = 'NULL';

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void update() {
    updateUI();
  }

  void updateUI() {
    setState(() {
      final jsonData = jsonDecode(widget.myGlobalState.forecastData);
      data = jsonData['list'] as List<dynamic>?;
      city = jsonData['city']['name'];
      country = jsonData['city']['country'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data?.length ?? 0,
      itemBuilder: (context, index) {
        final item = data![index];
        DateTime parsedDate = DateTime.parse(item['dt_txt']);
        String formattedDate =
            DateFormat('EEE, MMM d, y - kk:mm').format(parsedDate);
        return ListTile(
          leading: Image(
            image: NetworkImage(
                'https://openweathermap.org/img/wn/${item['weather'][0]['icon']}@2x.png'),
          ),
          title: Text('$formattedDate - ${item['main']['temp']}°C'),
          subtitle:
              Text('$city, $country, ${item['weather'][0]['description']}'),
          // Add more fields as needed
        );
      },
    );
    ;
  }
}
