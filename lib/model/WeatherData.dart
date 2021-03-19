import 'dart:ffi';

class WeatherData {
  final DateTime date;
  final String name;
  final double temp;
  final String description;
  final String icon;
  final String feel;
  final String wind;
  final String country;
  final String state;
  final String humidity;
  final double pressure;

  WeatherData({this.date, this.name, this.temp, this.description, this.icon, this.feel, this.wind, this.country, this.state, this.humidity, this.pressure});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000,
          isUtc: false),
      name: json['name'],
      temp: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      feel: json['main']['feels_like'].toString(),
      wind: json['wind']['speed'].toString(),
      country: json['sys']['country'],
      state: json['name'],
      humidity: json['main']['humidity'].toString(),
      pressure: json['main']['pressure'].toDouble(),
    );
  }
}