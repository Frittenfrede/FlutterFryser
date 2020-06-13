import 'package:flutter/material.dart';
import 'package:fryser/services/auth.dart';
import 'package:fryser/shared/constants.dart';
import 'package:fryser/shared/loading.dart';
import 'package:flutter/animation.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin{
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  Animation animation;
AnimationController animationController;

  // text field state
  String email = '';
  String password = '';
  String error = '';

//Animation control
@override
    void initState(){
      super.initState();
      animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);

      animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn));

        animationController.forward();
    }

    @override
void dispose() {
  animationController.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(animation: animationController, builder: (BuildContext context, Widget child){
      return loading
          ? Loading()
          : Scaffold(
              appBar: AppBar(
                title: Text("Sign in to FryserApp"),
                actions: <Widget>[
                  FlatButton.icon(
                      onPressed: () {
                        widget.toggleView();
                      },
                      icon: Icon(Icons.person),
                      label: Text("Register"))
                ],
              ),
              body: Transform(
                transform: Matrix4.translationValues(animation.value, 0.0, 0.0),
                              child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          TextFormField(
                              decoration:
                                  textInputDecoration.copyWith(hintText: 'Email'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              }),
                          SizedBox(height: 20),
                          TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Password'),
                              validator: (val) => val.length < 6
                                  ? 'Enter an password 6+ chars long'
                                  : null,
                              obscureText: true,
                              onChanged: (val) {
                                setState(() => password = val);
                              }),
                          SizedBox(height: 20),
                          RaisedButton(
                              color: Colors.blue,
                              child: Text('sign in',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result = await _auth
                                      .signInWithEmailAndPassword(email, password);
                                  if (result == null) {
                                    setState(() {
                                      error =
                                          "could not sign in with those credentials";
                                      loading = false;
                                    });
                                  }
                                }
                              }),
                          SizedBox(
                            height: 12,
                          ),
                          Text(error,
                              style: TextStyle(color: Colors.red, fontSize: 14))
                        ],
                      ),
                    )),
              ));},
    );
  }
}
