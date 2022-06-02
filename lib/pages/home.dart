import 'package:flutter/material.dart';
import 'package:meteor/components/generals_informatio.dart';
import 'package:meteor/components/navDrawer.dart';
import 'package:meteor/models/meteo_forecast.dart';
import 'package:meteor/services/details_services.dart';

import '../components/details_information.dart';
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
      drawer: NavDrawer(),
      body: SafeArea(
        minimum: EdgeInsets.only(top: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<Meteo>(
              future: getMeteoData("jonage"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text("Chargement..."),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return General_information(null, snapshot.data!);
                } else {
                  return const Text('Erreur de chargement');
                }
              },
            ),
            FutureBuilder<Meteo_Forecast>(
              future: getMeteoDetailsData("jonage"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text("Chargement..."),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView(
                      children: [
                        Details_Information(null, snapshot.data!),
                      ],
                    ),
                  );
                } else {
                  return const Text('Erreur de chargement');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
