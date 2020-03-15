import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fryser/models/freezer.dart';
import 'package:fryser/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

// collection reference
  final CollectionReference fryserCollection =
      Firestore.instance.collection('frysere');
  final CollectionReference foodCollection =
      Firestore.instance.collection('food');

  Future updateuserData(Freezer fryser) async {
    var docref = await fryserCollection.add(
        {'navn': fryser.navn, 'temperatur': fryser.temperatur, 'user': uid});

    if (fryser.navn == "Test fryser") {
      Food test1 = new Food("Ost", 112018, "Kylling");
      Food test2 = new Food("Ost", 122019, "Kylling");
      await foodCollection.add({
        'category': test1.category,
        'dato': test1.date,
        'description': test1.description,
        'fryser': docref
      });

      await foodCollection.add({
        'category': test2.category,
        'dato': test2.date,
        'description': test2.description,
        'fryser': docref
      });
    }

    // foodCollection.where("fryser", isEqualTo: docref).snapshots().listen(
    //     (data) => data.documents
    //         .forEach((doc) => print("BLYAT" + doc["fryser"].toString())));
  }

// Fryser list from snapshot
  List<Freezer> _freezerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Freezer(
          navn: doc.data['navn'] ?? '',
          foods: doc.data['foods'] ?? new List<Food>(),
          temperatur: doc.data['temperatur'] ?? 0);
    }).toList();
  }

// userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData.fromJson(snapshot.data);
    // uid: uid,
    //frysere: snapshot.data['frysere'] ?? new List<Freezer>());
  }

  // get user doc stream
  Stream<UserData> get userData {
    return fryserCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  Future<Stream<List<Freezer>>> get freezers async {
    fryserCollection
        .where('user', isEqualTo: uid)
        .getDocuments()
        .then((onValue) => print(onValue.documents.toList()[0].data));
    var temp = await fryserCollection
        .where('user', isEqualTo: uid)
        .getDocuments()
        .then((onValue) =>
            (onValue.documents.map(_freezersFromSnapshot).toList()));

    return Stream.value(temp);
  }

  Freezer _freezersFromSnapshot(DocumentSnapshot snapshot) {
    List<Food> foods = new List<Food>();
    foodCollection
        .where('fryser', isEqualTo: snapshot.documentID)
        .getDocuments()
        .then((onValue) => onValue.documents.map(_foodsFromSnapshot).toList())
        .then((onValue) => print(onValue));
    print(foods);
    Freezer temp = Freezer.fromJson(snapshot.data);
    temp.foods = foods;
    return temp;
  }

  Food _foodsFromSnapshot(DocumentSnapshot snapshot) {
    return Food.fromJson(snapshot.data);
  }
}
