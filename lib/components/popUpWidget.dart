import 'package:flutter/material.dart';

import '../database/database_helper.dart';

class PopUpCustom extends StatelessWidget {
  PopUpCustom(this.context, {Key? key}) : super(key: key);
  final BuildContext context;
  TextEditingController _myController = TextEditingController();
  void dispose() {
    _myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Popup example'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Entrer une nouvelle ville"),
          TextField(
            controller: _myController,
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () async {
            print("ok");

            await SQLHelper.createItem(_myController.text)
                .then((value) => Navigator.of(context).pop("okay"));
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
