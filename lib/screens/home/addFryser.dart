import 'package:flutter/material.dart';
import 'package:fryser/models/freezer.dart';
import 'package:fryser/models/user.dart';
import 'package:fryser/services/database.dart';
import 'package:fryser/shared/constants.dart';
import 'package:fryser/shared/constants.dart';
import 'package:fryser/shared/loading.dart';
import 'package:provider/provider.dart';

class addFryser extends StatefulWidget {
  addFryser({Key key}) : super(key: key);

  @override
  _addFryserState createState() => _addFryserState();
}

class _addFryserState extends State<addFryser> {
  final _formKey = GlobalKey<FormState>();
  final List<double> temperature = [-12, -14, -16, -18, -20, -22];

  String _navn;
  double _temperatur;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //print("------------------------------" + user.uid);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Tilføj en fryser'),
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    child: TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Fryser navn'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _navn = val),
                    ),
                  ),
                  SizedBox(height: 20),
                  //dropdown
                  Container(
                    width: 300,
                    child: DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _temperatur ?? -18,
                      items: temperature.map((f) {
                        return DropdownMenuItem(
                          value: f,
                          child: Text(f.toString() + " degress"),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _temperatur = val),
                    ),
                  ),

                  //slider
                  RaisedButton(
                    color: Colors.blue,
                    child:
                        Text('Tilføj', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        Freezer newFreezer = new Freezer(
                            navn: _navn,
                            foods: new List<Food>(),
                            temperatur: _temperatur);
                        await DatabaseService(uid: user.uid)
                            .updateuserData(newFreezer);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
