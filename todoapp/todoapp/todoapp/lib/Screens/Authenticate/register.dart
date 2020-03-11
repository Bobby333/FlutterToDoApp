import 'package:flutter/material.dart';
import 'package:todoapp/services/auth.dart';
import 'package:todoapp/shared/constants.dart';
import 'package:todoapp/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey  =GlobalKey<FormState>();
  bool loading = false;


  //Text field state
  String email ='';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.deepOrange[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[400],
        elevation: 0.0,
        title: Text('Sign up to ToDo List'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height:20.0),
              TextFormField(
                decoration:textInputDecorations.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter and email': null,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height:20.0),
              TextFormField(
                decoration: textInputDecorations.copyWith(hintText: 'Password'),
                validator: (val) => val.length< 6 ? 'Enter a password 6+ chars long': null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height:20.0),
              RaisedButton(
                color: Colors.blueAccent[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Please supply a valid email';
                        loading = false;});
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                  error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )

            ],
          ),
        ),
      ),
    );
  }
}
