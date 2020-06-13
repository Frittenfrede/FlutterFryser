import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fryser/main.dart';
import 'package:fryser/main.dart';
import 'package:fryser/services/database.dart';
import 'package:fryser/shared/loading.dart';
import 'package:provider/provider.dart';

import 'freezer_tile.dart';
import 'models/freezer.dart';
import 'models/user.dart';

class FreezerList extends StatefulWidget {
  FreezerList({Key key}) : super(key: key);

  @override
  _FreezerListState createState() => _FreezerListState();
}

class _FreezerListState extends State<FreezerList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return FutureBuilder<Stream<List<Freezer>>>(
        future: DatabaseService(uid: user.uid).freezers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder<List<Freezer>>(
                stream: snapshot.data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Scaffold(
                        body: new Container(
                          child: ListView.builder(
                              itemCount: snapshot.data.length ?? 0,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(snapshot.data[index].navn),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                          icon: Icon(Icons.build),
                                          tooltip: 'Redigere denne fryser',
                                          onPressed: () {}),
                                      IconButton(
                                          icon: Icon(Icons.delete),
                                          tooltip: 'Slette denne fryser',
                                          onPressed: () {
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              //SlidableDrawerActionPane
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Vil du slette ' + snapshot.data[index].navn+ "?"),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text(""),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text('Accepter ikke'),
                                                      onPressed: () {
                                                      Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child:
                                                          Text('Accepter'),
                                                      onPressed: () {
                                                        
                                                             DatabaseService(uid: user.uid).deleteFreezer(snapshot.data[index]);
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                "/");
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          })
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "FryserIndhold",
                                        arguments: snapshot.data[index]);
                                  },
                                );
                              }),
                        ),
                      );
                  } else {
                    print("IF SNAPSHOT HAS THE DATA FREEZ LISTT");
                    return Loading();
                  }
                });
          } else {
            print("Freezerlist loading");
            return Loading();
          }
        });
  }
}
