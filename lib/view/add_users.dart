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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('First name')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Phone number')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Place')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('about')),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
