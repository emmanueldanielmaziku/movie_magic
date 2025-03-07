import 'dart:ui';
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
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: BottomNavigationBar(
          backgroundColor: Colors.black.withOpacity(0.1), // Lower opacity
          elevation: 0, // Remove shadow
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: onDestinationSelected,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _buildBottomNavigationBarItem(icon: Iconsax.home, index: 0),
            _buildBottomNavigationBarItem(
                icon: Iconsax.search_normal, index: 1),
            _buildBottomNavigationBarItem(icon: Iconsax.save_2, index: 2),
            _buildBottomNavigationBarItem(icon: Iconsax.personalcard, index: 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData icon,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkResponse(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => onDestinationSelected(index),
          child: Icon(
            icon,
            color: selectedIndex == index ? Colors.deepPurple : Colors.grey,
          ),
        ),
      ),
      label: '',
    );
  }
}
