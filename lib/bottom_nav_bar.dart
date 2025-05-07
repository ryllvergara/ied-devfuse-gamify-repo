import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({super.key, required this.selectedIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/tasks');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/stats');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/rewards');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 78, 41, 21),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, Icons.home, 'Home', 0),
          _buildNavItem(context, Icons.check_circle, 'Tasks', 1),
          _buildNavItem(context, Icons.bar_chart, 'Stats', 2), // The "Stats" icon is for StatisticsScreen
          _buildNavItem(context, Icons.card_giftcard, 'Rewards', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final isSelected = index == selectedIndex;
    final color =
        isSelected ? const Color.fromARGB(255, 238, 157, 86) : Colors.white;

    return GestureDetector(
      onTap: () => _onItemTapped(context, index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontFamily: 'Times New Romance',
            ),
          ),
        ],
      ),
    );
  }
}
