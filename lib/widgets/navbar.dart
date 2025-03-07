import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NavBar extends StatelessWidget {
  final Function(int) onDestinationSelected;
  final int selectedIndex;

  const NavBar({
    super.key,
    required this.onDestinationSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: (index) {
        onDestinationSelected(index);
      },
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Iconsax.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.search_normal),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.save_2),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.personalcard),
          label: '',
        ),
      ],
    );
  }
}
