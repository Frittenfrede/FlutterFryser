import 'package:flutter/material.dart';
import 'package:fryser/AddVare.dart';
import 'package:fryser/FryserView.dart';
import 'package:fryser/FoodDescriptionView.dart';
import 'package:fryser/FryserIndholdView.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => FryserView());
    
    case 'FoodDescription':
      var food = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => FoodDescription(food: food));
    case 'FryserIndhold':
      var freezer = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => FryserIndhold(freezer: freezer));
    case 'addVare':
      var freezer = settings.arguments;
      return MaterialPageRoute(builder: (context)=>AddVare(freezer:freezer));
   // case ''
      break;
    default:
     return MaterialPageRoute(builder: (context) => FryserView());
  }
}
