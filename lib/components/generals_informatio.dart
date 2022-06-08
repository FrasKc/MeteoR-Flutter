import 'package:flutter/material.dart';
import 'package:meteor/models/meteo.dart';
import 'package:meteor/services/convert_temp_toString.dart';
import 'package:google_fonts/google_fonts.dart';

class General_information extends StatefulWidget {
  General_information(Key? key, this.meteo) : super(key: key);
  final Meteo meteo;
  @override
  State<General_information> createState() => _General_informationState();
}

class _General_informationState extends State<General_information> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.meteo.name,
            style: GoogleFonts.lato(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        const SizedBox(height: 10),
        Text("${convertTempToString(widget.meteo.main.temp)}°",
            style: GoogleFonts.lato(
                fontSize: 50,
                fontWeight: FontWeight.w400,
                color: Colors.white)),
        const SizedBox(height: 10),
        Text(widget.meteo.weather[0].description,
            style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.air_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Text("${(widget.meteo.wind.speed * 3.6).toString()}Km/h",
                style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ],
        ),
        const SizedBox(height: 15),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Min. ${convertTempToString(widget.meteo.main.tempMin)}°",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          const SizedBox(width: 20),
          Text("Max. ${convertTempToString(widget.meteo.main.tempMax)}°",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white))
        ])
      ],
    );
  }
}
