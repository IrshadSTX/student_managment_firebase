import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base/view/update_user.dart';
import 'package:flutter/material.dart';

class ListCardWidgets extends StatelessWidget {
  final dbName;

  ListCardWidgets({
    super.key,
    required this.usersSnap,
    required this.dbName,
  });

  final DocumentSnapshot<Object?> usersSnap;

  @override
  Widget build(BuildContext context) {
    final name = usersSnap['name'];
    final phone = usersSnap['phone'];
    final place = usersSnap['place'];
    final about = usersSnap['about'];
    final String id = usersSnap.id;

    return ListTile(
      leading: CircleAvatar(),
      title: Text(usersSnap['name']),
      subtitle: Text(usersSnap['about']),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                int parsedPhone;
                try {
                  parsedPhone = int.parse(phone);
                } catch (e) {
                  // Handle the error, e.g., show an error message to the user
                  log('Invalid phone number: $phone');
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateUsers(
                      name: name,
                      phone: parsedPhone,
                      place: place,
                      about: about,
                      id: id,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.blue,
              )),
          IconButton(
              onPressed: () {
                deleteUser(usersSnap.id);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  void deleteUser(String id) {
    users.doc(id).delete();
  }
}
