import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nss/setup/databaseService.dart';



class Home extends StatelessWidget {
 
  final String email;
  Home({this.email});

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              document['name'],
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Text(document['time']),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffddddff),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              document['Intrested members'].toString(),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ],
      ),
      onTap: () {
        Firestore.instance.runTransaction((transaction) async {
          DocumentSnapshot freshSnap =
              await transaction.get(document.reference);
            await transaction.update(freshSnap.reference, {
              'Intrested members': freshSnap['Intrested members'] + 1,
            
          });
          await EventDatabase(uid:email,eventName:document['name']).updateUserData(email);
        });
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
                _buildListItem(context, snapshot.data.documents[index]),
          );
        }),
    );
  }
}

   