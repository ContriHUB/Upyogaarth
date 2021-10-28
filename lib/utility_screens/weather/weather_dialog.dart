import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherDialog {
  final DateFormat date = DateFormat('dd LLL');
  final DateFormat time = DateFormat('HH:mm');

  Widget _showParameter(String heading, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          heading,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Image getWeatherImage(int condition) {
    if (condition < 300)
      return Image(
        image: AssetImage('assets/weather/storm.png'),
      );
    else if (condition < 400)
      return Image(
        image: AssetImage('assets/weather/drizzle.png'),
      );
    else if (condition < 600)
      return Image(
        image: AssetImage('assets/weather/rain.png'),
      );
    else if (condition < 700)
      return Image(
        image: AssetImage('assets/weather/snow.png'),
      );
    else if (condition < 800)
      return Image(
        image: AssetImage('assets/weather/tornado.png'),
      );
    else if (condition == 800)
      return Image(
        image: AssetImage('assets/weather/sun.png'),
      );
    else if (condition <= 804)
      return Image(
        image: AssetImage('assets/weather/cloudy.png'),
      );
    else
      return Image(
        image: AssetImage('assets/weather/sun.png'),
      );
  }

  Future<dynamic> showDetails(Weather w, BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 15.0,
            title: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date.format(w.date!),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black87),
                    ),
                    Text(
                      time.format(w.date!),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black87),
                    ),
                  ],
                ),
                Divider(height: 8),
                getWeatherImage(w.weatherConditionCode!),
              ],
            ),
            content: Column(
              children: [
                _showParameter('Temperature(min): ',
                    w.tempMin!.celsius!.roundToDouble().toString() + '°C'),
                _showParameter('Temperature(max): ',
                    w.tempMax!.celsius!.roundToDouble().toString() + '°C'),
                _showParameter(
                    'Temperature(feels like): ',
                    w.tempFeelsLike!.celsius!.roundToDouble().toString() +
                        '°C'),
                _showParameter('Description: ', w.weatherDescription!),
                _showParameter('Windspeed: ', w.windSpeed!.toString()),
                _showParameter('Cloudiness: ', w.cloudiness!.toString()),
                _showParameter('Humidity: ', w.humidity!.toString()),
                _showParameter('Pressure: ', w.pressure!.toString()),
              ],
            ),
          );
        });
  }
}
