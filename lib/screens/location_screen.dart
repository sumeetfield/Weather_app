import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherdata});
  final weatherdata;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temp;
  String city;
  var weathericn;
  String weathermsg;

  @override
  void initState() {
    super.initState();
    updateui(widget.weatherdata);
  }

  void updateui(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        print(weatherdata);
        temp = 0;
        city = 'unknown';
        weathericn = '';
        weathermsg = 'Unable to get weather data';
        return;
      }
      var tempt = weatherdata['main']['temp'];
      temp = tempt.toInt();
      var cond = weatherdata['weather'][0]['id'];
      city = weatherdata['name'];
      weathericn = weather.getWeatherIcon(cond);
      weathermsg = weather.getMessage(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var weatherdata = await weather.getdata();
                        updateui(weatherdata);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var typename = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ),
                        );

                        if (typename != null) {
                          print(typename);
                          var weatherdata =
                              await weather.getdataBycity(typename);
                          print(weatherdata);
                          updateui(weatherdata);
                        } else {
                          print('Enter City Name');
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temp°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        '$weathericn️',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weathermsg \n in $city',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
