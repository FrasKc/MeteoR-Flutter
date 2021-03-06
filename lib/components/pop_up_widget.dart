import 'package:flutter/material.dart';

import '../database/database_helper.dart';

class PopUpCustom extends StatelessWidget {
  PopUpCustom(this.context, {Key? key}) : super(key: key);
  final BuildContext context;
  final TextEditingController _myController = TextEditingController();
  void dispose() {
    _myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choisissez votre ville'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _myController,
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () async {
            if (_myController.text != "" && _myController.text != " ") {
              await SQLHelper.createItem(_myController.text)
                  .then((value) => Navigator.of(context).pop("okay"));
            } else {
              Navigator.of(context).pop("PasOkay");
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
