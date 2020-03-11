import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Screens/Authenticate/authenticate.dart';
import 'package:todoapp/Screens/Home/home.dart';
import 'package:todoapp/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either home or authenticate widget
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
