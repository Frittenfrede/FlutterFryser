import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fryser/models/freezer.dart';
import 'package:fryser/models/user.dart';

class DatabaseService {
  // Laver et DataBaseService objekt for den specifikke bruger (UserID)
  final String uid;
  DatabaseService({this.uid});

// collection reference til collections i firestore

  final CollectionReference fryserCollection =
      Firestore.instance.collection('frysere');
  final CollectionReference foodCollection =
      Firestore.instance.collection('food');


// Tilføjer en ny fryser eller Tilføjer en testfryser med food eksempler, når der oprettes en ny bruger
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
        'fryser': docref.documentID
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
// Tager et snapshot og converterer den til et Dart objekt vha. .fromJson() moetoden
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData.fromJson(snapshot.data);
  }

  // get user doc stream
  // Laver en stream af userData, så hvis der er "nogen" der lytter, så får de alle den samme data
  Stream<UserData> get userData {
    return fryserCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

// returner en future der indeholder af stream af alle de frysere der hører til den specifikke bruger
// Når getDocuments() kaldes retunerer den et snapshot, hvilket skal konverteres til Dart objekter.
// Dette gøres vha. af _freezersFromSnapshot()
// _freezersFromSnapshot henter også alle de foods ned der passer til den specifikke fryser
  Future<Stream<List<Freezer>>> get freezers async {
    var temp = await fryserCollection
        .where('user', isEqualTo: uid)
        .getDocuments()
        .then((onValue) =>
            (onValue.documents.map(_freezersFromSnapshot).toList()));

    return Stream.value(temp);
  }

  Freezer _freezersFromSnapshot(DocumentSnapshot snapshot) {
    Freezer temp = Freezer.fromJson(snapshot.data);


    List<Food> foods = new List<Food>();
    foodCollection
        .where('fryser', isEqualTo:snapshot.documentID)
        .getDocuments()
        .then((onValue) => foods = onValue.documents.map(_foodsFromSnapshot).toList()).then((onValue)=>temp.foods=onValue);
        
    print(foods);
    temp.foods = foods;
    temp.id = snapshot.documentID;
    return temp;
  }
 // Konverter foods snapshot til Dart objekter
  Food _foodsFromSnapshot(DocumentSnapshot snapshot) {
    return Food.fromJson(snapshot.data);
  }

// Sletter en fryser fra firestore databasen
  Future<void> deleteFreezer(Freezer freezer) async {
    await fryserCollection.document(freezer.id).delete();
  }

// Tilføjer en food til en fryser
  Future<void> addFood(Freezer freezer, Food food) async{
    DocumentReference docRef = fryserCollection.document(freezer.id);
    foodCollection.add({
      'category': food.category,
        'dato': food.date,
        'description': food.description,
        'fryser': docRef.documentID
  });
}
}
