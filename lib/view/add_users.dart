import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({super.key});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final placeController = TextEditingController();
  final aboutController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter name';
                    } else {
                      return null;
                    }
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('First name')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter phone';
                    } else {
                      return null;
                    }
                  },
                  maxLength: 10,
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Phone number')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter place';
                    } else {
                      return null;
                    }
                  },
                  controller: placeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('Place')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter about';
                    } else {
                      return null;
                    }
                  },
                  controller: aboutController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('about')),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    final validate = formKey.currentState!.validate();
                    if (!validate) {
                      return;
                    }
                    addUsers();
                    disposeControllers();
                  },
                  child: Text('Add'))
            ],
          ),
        ),
      ),
    );
  }

  void addUsers() {
    final data = {
      'name': nameController.text,
      'phone': phoneController.text,
      'place': placeController.text,
      'about': aboutController.text
    };
    users.add(data);
  }

  void disposeControllers() {
    nameController.clear();
    phoneController.clear();
    placeController.clear();
    aboutController.clear();
  }
}
