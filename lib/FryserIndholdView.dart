import 'package:flutter/material.dart';
import 'filterFoods.dart';
import 'models/freezer.dart';

class FryserIndhold extends StatefulWidget {
  Freezer freezer;

  FryserIndhold({Key key, @required this.freezer}) : super(key: key);

  @override
  _FryserIndholdState createState() => _FryserIndholdState();
}

class _FryserIndholdState extends State<FryserIndhold> {
  @override
  Widget build(BuildContext context) {

    void _showFilterFoods() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return FilterFoods();
          });
    }
    
    return Scaffold(
      appBar: AppBar(title: Text('Indhold af ${widget.freezer.navn}'),
      actions: <Widget>[
      IconButton(icon: Icon(Icons.sort),
       onPressed: (){_showFilterFoods();})],),
      body: ListView.builder(
          itemCount: widget.freezer.foods.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.freezer.foods[index].description + "  - "),
              leading: Icon(
                Icons.local_dining,
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: ()  {
               Navigator.pushNamed(context, "FoodDescription",
                    arguments: widget.freezer.foods[index]);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
         final updatedFreezer = await Navigator.pushNamed(context, "addVare",
                    arguments: widget.freezer);
                    setState(() {
                      if(updatedFreezer != null)
                      widget.freezer = updatedFreezer;
                    });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        tooltip: 'Tilføj vare',
      ),
    );



  }
  // List<String> categories = ["Beef","Fish","Pork","Chicken","Vegetables","Ready-to-eat meal","Other"];
// Icon getIcon(Food food){
// if(food.category == "Beef"){
// return Icon(icon: Icons)
// }
// else if(food.category == "Fish"){
  
// }
// else if(food.category == "Chicken"){
  
// }
// else if(food.category == "Vegetables"){
  
// }
// else if(food.category == "Ready-to-eat meal"){
  
// }
// else if(food.category == "Other"){
  
// }

// }
}
