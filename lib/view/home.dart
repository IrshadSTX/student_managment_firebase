import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_users.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Student Details'),
          backgroundColor: Colors.red,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddUsers()));
          },
          elevation: 10,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        body: StreamBuilder(
          stream: users.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final DocumentSnapshot usersSnap = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        leading: CircleAvatar(),
                        title: Text(usersSnap['name']),
                        subtitle: Text(usersSnap['about']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.delete),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.edit)
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
            return Container();
          },
        ));
  }
}
