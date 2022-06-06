import 'package:flutter/material.dart';
import 'package:meteor/components/popUpWidget.dart';
import 'package:meteor/services/ActualCity.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer(this.actualCity);
  final ActualCity actualCity;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Météor',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/orage.jpg'))),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => PopUpCustom(context),
              );
            },
            child: Text("Ajouter une ville"),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("ok"),
                  trailing: Icon(
                    Icons.location_city,
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 30.0,
                  ),
                  onTap: () async {
                    await actualCity.city
                        .setValue("jonage")
                        .then((value) => Navigator.pop(context));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
