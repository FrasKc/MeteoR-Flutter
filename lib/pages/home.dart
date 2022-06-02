import 'package:flutter/material.dart';
import 'package:meteor/components/generals_informatio.dart';

import '../models/meteo.dart';
import '../services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

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
      body: SafeArea(
        minimum: EdgeInsets.only(top: 70),
        child: FutureBuilder<Meteo>(
          future: getMeteoData("jonage"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("Chargement..."),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  General_information(null, snapshot.data!),
                  Card(
                    child: ListTile(
                      title: Text(snapshot.data!.name),
                      // subtitle: Text(snapshot.data!.weather[0].description),
                      trailing: Text((snapshot.data!.main.temp - 273.15)
                              .toStringAsFixed(1) +
                          "°C"),
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Erreur de chargement');
            }
          },
        ),
      ),
    );
  }
}
