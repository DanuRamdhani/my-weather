import 'package:flutter/material.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    super.key,
    required this.country,
    required this.areaName,
    required this.celcius,
    required this.tempMax,
    required this.tempMin,
    required this.desc,
    required this.iconWeather,
  });

  final String country;
  final String areaName;
  final String celcius;
  final String tempMax;
  final String tempMin;
  final String desc;
  final String iconWeather;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$areaName, $country',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
              ),
        ),
        Text(
          '$celcius℃',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.w300,
              ),
        ),
        Text(
          '▲ $tempMax  ▼ $tempMin',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        Text(
          desc.toUpperCase(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w300,
                letterSpacing: 5,
              ),
        ),
      ],
    );
  }
}
