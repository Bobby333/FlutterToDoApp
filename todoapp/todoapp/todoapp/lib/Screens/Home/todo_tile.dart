import 'package:flutter/material.dart';
import 'package:todoapp/Screens/Home/home.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/database.dart';

class ToDoTile extends StatelessWidget {
  final Todo todo;
  ToDoTile({this.todo});
    String userId = DatabseService().returnid().toString();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(todo.description),
          onTap: () => Home().promptRemoveTodoItem(todo.description.toString(), userId, todo, context),
        ),
      ),
    );
  }
}
