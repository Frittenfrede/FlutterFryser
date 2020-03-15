import 'package:flutter/material.dart';
import 'package:fryser/FryserView.dart';
import 'package:fryser/AddFryserView.dart';
import 'package:fryser/FoodDescriptionView.dart';
import 'package:fryser/FryserIndholdView.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => FryserView());
    case 'AddFryser':
      var frysere = settings.arguments;
      return MaterialPageRoute(builder: (context) => AddFryser());
    case 'FoodDescription':
      var food = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => FoodDescription(food: food));
    case 'FryserIndhold':
      var fryser = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => FryserIndhold(fryser: fryser));
   // case ''
      break;
    default:
     return MaterialPageRoute(builder: (context) => FryserView());
  }
}
