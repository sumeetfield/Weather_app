import 'package:geolocator/geolocator.dart';
import 'package:clima/services/networking.dart';

final String url = 'http://api.openweathermap.org/data/2.5/weather';
const String apikey = '52fe291cb1fb3b1e69dbea3b8c13cba4';

class WeatherModel {
  Future<dynamic> getdataBycity(String cityname) async {
    NetworkHelper networkHelper =
        NetworkHelper('$url?q=$cityname&appid=$apikey&units=metric');

    var weatherdata = await networkHelper.getdata();

    return weatherdata;
  }

  Future<dynamic> getdata() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    NetworkHelper networkHelper = NetworkHelper(
        '$url?lat=${position.latitude}&lon=${position.longitude}&appid=$apikey&units=metric');

    var weatherdata = await networkHelper.getdata();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
