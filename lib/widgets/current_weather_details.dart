import 'package:flutter/material.dart';

class CurrentWeatherDetails extends StatelessWidget {
  const CurrentWeatherDetails(
      {super.key,
      required this.tempFl,
      required this.humidity,
      required this.pressure});

  final String tempFl;
  final int humidity;
  final int pressure;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                '$tempFl ℃',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              const Text('Fells like'),
            ],
          ),
          const VerticalDivider(),
          Column(
            children: [
              Text(
                '$humidity %',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              const Text('Humidity'),
            ],
          ),
          const VerticalDivider(),
          Column(
            children: [
              Text(
                '$pressure hpa',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              const Text('Pressure'),
            ],
          ),
        ],
      ),
    );
  }
}
