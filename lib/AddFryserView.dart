import 'package:flutter/material.dart';
import 'package:fryser/services/database.dart';
import 'package:provider/provider.dart';
import 'models/freezer.dart';

class AddFryser extends StatelessWidget {
  //final List<Freezer> frysere;
  final _formKey = GlobalKey<FormState>();

  //const AddFryser({Key key, this.frysere}) : super(key: key);
  Widget build(BuildContext context) {
    final freezers = Provider.of<List<Freezer>>(context);
    TextEditingController fryserController1 = new TextEditingController();
    TextEditingController fryserController2 = new TextEditingController();

    return
        //  StreamProvider<List<Freezer>>.value(
        //   value: DatabaseService().freezers,
        //   child:
        Scaffold(
      appBar: AppBar(title: Text('Tilføj en ny fryser')),
      body: Column(children: <Widget>[
        TextFormField(
            decoration: InputDecoration(labelText: "Navn på fryser"),
            controller: fryserController1,
            onChanged: (text) {}),
        TextFormField(
          decoration: InputDecoration(labelText: "Temperatur i fryser"),
          controller: fryserController2,
        ),
        const SizedBox(height: 30),
        RaisedButton(
            onPressed: () {
              print((double.tryParse(fryserController2.text)));
              if (double.tryParse(fryserController2.text) != null &&
                  fryserController1.text != "") {
                Freezer tempFryser = new Freezer(
                    navn: fryserController1.text,
                    foods: new List<Food>(),
                    temperatur: double.parse(fryserController2.text));
                freezers.add(tempFryser);
                // var temp = getFrysere();
                // temp.add(tempFryser);
                // setFrysere(temp);
                Navigator.pushNamed(context, "FryserIndholdView");
              } else {
                String alarmTekst = "";
                if (double.tryParse(fryserController2.text) == null) {
                  alarmTekst =
                      "Du skal angive et navn og en temperatur på din fryser";
                } else {
                  alarmTekst = "Du skal angive et navn på din fryser";
                }
                print("Alarm");
                showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text('Hovsa!'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(alarmTekst),
                                FlatButton(
                                  // icon: Icon(Icons.check),
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ));
                    });
              }
            },
            child: const Text('Tilføj fryser', style: TextStyle(fontSize: 20))),
      ]),
    );
  }
}
