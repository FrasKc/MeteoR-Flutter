import 'package:flutter/material.dart';

import '../models/meteo.dart';
import '../services/api_services.dart';

class Details_Information extends StatefulWidget {
  Details_Information(Key? key, this.meteo) : super(key: key,);
  final Meteo meteo;

  @override
  State<Details_Information> createState() => _Details_InformationState();
}

class _Details_InformationState extends State<Details_Information> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("ok")],
    ));
  }
}
