import 'dart:collection';

class Freezer {
  String navn;
  List<Food> foods;
  double temperatur;
  String id;
  Freezer({this.navn, this.foods, this.temperatur, this.id});

  Map<String, dynamic> toJson() {
    // print("Ja");
    // print(navn);
    // print(foods.map((food) => food.toJson()).toList());
    // print(temperatur);
    return {
      "navn": navn,
      "foods": foods.map((food) => food.toJson()).toList(),
      "temperatur": temperatur,
    };
  }

  Freezer.fromJson(Map<dynamic, dynamic> json) {
    navn = json['navn'];
    List<Food> tempFoods = new List<Food>();
    foods = tempFoods;
    temperatur = double.parse(json['temperatur'].toString());
  }
}

class Food {
  int date;
  String description;
  String category;
  Food(description, date, category) {
    this.date = date;
    this.description = description;
    this.category = category;
  }

  Map<String, dynamic> toJson() {
    return {"date": date, "description": description, "category": category};
  }

  Food.fromJson(Map<dynamic, dynamic> json) {
    date = json['date'];
    description = json['description'];
    category = json['category'];
  }
}
