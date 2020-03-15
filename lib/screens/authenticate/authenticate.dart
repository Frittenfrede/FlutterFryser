import 'package:flutter/material.dart';
import 'package:fryser/screens/authenticate/register.dart';
import 'package:fryser/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
