import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return SizedBox(
      width: 100,
      child: Card(
          elevation: 1,
          color: Color.fromARGB(102, 255, 253, 253),
          child: Column(
            children: [
              Text(readTimestampHour(widget.liste.dt),
                  style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 255, 255, 255))),
              Image.network(
                "http://openweathermap.org/img/wn/${widget.liste.weather[0].icon}@2x.png",
                width: 30,
                height: 30,
              ),
              Text("${convertTempToString(widget.liste.main.temp)}°",
                  style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 255, 255, 255))),
            ],
          )),
    );
  }
}
