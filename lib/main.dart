import 'package:flutter/material.dart';
import 'package:fryser/models/user.dart';
import 'package:fryser/services/auth.dart';
import 'package:fryser/wrapper.dart';
import 'package:provider/provider.dart';
import 'screens/home/home.dart';
import 'router.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    
    return
        //----------------------KOMMENTER DETTE IND FOR AT STARTE MED DATABASER IGEN------------------
        //Her kan tilføjes multiprovider
        StreamProvider<User>.value(
            value: AuthService().user,
            child: MaterialApp(
              home: Wrapper(),
            ));
  }
}
