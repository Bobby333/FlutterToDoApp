import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Screens/Home/ToDo_list.dart';
import 'package:todoapp/Screens/Home/todo_tile.dart';
import 'package:todoapp/models/user.dart';
import 'package:todoapp/services/auth.dart';
import 'package:todoapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/Screens/Authenticate/sign_in.dart';
import 'package:todoapp/models/todo.dart';

class Home extends StatelessWidget {

  void promptRemoveTodoItem(String doc, String userId, Todo todo, context) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${doc}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      DatabseService(uid: userId).delete(todo.description.toString());
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }
  void _addTodoItem(String task) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final userId = user.uid;
    if(task.length > 0) {
      DatabseService(uid: userId).addToDoItem(task);
    }
  }
  void _pushAddTodoScreen(context) {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                      title: new Text('Add a new task')
                  ),
                  body: new TextField(
                    autofocus: true,
                    onSubmitted: (val) {
                      _addTodoItem(val);
                      Navigator.pop(context);
                    },
                    decoration: new InputDecoration(
                        hintText: 'Enter something to do...',
                        contentPadding: const EdgeInsets.all(16.0)
                    ),
                  )
              );
            }
        )
    );
  }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Todo>>.value(
      value: DatabseService().toDo,
      child: Scaffold(
          backgroundColor: Colors.deepOrange[50],
          appBar: AppBar(
            title: Text('ToDo'),
            backgroundColor: Colors.deepOrange[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('logout'),
               onPressed: () async {
                    await _auth.SignOut();
               },

              ),


              FlatButton.icon(
                icon: Icon(Icons.add),
                label: Text('Create'),
                onPressed: () async{
                  await _pushAddTodoScreen(context);
                },
             ),

            ],
          ),
           body: ToDoList(),




        ),
      );
  }
}
