import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meteor/models/meteo_forecast.dart';
import 'package:meteor/services/TimeStampeToString.dart';
import 'package:meteor/services/convert_temp_toString.dart';

class MeteoCard extends StatefulWidget {
  const MeteoCard(Key? key, this.liste) : super(key: key);

  final Liste liste;
  @override
  State<MeteoCard> createState() => _MeteoCardState();
}

class _MeteoCardState extends State<MeteoCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: Card(
          elevation: 1,
          color: const Color.fromARGB(102, 255, 253, 253),
          child: Column(
            children: [
              Text(readTimestampHour(widget.liste.dt),
                  style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 255, 255, 255))),
              Image.network(
                "http://openweathermap.org/img/wn/${widget.liste.weather[0].icon}@2x.png",
                width: 35,
                height: 35,
              ),
              Text("${convertTempToString(widget.liste.main.temp)}°",
                  style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 255, 255, 255))),
            ],
          )),
    );
  }
}
