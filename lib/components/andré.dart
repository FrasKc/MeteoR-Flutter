import 'package:flutter/material.dart';
import 'package:meteor/components/meteo_card.dart';
import 'package:meteor/models/meteo_forecast.dart';
import 'package:meteor/services/DaysFilter.dart';
import 'package:meteor/services/TimeStampeToString.dart';

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
    return Center(
      child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(child: Text(readTimestampDay(data[index].dt)));
            },
          )),
    );
  }
}
