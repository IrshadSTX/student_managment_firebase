import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UpdateUsers extends StatefulWidget {
  String name;
  int phone;
  String place;
  String about;
  String id;
  UpdateUsers({
    super.key,
    required this.name,
    required this.phone,
    required this.place,
    required this.about,
    required this.id,
  });

  @override
  State<UpdateUsers> createState() => _UpdateUsersState();
}

class _UpdateUsersState extends State<UpdateUsers> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController placeController;
  late final TextEditingController aboutController;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone.toString());
    placeController = TextEditingController(text: widget.place);
    aboutController = TextEditingController(text: widget.about);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    placeController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
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
                      return 'Enter name';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter phone';
                    }
                    return null;
                  },
                  maxLength: 10,
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone number',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter place';
                    }
                    return null;
                  },
                  controller: placeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Place',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter about';
                    }
                    return null;
                  },
                  controller: aboutController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'About',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final validate = formKey.currentState!.validate();
                  if (!validate) {
                    return;
                  }
                  updateUsers(widget.id);
                  disposeControllers();
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void disposeControllers() {
    nameController.clear();
    phoneController.clear();
    placeController.clear();
    aboutController.clear();
  }

  void updateUsers(String id) {
    final data = {
      'name': nameController.text,
      'phone': int.parse(phoneController.text),
      'place': placeController.text,
      'about': aboutController.text,
    };
    users.doc(id).update(data);
  }
}
