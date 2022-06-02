import 'package:flutter/material.dart';
import 'package:meteor/components/meteo_card.dart';
import 'package:meteor/models/meteo_forecast.dart';

class Details_Information extends StatefulWidget {
  Details_Information(Key? key, this.meteoDetail)
      : super(
          key: key,
        );
  final Meteo_Forecast meteoDetail;

  @override
  State<Details_Information> createState() => _Details_InformationState();
}

class _Details_InformationState extends State<Details_Information> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.meteoDetail.list!.length,
            itemBuilder: (BuildContext context, int index) {
              return meteoCard(null, widget.meteoDetail.list![index]);
            },
          ),
        )
      ],
    ));
  }
}
