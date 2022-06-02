import 'package:flutter/material.dart';

import '../models/meteo.dart';
import '../services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder<Meteo>(
          future: getMeteoData("marseille"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("Sa charge !! attend wesh !!"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Card(
                child: ListTile(
                  title: Text(snapshot.data!.name),
                  // subtitle: Text(snapshot.data!.weather[0].description),
                  trailing:
                      Text((snapshot.data!.main.temp - 273.15).toString()),
                ),
              );
            } else {
              return const Text('Olalala y a une erreure');
            }
          },
        ),
      ],
    )));
  }
}
