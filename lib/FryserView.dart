import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fryser/models/user.dart';
import 'package:fryser/screens/home/addFryser.dart';
import 'package:fryser/shared/loading.dart';
import 'models/freezer.dart';
import 'package:fryser/services/auth.dart';
import 'package:fryser/services/database.dart';
import 'package:provider/provider.dart';
import 'freezer_list.dart';
import 'models/freezer.dart';
import 'router.dart' as router;

class FryserView extends StatelessWidget {
  //const FryserView({Key key}) : super(key: key);
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    void _showAddFryserView() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return addFryser();
          });
    }

    return FutureBuilder<Stream<List<Freezer>>>(
      future: DatabaseService(uid: user.uid).freezers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<List<Freezer>>(
              stream: snapshot.data,
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return Scaffold(
                  appBar: AppBar(
                    title: Text("Dine frysere"),
                    actions: <Widget>[
                      FlatButton.icon(
                        icon: Icon(Icons.person),
                        label: Text("logout"),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                      ),
                      FlatButton.icon(
                        icon: Icon(Icons.add),
                        label: Text("Tilføj fryser"),
                        onPressed: () async {
                          _showAddFryserView();
                        },
                      )
                    ],
                  ),

                  body: FreezerList(),
                  // body: new Container(
                  //     child: ListView.builder(
                  //         itemCount: frysere.length,
                  //         itemBuilder: (context, index) {
                  //           return ListTile(
                  //             title: Text(frysere[index].navn),
                  //             trailing: Row(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: <Widget>[
                  //                 IconButton(
                  //                     icon: Icon(Icons.build),
                  //                     tooltip: 'Redigere denne fryser',
                  //                     onPressed: () {}),
                  //                 IconButton(
                  //                     icon: Icon(Icons.delete),
                  //                     tooltip: 'Slette denne fryser',
                  //                     onPressed: () {
                  //                       showDialog<void>(
                  //                         context: context,
                  //                         barrierDismissible:
                  //                             false, // user must tap button!
                  //                         //SlidableDrawerActionPane
                  //                         builder: (BuildContext context) {
                  //                           return AlertDialog(
                  //                             title: Text('Rewind and remember'),
                  //                             content: SingleChildScrollView(
                  //                               child: ListBody(
                  //                                 children: <Widget>[
                  //                                   Text(
                  //                                       'Er du sikker på at du vil slette vil slette ${frysere[index].navn}'),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                             actions: <Widget>[
                  //                               FlatButton(
                  //                                 child: Text('Accepter'),
                  //                                 onPressed: () {
                  //                                   sletFryser(frysere[index]);
                  //                                   Navigator.pushReplacementNamed(
                  //                                       context, "FryserIndholdView");
                  //                                 },
                  //                               ),
                  //                               FlatButton(
                  //                                 child: Text('Accepter ikke'),
                  //                                 onPressed: () {
                  //                                   Navigator.of(context).pop();
                  //                                 },
                  //                               ),
                  //                             ],
                  //                           );
                  //                         },
                  //                       );
                  //                     })
                  //               ],
                  //             ),
                  //             onTap: () {
                  //               Navigator.pushNamed(context, "FryserIndhold",
                  //                   arguments: frysere[index]);
                  //             },
                  //           );
                  //         })),
                  // floatingActionButton: FloatingActionButton(
                  //   onPressed: () => {Navigator.pushNamed(context, "AddFryser")},
                  //   tooltip: 'Tilføj fryser',
                  //   backgroundColor: Colors.blue,
                  //   child: const Icon(Icons.add),
                  // ),
                );
              });
        } else {
          print("FryserVied loading");
          return Loading();
        }
      },
    );
  }
}
// )

// class BodyLayout extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _myListView(context);
//   }
// }

// Widget _myListView(BuildContext context) {

// }
