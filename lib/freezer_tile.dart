import 'package:flutter/material.dart';
import 'freezer_list.dart';
import 'models/freezer.dart';

class FreezerTile extends StatelessWidget {
  final Freezer freezer;
  FreezerTile({this.freezer});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: Icon(Icons.apps),
            title: Text(freezer.navn),
            subtitle: Text("Temperatur: " + freezer.temperatur.toString()),
            //  onTap: ,
          ),
        ));
  }
}
