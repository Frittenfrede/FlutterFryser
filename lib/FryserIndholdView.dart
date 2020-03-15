import 'package:flutter/material.dart';
import 'models/freezer.dart';

class FryserIndhold extends StatelessWidget {
  final Freezer fryser;

  FryserIndhold({Key key, @required this.fryser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Indhold af ${fryser.navn}')),
      body: ListView.builder(
          itemCount: fryser.foods.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(fryser.foods[index].description),
              leading: Icon(
                Icons.local_dining,
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.pushNamed(context, "FoodDescription",
                    arguments: fryser.foods[index]);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        tooltip: 'Tilføj vare',
      ),
    );
  }
}
