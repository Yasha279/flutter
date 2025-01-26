import 'package:flutter/material.dart';

import 'package:demo_project/matrimonialProject/AddUserPage.dart';

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('User List')
      ),
      body: ListView.builder(
        itemCount: AddUserPage.userList.length,
        itemBuilder: (context, index) {
          var user = AddUserPage.userList[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text('Age: ${user.age}, Gender: ${user.gender}'),
          );
        },
      ),
    );
  }
}