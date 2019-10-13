import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    getlocationdata();
  }

  void getlocationdata() async {
    // marked any function with future datatype as await
    var weatherdata = await weather.getdata();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LocationScreen(
                weatherdata: weatherdata,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: kspin),
    );
  }
}
