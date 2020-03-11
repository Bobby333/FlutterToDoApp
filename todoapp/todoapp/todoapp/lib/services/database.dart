import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/models/todo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/models/user.dart';


CollectionReference toDoCollection = Firestore.instance.collection(
   'ToDo' );


class DatabseService {

  CollectionReference toDoCollection = Firestore.instance.collection(
      'ToDo' );

    final String uid;

  DatabseService({this.uid});

//collection reference

 // CollectionReference toDoCollection = Firestore.instance.collection(
   //   'ToDo');

  Future addToDoItem(String description) async {

    return await toDoCollection.document(description).setData({
      'Description': description,

    });

  }
   Future delete(String doc) async{
     toDoCollection.document(doc).delete();

}

  Future<String> returnid()async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final userId = user.uid;
    return userId;
  }

  List<Todo> _toDoListFromSnapShot(QuerySnapshot snapshot) {
    print(snapshot.documents.length);
    return snapshot.documents.map((doc) {

      return Todo(
          description: doc.data['Description']
      );
    }).toList();
  }


    Stream<List<Todo>> get toDo{
    return toDoCollection.snapshots().map(_toDoListFromSnapShot);
  }


}

