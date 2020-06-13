import 'package:flutter/material.dart';
import 'package:fryser/services/database.dart';
import 'package:fryser/shared/constants.dart';
import 'package:provider/provider.dart';
import 'models/freezer.dart';
import 'models/user.dart';

class AddVare extends StatefulWidget {
 final Freezer freezer;
  AddVare({Key key, this.freezer}) : super(key: key);

  @override
  _AddVareState createState() => _AddVareState();
}

class _AddVareState extends State<AddVare> {

 final _formKey = GlobalKey<FormState>();
 DateTime _date = DateTime.now();
 
  Future<Null> selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
    context: context, 
    initialDate: _date, 
    firstDate: DateTime(2010), 
    lastDate: DateTime.now());
    

    if(picked != null && picked != _date){


      setState(() {
        _date = picked;
      print(_date.toString());
      });
    }
  }
  List<String> categories = ["Beef","Fish","Pork","Chicken","Vegetables","Ready-to-eat meal","Other"];
  String _description;
  String _category;
  DateTime _dateTime;
  var textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
 final user = Provider.of<User>(context);

    
      textController.text = _date.day.toString() +"-"+_date.month.toString() + "-"+_date.year.toString();
    
    return Scaffold(
        appBar: AppBar(title: Text('Add Product')),
        body: Center(
          
          child: Form(
            key: _formKey,
              child: Column(
              //crossAxisAlignment: CrossAxisAlignment.end,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
             
              Container(
                width: 300,
                
                child: TextFormField(
                    initialValue: "",
                     decoration:
                      textInputDecoration.copyWith(hintText: 'Food description'),
                      validator: (val) =>
                      val.isEmpty ? 'Please enter a description' : null,
                            onChanged: (val) => setState(() => _description = val),
                    ),
              ),
              SizedBox(height:20),
               Container(

                        width: 300,
                        child: DropdownButtonFormField(
                          decoration: textInputDecoration,
                          value: _category != null ? _category : "Beef",
                          items: categories.map((f) {
                            return DropdownMenuItem(
                              value: f,
                              child: Text(f)
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => _category = val),
                        ),
                      ),
                       SizedBox(height:20),
                      Container(
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                            icon: Icon(Icons.calendar_today), 
                            onPressed: (){
                              selectDate(context);
                            }),
                            Container(
                width: 250,
                
                child: InkWell(
                  onTap: (){
                    selectDate(context);
                  },
                                  child: TextField(
                         controller: textController,
                         decoration:
                          textInputDecoration.copyWith(hintText: 'Date',enabled: false),
                          
              ),
                ),),

                           RaisedButton(
                      color: Colors.blue,
                      child:
                          Text('Tilføj', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          String dateString = _date.day.toString()+_date.month.toString()+_date.year.toString();
                          Food newFood = new Food(
                              _description,
                              int.parse(dateString),
                           _category != null ? _category : "Beef");
                           
                          await DatabaseService(uid: user.uid)
                              .addFood(widget.freezer, newFood);
                              widget.freezer.foods.add(newFood);
                          Navigator.pop(context,widget.freezer);
                        }
                      },
                    )
                          ],
                        ),
                      )
            ]),
          ),
        ));
  }
}
