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
    const Profile(),
    const Profile(),
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
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(top: BorderSide(width: 0.5, color: Colors.grey))),
        child: NavBar(
          onDestinationSelected: (index) {
            screenController(index);
          },
          selectedIndex: selectedScreen,
        ),
      ),
    );
  }
}
