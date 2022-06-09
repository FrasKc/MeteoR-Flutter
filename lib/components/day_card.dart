import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meteor/models/meteo_forecast.dart';
import 'package:meteor/services/days_filter.dart';
import 'package:meteor/services/time_stampe_to_string.dart';
import 'package:meteor/services/convert_temp_to_string.dart';

class DaysInformations extends StatefulWidget {
  const DaysInformations(Key? key, this.meteoDetail)
      : super(
          key: key,
        );
  final MeteoForecast meteoDetail;

  @override
  State<DaysInformations> createState() => _DaysInformationsState();
}

class _DaysInformationsState extends State<DaysInformations> {
  late List<Liste> data = daysFilter(widget.meteoDetail.list!);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 1,
          color: const Color.fromARGB(102, 255, 253, 253).withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      readTimestampDay(data[index].dt),
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                      child: Row(children: [
                        Image.network(
                          "http://openweathermap.org/img/wn/${data[index].weather[0].icon}@2x.png",
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          "${convertTempToString(data[index].main.feelsLike)}°",
                          style: GoogleFonts.lato(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ]),
                    ),
                    Row(
                      children: [
                        Text("${data[index].main.humidity.toString()}%",
                            style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color.fromARGB(255, 255, 255, 255))),
                        const SizedBox(width: 10),
                        Image.network(
                            "https://cdn-icons-png.flaticon.com/512/850/850785.png",
                            width: 20,
                            height: 20)
                      ],
                    )
                  ],
                ),
                Text(
                  data[index].weather[0].description.toUpperCase(),
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
