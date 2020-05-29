

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nss/setup/databaseService.dart';



class Home extends StatelessWidget {
 
  final String email;
  Home({this.email});
  List<String> sno;
  List<int> no;
  List<int> max;
  Widget _buildListItem(BuildContext context, DocumentSnapshot document,int index,int length) {
    var sno = List<String>.generate(length, (i) => (i + 1).toString());
    var no = List<int>.generate(length, (i) => (i + 1));
    var max = List<int>.generate(length, (i) => (i + 1));

    sno[index] = (document['Interested members']+ 1).toString();
    no[index] = document['Interested members'];
    max[index] = document['Required members'];
    
    void showSnackBar(BuildContext context){
      var snackBar =SnackBar(
        content: Text('Unable to register as required number of members are registered'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        
      );
        Scaffold.of(context).showSnackBar(snackBar);
    } 
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              document['Name'],
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          // Text(document['time']),
          
          Container(
            decoration: const BoxDecoration(
              color: Colors.green
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              document['Interested members'].toString(),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          
        ],
      ),
      subtitle: Row(children:[Text(document['Date']),
      Text(document['Time']),
      Text('Required members:'+document['Required members'].toString())
      ]),
      onTap: () {
       
        if(no[index]<max[index]){
        Firestore.instance.runTransaction((transaction) async {
          DocumentSnapshot freshSnap =
              await transaction.get(document.reference);
            await transaction.update(freshSnap.reference, {
              'Interested members': freshSnap['Interested members'] + 1,
               
          });
          if(no[index]==0){
          await EventDatabase(uid:email,eventName:document['Name'],sno:sno[index]).setUserData(email,sno[index]);
          }
          else{
          await EventDatabase(uid:email,eventName:document['Name'],sno:sno[index]).updateUserData(email,sno[index]);
          }
        });}
        else{
          showSnackBar(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
            itemExtent: 80.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _buildListItem(context, snapshot.data.documents[index], index, snapshot.data.documents.length),
          );
        }),
    );
  }
}

   