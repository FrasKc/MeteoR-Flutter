import 'package:flutter/material.dart';
import 'package:meteor/models/meteo_forecast.dart';
import 'package:meteor/services/TimeStampeToString.dart';
import 'package:meteor/services/convert_temp_toString.dart';

class meteoCard extends StatefulWidget {
  meteoCard(Key? key, this.liste) : super(key: key);

  Liste liste;
  @override
  State<meteoCard> createState() => _meteoCardState();
}

class _meteoCardState extends State<meteoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Card(
          child: Column(
        children: [
          Text(readTimestampHour(widget.liste.dt)),
          Text(widget.liste.weather[0].description),
          Text("${convertTempToString(widget.liste.main.temp)}°"),
        ],
      )),
    );
  }
}
