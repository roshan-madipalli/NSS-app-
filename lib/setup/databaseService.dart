import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference usernameCollection = Firestore.instance.collection('User Details');

  Future updateUserData(String username,String idno)async{
    return await usernameCollection.document(uid).setData({
      'username': username,
      'ID no': idno,
    });
  }

}

class EventDatabase{
  final String uid;
  final String eventName;
  final String sno;
  EventDatabase({this.uid, this.eventName,this.sno});
  final CollectionReference eventNameCollection = Firestore.instance.collection('Event registered List');

  Future updateUserData(String uid,String sno)async{
    return await eventNameCollection.document(eventName).updateData({
      'uid'+sno: uid,
    });
  }
  Future setUserData(String uid,String sno)async{
    return await eventNameCollection.document(eventName).setData({
      'uid'+sno: uid,
    });
  }

}

