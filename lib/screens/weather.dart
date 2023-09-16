import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:my_weather/screens/weather_places.dart';
import 'package:my_weather/widgets/current_weather.dart';
import 'package:my_weather/widgets/current_weather_details.dart';
import 'package:my_weather/widgets/forecast_weather.dart';
import 'package:weather/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double lat = 0;
  double lon = 0;
  WeatherFactory wf = WeatherFactory('5c2f445aaf8e3d281a9abbd30a7454b7');

  String? _celcius;
  String? _tempFl;
  String? _tempMin;
  String? _tempMax;
  String? _country;
  String? _areaName;
  String? _desc;
  DateTime _date = DateTime.now();
  String? _hour;
  String? _minute;
  String _dayName = '-';
  String _iconWeather = '01d';
  String _iconWeatherForecast = '01d';
  int _humidity = 0;
  int _pressure = 0;

  bool _onProgres = false;

  List<Weather> _forecast = [];

  Future<void> _getCurrentLocation() async {
    setState(() {
      _onProgres = true;
    });

    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Geolocator.openLocationSettings();
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      lat = position.latitude;
      lon = position.longitude;
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      setState(() {
        _onProgres = false;
      });
    }
    _getWeather();
    _getWeatherFiveDays();
  }

  Future<void> _getWeather() async {
    Weather w = await wf.currentWeatherByLocation(lat, lon);

    final getCelsius = w.temperature!.celsius;
    final getTempFl = w.tempFeelsLike?.celsius;
    final getMinTemp = w.tempMin?.celsius;
    final getMaxTemp = w.tempMax!.celsius;
    final getHour = w.date!.hour;
    final getMinute = w.date!.minute;

    final intCelsius = getCelsius!.toStringAsFixed(0);
    final intCelsiusMax = getMaxTemp!.toStringAsFixed(0);
    final intCelsiusMin = getMinTemp!.toStringAsFixed(0);
    final intTempFl = getTempFl!.toStringAsFixed(0);

    final setHourTwoDigit = getHour.toString().padLeft(2, '0');
    final setMinTwoDigit = getMinute.toString().padLeft(2, '0');

    _iconWeather = w.weatherIcon!;
    _celcius = intCelsius;
    _tempFl = intTempFl;
    _areaName = w.areaName;
    _country = w.country;
    _date = w.date!;
    _hour = setHourTwoDigit;
    _minute = setMinTwoDigit;
    _desc = w.weatherDescription;
    _tempMax = intCelsiusMax;
    _tempMin = intCelsiusMin;
    _humidity = w.humidity!.round();
    _pressure = w.pressure!.round();
  }

  void _getWeatherIcon() {
    String iconCode = _iconWeather;

    switch (iconCode) {
      case '01d':
        _iconWeather = '01d';
        break;
      case '01n':
        _iconWeather = '01n';
        break;
      case '02d':
        _iconWeather = '02d';
        break;
      case '02n':
        _iconWeather = '02n';
        break;
      case '03d' || '03n':
        _iconWeather = '03d';
        break;
      case '04d' || '04n':
        _iconWeather = '04d';
        break;
      case '09d' || '09n':
        _iconWeather = '09d';
        break;
      case '10d':
        _iconWeather = '10d';
        break;
      case '10n':
        _iconWeather = '10n';
        break;
      case '11d' || '11n':
        _iconWeather = '11d';
        break;
      case '13d' || '13n':
        _iconWeather = '13d';
        break;
      case '50d' || '50n':
        _iconWeather = '50d';
        break;
      default:
    }
  }

  Future<void> _getWeatherFiveDays() async {
    List<Weather> forecast = await wf.fiveDayForecastByLocation(lat, lon);

    _forecast = forecast;
    setState(() {
      _onProgres = false;
    });
  }

  void _getWeekForecast(int index) {
    final days = _forecast[index].date!;

    switch (days.weekday) {
      case 1:
        _dayName = 'Sunday';
        break;
      case 2:
        _dayName = 'Monday';
        break;
      case 3:
        _dayName = 'Thursday';
        break;
      case 4:
        _dayName = 'Wednesday';
        break;
      case 5:
        _dayName = 'Tuesday';
        break;
      case 6:
        _dayName = 'Friday';
        break;
      case 7:
        _dayName = 'Saturday';
        break;
      default:
    }
  }

  void _getWeatherIconForecast(int index) {
    String iconCode = _forecast[index].weatherIcon!;

    switch (iconCode) {
      case '01d':
        _iconWeatherForecast = '01d';
        break;
      case '01n':
        _iconWeatherForecast = '01n';
        break;
      case '02d':
        _iconWeatherForecast = '02d';
        break;
      case '02n':
        _iconWeatherForecast = '02n';
        break;
      case '03d' || '03n':
        _iconWeatherForecast = '03d';
        break;
      case '04d' || '04n':
        _iconWeatherForecast = '04d';
        break;
      case '09d' || '09n':
        _iconWeatherForecast = '09d';
        break;
      case '10d':
        _iconWeatherForecast = '10d';
        break;
      case '10n':
        _iconWeatherForecast = '10n';
        break;
      case '11d' || '11n':
        _iconWeatherForecast = '11d';
        break;
      case '13d' || '13n':
        _iconWeatherForecast = '13d';
        break;
      case '50d' || '50n':
        _iconWeatherForecast = '50d';
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    _getWeatherIcon();

    return _onProgres
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                strokeWidth: 8,
                strokeAlign: BorderSide.strokeAlignOutside,
                strokeCap: StrokeCap.round,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              titleTextStyle: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                  'Updated ${DateFormat.MMMEd().format(_date).toString()}  $_hour : $_minute'),
              actions: [
                IconButton(
                  onPressed: () {
                    Phoenix.rebirth(context);
                  },
                  icon: const Icon(Icons.replay_outlined),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const WeatherPlaces(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert_rounded),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurrentWeather(
                    country: _country.toString(),
                    areaName: _areaName.toString(),
                    celcius: _celcius.toString(),
                    tempMax: _tempMax.toString(),
                    tempMin: _tempMin.toString(),
                    desc: _desc.toString(),
                    iconWeather: _iconWeather,
                  ),
                  const SizedBox(height: 24),
                  CurrentWeatherDetails(
                    tempFl: _tempFl.toString(),
                    humidity: _humidity,
                    pressure: _pressure,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _forecast.length,
                      itemBuilder: (context, index) {
                        final intCel = _forecast[index]
                            .temperature!
                            .celsius!
                            .toStringAsFixed(0);

                        _getWeekForecast(index);
                        _getWeatherIconForecast(index);

                        final getHour = _forecast[index].date!.hour;
                        final getMin = _forecast[index].date!.minute;
                        final getDate = DateFormat.Md()
                            .format(_forecast[index].date!)
                            .toString();

                        final hour = getHour.toString().padLeft(2, '0');
                        final minute = getMin.toString().padLeft(2, '0');

                        return ForecastWeather(
                          getDate: getDate,
                          hour: hour,
                          minute: minute,
                          dayName: _dayName,
                          iconWeather: _iconWeatherForecast,
                          intCel: intCel,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
