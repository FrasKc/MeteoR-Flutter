import 'package:flutter/material.dart';
import 'package:meteor/components/meteo_card.dart';
import 'package:meteor/models/meteo_forecast.dart';

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
  @override
  Widget build(BuildContext context) {
    print(widget.meteoDetail);
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Builder(
              builder: (BuildContext context) {
                return Center(
                  child: TextButton(
                    onPressed: () {
                      print(Scaffold.of(context).hasAppBar);
                    },
                    child: Text('hasAppBar'),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
