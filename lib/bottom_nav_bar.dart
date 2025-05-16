// lib/bottom_nav_bar.dart

import 'package:flutter/material.dart';
import 'package:gamify/home_screen.dart';
import 'package:gamify/statistic_screen.dart';
import 'package:gamify/reward_screen.dart';
import 'package:gamify/task_selection_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({super.key, required this.selectedIndex});

  // This function decides where to go when you tap on a nav item
  void _onItemTapped(BuildContext context, int index) {
    // If the current tab is tapped again, don’t do anything
    if (index == selectedIndex) return;

    // Navigate to the screen based on index
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TaskSelectionScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StatisticScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RewardScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // Highlights the tab we're currently on
      currentIndex: selectedIndex,
      // This runs whenever a tab is tapped
      onTap: (index) => _onItemTapped(context, index),
      backgroundColor: Colors.white,
      selectedItemColor: Colors.orange, // color for the active tab
      unselectedItemColor: Colors.grey, // other tabs
      type: BottomNavigationBarType.fixed, // all icons show
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Rewards',
        )
      ],
    );
  }
}
