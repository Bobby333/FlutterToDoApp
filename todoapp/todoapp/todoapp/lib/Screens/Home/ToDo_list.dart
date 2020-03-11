import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Screens/Home/todo_tile.dart';
import 'package:todoapp/models/todo.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {

    final todos = Provider.of<List<Todo>>(context);


    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index){
        return ToDoTile(todo: todos[index]);
      },


    );

  }
}
