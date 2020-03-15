import 'freezer.dart';
import 'dart:convert';

class User {
  final String uid;

  User({this.uid});
}

class UserData {
  String uid;
  List<Freezer> frysere;

  UserData({this.uid, this.frysere});

  List<Freezer> getFrysere() {
    return frysere;
  }

  UserData.fromJson(Map<String, dynamic> data) {
    frysere = new List<Freezer>();

    //print((JSON.decode(json) as List));
  }
}
