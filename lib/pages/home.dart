import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:meteor/components/generals_informatio.dart';
import 'package:meteor/services/SelectFond.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'package:meteor/components/charge_widget.dart';
import 'package:meteor/components/day_card.dart';
import 'package:meteor/components/erreur_widget.dart';
import 'package:meteor/components/nav_drawer.dart';
import 'package:meteor/models/meteo_forecast.dart';
import 'package:meteor/services/ActualCity.dart';
import 'package:meteor/services/details_services.dart';

import '../components/details_information.dart';
import '../models/meteo.dart';
import '../services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage(
    Key? key,
    this.actualCity,
  ) : super(key: key);
  final ActualCity actualCity;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Color _boxColor =
      const Color.fromARGB(216, 100, 153, 252).withOpacity(0.1);
  late String _imageUrl = "assets/images/fondSoleil.gif";

  @override
  void initState() {
    super.initState();
    receiveMeteo();
  }

  void receiveMeteo() async {
    String city = widget.actualCity.city.getValue();
    var result = await getMeteoData(city).then((value) => SelectFond(value));
    setState(() {
      _imageUrl = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double detailSize = MediaQuery.of(context).size.height * 0.76;
    final double detailSizePerHours = detailSize * 0.13;
    final double detailSizePerDays = detailSize * 0.85;

    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(widget.actualCity),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_imageUrl),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 25),
          top: false,
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                                child: ChargeWidget(),
                              );
                            } else if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data!.cod != 444) {
                              return GeneralInformation(null, snapshot.data!);
                            } else {
                              return const ErreurWidget();
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        FutureBuilder<MeteoForecast>(
                          future: getMeteoDetailsData(city),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: ChargeWidget(),
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
                                          top: 5,
                                          right: 10,
                                          left: 10,
                                          bottom: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _boxColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons.watch_later_outlined,
                                                    color: Colors.white),
                                                Text(" Hour by hour forecast",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color
                                                                .fromARGB(255,
                                                            255, 255, 255)))
                                              ],
                                            ),
                                            SizedBox(
                                              height: detailSizePerHours,
                                              child: DetailsInformation(
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
                                          decoration: BoxDecoration(
                                            color: _boxColor,
                                            borderRadius:
                                                const BorderRadius.all(
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
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 255, 255, 255),
                                                      ))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                height:
                                                    detailSizePerDays * 0.50,
                                                child: DaysInformations(
                                                    null, snapshot.data!),
                                              )
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const ErreurWidget();
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
