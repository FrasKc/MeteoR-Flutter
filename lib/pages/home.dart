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
    final double detailSize = MediaQuery.of(context).size.height * 0.76;
    final double detailSizePerHours = detailSize * 0.12;
    final double detailSizePerDays = detailSize * 0.85;
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(widget.actualCity),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fond.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          minimum: EdgeInsets.only(top: 25),
          top: false,
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    return const Text("Aucune ville n'a été sélectionné");
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FutureBuilder<Meteo>(
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
                              return General_information(null, snapshot.data!);
                            } else {
                              return const Text('Erreur de chargement');
                            }
                          },
                        ),
                        const SizedBox(height: 10),
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
                                height: detailSizePerDays,
                                child: ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              108, 255, 255, 255),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                                child: Row(
                                              children: [
                                                const Icon(
                                                    Icons.watch_later_outlined,
                                                    color: Colors.white),
                                                Text(" Hour by hour forecast",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)))
                                              ],
                                            )),
                                            Container(
                                              height: detailSizePerHours,
                                              child: Details_Information(
                                                  null, snapshot.data!),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10.0, left: 10.0, top: 10),
                                      child: Container(
                                          height: detailSizePerDays * 0.6,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                108, 255, 255, 255),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          padding: const EdgeInsets.only(
                                              top: 10.0, right: 10, left: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons.calendar_month,
                                                      color: Colors.white),
                                                  Text(" 5 day forecast",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)))
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    detailSizePerDays * 0.50,
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
