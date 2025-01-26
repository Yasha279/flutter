import 'package:demo_project/matrimonialProject/UserListPage.dart';
import 'package:flutter/material.dart';

import '../practice/inkWell.dart';
import 'AboutUsPage.dart';
import 'AddUserPage.dart';
import 'DashboardCard.dart';
import 'FavoriteUserPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}
class User {
  final String name;
  final int age;
  final String gender;

  User({required this.name, required this.age, required this.gender});
}
class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Matrimonial App Dashboard',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 29),),
      ),
      body: Stack(
        fit: StackFit.expand, // Make the stack fill the whole screen
        children: [
        // Background Image
          Opacity(
            opacity: 0.5, // Set the opacity here (0.0 = fully transparent, 1.0 = fully opaque)
            child: Image.network(
              'https://market99.com/cdn/shop/articles/hands-couple-with-heart-shaped-box-NEW.jpg?crop=center&height=1013&v=1706860758&width=780', // Replace with your image asset path
              fit: BoxFit.cover,
            ),
          ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              // Add User Card
              DashboardCard(
                icon: Icons.person_add,
                title: 'Add User',
                onTap: () {
                  // Navigate to Add User Page (example placeholder)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddUserPage()),
                  );
                }, description: '',
              ),
              // User List Card
              DashboardCard(
                icon: Icons.list,
                title: 'User List',
                description: '',
                onTap: () {
                  // Navigate to User List Page (example placeholder)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserListPage()),
                  );
                }
              ),
              // Favorite User Card
              DashboardCard(
                icon: Icons.favorite,
                title: 'Favorite User',
                description: '',
                onTap: () {
                  // Navigate to Favorite Users Page (example placeholder)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoriteUserPage()),
                  );
                },
              ),
              // About Us Card
              DashboardCard(
                icon: Icons.info,
                title: 'About Us',
                description: '',
                onTap: () {
                  // Navigate to About Us Page (example placeholder)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      ]
    ),
    );
   }
}
