import 'package:flutter/material.dart';
import 'package:meteor/components/meteo_card.dart';
import 'package:meteor/models/meteo_forecast.dart';

class DetailsInformation extends StatefulWidget {
  const DetailsInformation(Key? key, this.meteoDetail)
      : super(
          key: key,
        );
  final MeteoForecast meteoDetail;

  @override
  State<DetailsInformation> createState() => _DetailsInformationState();
}

class _DetailsInformationState extends State<DetailsInformation> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: MeteoCard(null, widget.meteoDetail, index));
      },
    );
  }
}
