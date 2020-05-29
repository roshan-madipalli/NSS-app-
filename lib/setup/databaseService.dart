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

class EventDatabase{
  final String uid;
  final String eventName;
  EventDatabase({this.uid, this.eventName});
  final CollectionReference eventNameCollection = Firestore.instance.collection('Event registered List');

  Future updateUserData(String uid)async{
    return await eventNameCollection.document(eventName).setData({
      'uid': uid,
    });
  }

}

