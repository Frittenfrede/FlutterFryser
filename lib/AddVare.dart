import 'package:flutter/material.dart';
import 'models/freezer.dart';

class AddVare extends StatelessWidget {
  String description = "";
  String category = "";
  DateTime dt;

  AddVare({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Oplysninger omkring valgte vare')),
        body: Column(children: <Widget>[
          TextFormField(
              initialValue: "",
              decoration: InputDecoration(labelText: 'Beskrivelse'),
              onChanged: (text) {
                description = text;
              }),
          TextFormField(
            initialValue: "",
            decoration: InputDecoration(labelText: 'Kategori'),
          ),
        ]));
  }

//   Future<DateTime> selectedDate = showDatePicker(
//   context: context,
//   initialDate: DateTime.now(),
//   firstDate: DateTime(2017),
//   lastDate: DateTime(2020),
//   builder: (BuildContext context, Widget child) {
//     return Theme(
//       data: ThemeData.dark(),
//       child: child,
//     );
//   },
// ),

}
