import 'package:flutter/material.dart';
import 'package:meteor/components/generals_informatio.dart';
import 'package:meteor/components/navDrawer.dart';
import 'package:meteor/models/meteo_forecast.dart';
import 'package:meteor/services/details_services.dart';
import 'package:meteor/services/ActualCity.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import '../components/andré.dart';
import '../components/details_information.dart';
import '../models/meteo.dart';
import '../services/api_services.dart';

class HomePage extends StatefulWidget {
  HomePage(this.actualCity);
  final ActualCity actualCity;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(widget.actualCity),
      body: SafeArea(
        minimum: EdgeInsets.only(top: 70),
        child: PreferenceBuilder<String>(
          preference: widget.actualCity.city,
          builder: (BuildContext context, String city) {
            String city = widget.actualCity.city.getValue();
            if (city == "") {
              return Text("Aucune ville n'a été sélectionné");
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FutureBuilder<Meteo>(
                    future: getMeteoData(city),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Text("Chargement..."),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return General_information(null, snapshot.data!);
                      } else {
                        return const Text('Erreur de chargement');
                      }
                    },
                  ),
                  FutureBuilder<Meteo_Forecast>(
                    future: getMeteoDetailsData(city),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Text("Chargement..."),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView(
                            children: [
                              Details_Information(null, snapshot.data!),
                              Days_Informations(null, snapshot.data!),
                            ],
                          ),
                        );
                      } else {
                        return const Text('Erreur de chargement');
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
