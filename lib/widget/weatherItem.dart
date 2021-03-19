import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/WeatherData.dart';

class WeatherItem extends StatelessWidget {
  final WeatherData weather;

  WeatherItem({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deg = (weather.temp - 32) * (5/9);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${deg.toInt()}/${weather.temp.toString()}°F'),
            Image.network(
                'https://openweathermap.org/img/w/${weather.icon}.png'),
          ],
        ),
      ),
    );
  }
}