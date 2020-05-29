import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference usernameCollection = Firestore.instance.collection('USERNAME');

  Future updateUserData(String username)async{
    return await usernameCollection.document(uid).setData({
      'username': username,
    });
  }

}



