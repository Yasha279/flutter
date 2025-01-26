import 'package:flutter/material.dart';

import 'DashBoard.dart';

class AddUserPage extends StatefulWidget {
  static var userList;

  AddUserPage({super.key});
  @override
  _AddUserPageState createState() => _AddUserPageState();
}
final formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController ageController = TextEditingController();
String gender = 'Male';

class _AddUserPageState extends State<AddUserPage> {


  // Store user data locally (simulating a database)
  static List<User> userList = [];

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      final newUser = User(
        name: nameController.text,
        age: int.parse(ageController.text),
        gender: gender,
      );

      setState(() {
        userList.add(newUser);
      });

      nameController.clear();
      ageController.clear();
      setState(() {
        gender = 'Male';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Age Field
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Gender Dropdown
              DropdownButtonFormField<String>(
                value: gender,
                decoration: InputDecoration(labelText: 'Gender'),
                onChanged: (String? newValue) {
                  setState(() {
                    gender = newValue!;
                  });
                },
                items: ['Male', 'Female', 'Other'].map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
