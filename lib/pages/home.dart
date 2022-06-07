import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double detailSize = MediaQuery.of(context).size.height * 0.65;
    final double detailSizePerHours = detailSize * 0.15;
    final double detailSizePerDays = detailSize * 0.85;
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(widget.actualCity),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://www.tvqc.com/wp-content/uploads/2015/06/tumblr_nq98q9gU9w1smjc75o1_500.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.menu_open, color: Colors.white),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
              ),
              PreferenceBuilder<String>(
                preference: widget.actualCity.city,
                builder: (BuildContext context, String city) {
                  String city = widget.actualCity.city.getValue();
                  if (city == "") {
                    return Text("Aucune ville n'a été sélectionné");
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: FutureBuilder<Meteo>(
                            future: getMeteoData(city),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: Text("Chargement..."),
                                );
                              } else if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.data!.cod != 444) {
                                return General_information(
                                    null, snapshot.data!);
                              } else {
                                return const Text('Erreur de chargement');
                              }
                            },
                          ),
                        ),
                        FutureBuilder<Meteo_Forecast>(
                          future: getMeteoDetailsData(city),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Text("Chargement..."),
                              );
                            } else if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data!.cod != "444") {
                              return SizedBox(
                                height: detailSize,
                                child: ListView(
                                  children: [
                                    SizedBox(
                                      height: detailSizePerHours,
                                      child: Details_Information(
                                          null, snapshot.data!),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10.0, left: 10.0, top: 10),
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons.calendar_month,
                                                      color: Colors.white),
                                                  Text("5 day forecast",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white))
                                                ],
                                              ),
                                              SizedBox(
                                                height: detailSizePerDays,
                                                child: Days_Informations(
                                                    null, snapshot.data!),
                                              )
                                            ],
                                          )),
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
