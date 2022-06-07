import 'package:flutter/material.dart';
import 'package:meteor/components/meteo_card.dart';
import 'package:meteor/models/meteo_forecast.dart';
import 'package:meteor/services/DaysFilter.dart';
import 'package:meteor/services/TimeStampeToString.dart';
import 'package:meteor/services/convert_temp_toString.dart';

class Days_Informations extends StatefulWidget {
  Days_Informations(Key? key, this.meteoDetail)
      : super(
          key: key,
        );
  final Meteo_Forecast meteoDetail;

  @override
  State<Days_Informations> createState() => _Days_InformationsState();
}

class _Days_InformationsState extends State<Days_Informations> {
  late List<Liste> data = daysFilter(widget.meteoDetail.list!);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(readTimestampDay(data[index].dt)),
                Image.network(
                  "http://openweathermap.org/img/wn/${data[index].weather[0].icon}@2x.png",
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          "${convertTempToString(data[index].main.feelsLike)}°"),
                      Text("${data[index].main.humidity.toString()}%"),
                    ],
                  ),
                )
              ],
            ),
            Text(data[index].weather[0].description),
          ],
        ));
      },
    );
  }
}
