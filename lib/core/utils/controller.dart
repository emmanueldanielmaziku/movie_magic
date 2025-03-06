import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_magic/views/home/home.dart';
import 'package:movie_magic/views/profile/profile.dart';
import 'package:movie_magic/widgets/navbar.dart';

class Controller extends StatefulWidget {
  const Controller({super.key});

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  int selectedScreen = 0;
  final List<Widget> _screens = [
    const Home(),
    const Home(),
    const Home(),
    const Profile(),
  ];

  void screenController(index) {
    setState(() {
      selectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[selectedScreen],
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                border:
                    Border(top: BorderSide(width: 0.5, color: Colors.grey))),
            child: NavBar(
              onDestinationSelected: (index) {
                screenController(index);
              },
              selectedIndex: selectedScreen,
            ),
          ),
        ),
      ),
    );
  }
}
