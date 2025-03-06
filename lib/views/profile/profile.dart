import 'package:flutter/material.dart';
import 'package:movie_magic/core/services/auth_service.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            AuthService().signOut();
          },
          child: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
