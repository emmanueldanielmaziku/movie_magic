import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NavBar extends StatelessWidget {
  final Function(int) onDestinationSelected;
  final int selectedIndex;
  const NavBar(
      {super.key,
      required this.onDestinationSelected,
      required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        backgroundColor: Colors.transparent,
        height: 70.0,
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          onDestinationSelected(index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
          NavigationDestination(
              icon: Icon(Iconsax.search_normal), label: "Search"),
          NavigationDestination(icon: Icon(Iconsax.save_2), label: "Saves"),
          NavigationDestination(
              icon: Icon(Iconsax.personalcard), label: "Profile")
        ]);
  }
}
