import 'package:flutter/material.dart';

class ForecastWeather extends StatelessWidget {
  const ForecastWeather({
    super.key,
    required this.getDate,
    required this.hour,
    required this.minute,
    required this.dayName,
    required this.iconWeather,
    required this.intCel,
  });

  final String getDate;
  final String hour;
  final String minute;
  final String dayName;
  final String iconWeather;
  final String intCel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                getDate,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Expanded(
              child: Text('$hour:$minute'),
            ),
            Expanded(
              flex: 2,
              child: Text(dayName),
            ),
            Expanded(
              child: Image.asset('assets/images/$iconWeather.png', height: 80),
            ),
            Expanded(
              child: Text(
                '$intCel ℃',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
