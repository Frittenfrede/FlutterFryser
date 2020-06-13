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

class FryserView extends StatefulWidget {
  //const FryserView({Key key}) : super(key: key);
  @override
  _FryserViewState createState() => _FryserViewState();
}

class _FryserViewState extends State<FryserView> {
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
                    automaticallyImplyLeading: false,
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
                           setState(() {
                            
                           });
                        },
                      )
                    ],
                  ),

                  body: FreezerList(),
                );
              });
        } else {
          print("FryserView loading");
          return Loading();
        }
      },
    );
  }
}

