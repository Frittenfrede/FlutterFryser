import "package:flutter/material.dart";
import 'package:fryser/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'router.dart' as router;


import 'models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either Home or Authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return MaterialApp(
        title: 'Mikes fryser app',
        onGenerateRoute: router.generateRoute,
        initialRoute: "FryserView",
      );
      
    }
  }
}
