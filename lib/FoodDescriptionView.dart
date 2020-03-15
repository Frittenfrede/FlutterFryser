import 'package:flutter/material.dart';
import 'models/freezer.dart';

class FoodDescription extends StatelessWidget {
  final Food food;

  FoodDescription({Key key, @required this.food}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Oplysninger omkring valgte vare')),
        body: Column(children: <Widget>[
          TextFormField(
              initialValue: " ${food.description}",
              decoration: InputDecoration(labelText: 'Beskrivelse'),
              onChanged: (text) {
                food.description = text;
              }),
          TextFormField(
            initialValue: " ${food.category}",
            decoration: InputDecoration(labelText: 'Kategori'),
          ),
          TextFormField(
            initialValue: " Dag:  Måned:  År: ",
            decoration: InputDecoration(labelText: 'Dato for indsættelse'),
          )
        ]));
  }
}
