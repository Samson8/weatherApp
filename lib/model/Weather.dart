import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/WeatherData.dart';
import 'package:weather_app/model/ForCastData.dart';
import 'package:weather_app/widget/weatherItem.dart';

class Weather extends StatelessWidget {
  final WeatherData weather;
  final ForecastData forecastData;

  Weather({Key key, @required this.weather, @required this.forecastData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deg = (weather.temp - 32) * (5/9);
    return Container(
      height: 450,
      width:320,
      padding: EdgeInsets.all(8),
      color: Colors.amber,
      child: Column(
        children: [
          Expanded(child: Text(weather.state, style: TextStyle(fontSize: 24, color: Colors.white),)),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Expanded(
                  flex:6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.network('https://openweathermap.org/img/w/${weather.icon}.png', width: 130, fit: BoxFit.cover,),
                          Text('${deg.toInt().toString()}°', style: TextStyle(color: Colors.white,
                            letterSpacing: 0.6000000000000001,
                            fontWeight: FontWeight.w400,
                            fontSize: 50,
                            shadows: [
                              Shadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              )
                            ],)),
                          Wrap(
                            children: [
                              Text(weather.description, style: TextStyle(color: Colors.white,
                                letterSpacing: 0.6000000000000001,
                                fontWeight: FontWeight.w400,
                                fontSize: 30,
                                shadows: [
                                  Shadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  )
                                ],)),
                            ],
                          ),
                          Row(children: [
                            text(new DateFormat.Hm().format(weather.date)+'\t\t'),
                            Icon(Icons.wb_sunny_outlined, color: Colors.white,),
                            text('\t\t ${new DateFormat.Hm().formatDuration(weather.date)} WAT'),
                          ],),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        text('feels like:'),
                        text('${weather.temp.toString()}°f'),
                        text('Wind:'),
                        text('${weather.wind}mph ese'),
                        text('humidity:'),
                        text('${weather.humidity}%'),
                        text('pressure:'),
                        text('${weather.pressure.toString()}\"hg'),
                        text('uv index:'),
                        text('nil')
                      ],)
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                  child: forecastData != null
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        ...forecastData.list.sublist(0,3).map((e) => WeatherItem(weather: e,))
                  ],)
                      : Container(),
                ),)
              ],
            ),
          ),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text('Weather broadcast ${weather.state}, ${weather.country}'),
              Icon(Icons.arrow_right, color: Colors.white, )
            ],
          ))
        ],
      ),
    );
  }

  text(String txt){
    return Text(txt, style: TextStyle(fontSize: 14,
      color: Colors.white,
      letterSpacing: 0.6000000000000001,
      fontWeight: FontWeight.w400,
      shadows: [
        Shadow(
          color: const Color(0x29000000),
          offset: Offset(0, 3),
          blurRadius: 6,
        )
      ],) ,);
  }
}