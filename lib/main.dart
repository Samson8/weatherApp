import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'model/WeatherData.dart';
import 'model/ForCastData.dart';
import 'model/Weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;

  loadWeather() async {
    setState(() {
      isLoading = true;
    });
    Position position;
    try {
      position =
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    } catch (e) {
      print(e);
    }

    if (position != null) {
      final lat = position.latitude;
      final lon = position.longitude;

      final weatherResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?APPID=0721392c0ba0af8c410aa9394defa29e&lat=${lat.toString()}&lon=${lon.toString()}');
      final forecastResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/forecast?APPID=0721392c0ba0af8c410aa9394defa29e&lat=${lat.toString()}&lon=${lon.toString()}');

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          weatherData =
          new WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData =
          new ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }


  @override
  void initState() {
    super.initState();
    loadWeather();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Weather Where you are',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Icon(Icons.cloud_circle_sharp, size: 130,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: weatherData != null
                  ? Weather(weather: weatherData, forecastData: forecastData,)
                  : Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isLoading
                  ? CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor:
                new AlwaysStoppedAnimation(Colors.yellowAccent),
              )
                  : IconButton(
                icon: new Icon(Icons.refresh),
                tooltip: 'Refresh',
                onPressed: loadWeather,
                color: Colors.yellowAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
