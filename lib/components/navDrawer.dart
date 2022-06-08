import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:meteor/components/popUpWidget.dart';
import 'package:meteor/database/database_helper.dart';
import 'package:meteor/services/ActualCity.dart';

import '../models/city.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer(
    Key? key,
    this.actualCity,
  ) : super(key: key);
  final ActualCity actualCity;

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  late List<City> citysList = [];
  void _refreshCitys() async {
    final data = await SQLHelper.getItems();
    setState(() {
      citysList = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshCitys(); // Loading the diary when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(206, 255, 255, 255),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'MétéoR',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/orage.jpg'))),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (BuildContext context) => PopUpCustom(context),
                  );
                  if (result != "") {
                    setState(() {
                      _refreshCitys();
                    });
                  }
                },
                child: const Text("Ajouter une ville")),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: citysList.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(citysList[index].cityName),
                  background: Container(
                    color: const Color.fromARGB(120, 252, 43, 28),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.delete, color: Colors.white),
                          Text('Move to trash',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: const Color.fromARGB(120, 252, 43, 28),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(Icons.delete, color: Colors.white),
                          Text('Move to trash',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  onDismissed: (direction) async {
                    if (direction == DismissDirection.endToStart ||
                        direction == DismissDirection.startToEnd) {
                      await SQLHelper.deleteItem(citysList[index].id);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Successfully deleted city'),
                      ));
                      _refreshCitys();
                    } else {
                      _refreshCitys();
                      return;
                    }
                  },
                  child: ListTile(
                    title: Text(citysList[index].cityName.toUpperCase(),
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 12, 12, 12))),
                    trailing: const Icon(
                      Icons.location_city,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 30.0,
                    ),
                    onTap: () async {
                      await widget.actualCity.city
                          .setValue(citysList[index].cityName)
                          .then((value) => Navigator.pop(context));
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
