import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'task_progress_screen.dart'; // Make sure this file exists

class StatisticsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categoryData = [
    {"label": "SPIRITUALLY", "color": Colors.red, "progress": 0.7},
    {"label": "SELF CARE", "color": Colors.orange, "progress": 0.5},
    {"label": "PRODUCTIVITY", "color": Colors.yellow, "progress": 0.8},
    {"label": "FINANCES", "color": Colors.green, "progress": 0.3},
    {"label": "SOCIAL LIFE", "color": Colors.pink, "progress": 0.6},
    {"label": "CREATIVITY", "color": Colors.purple, "progress": 0.9},
    {"label": "HEALTH & FITNESS", "color": Colors.blue, "progress": 0.4},
    {"label": "GROWTH & LEARNING", "color": Colors.teal, "progress": 0.65},
  ];

  StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('EEE, MMM d').format(DateTime.now());

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'asset/images/statistics screen.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.grid_view, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      today.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Times New Romance',
                      ),
                    ),
                    const Spacer(),
                    Image.asset('asset/images/foxlogo.png', height: 40),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'PERSONAL (WEEKLY)',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Times New Romance',
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.2,
                    children:
                        categoryData.map((category) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => TaskProgressScreen(
                                        title: category["label"],
                                        imagePath:
                                            "asset/images/${category["label"].toLowerCase().replaceAll(' ', '')}.png",
                                        initialTasks: [],
                                        tasks: null,
                                      ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: RotatedBox(
                                    quarterTurns: -1,
                                    child: LinearProgressIndicator(
                                      value: category["progress"],
                                      color: category["color"],
                                      // ignore: deprecated_member_use
                                      backgroundColor: Colors.white.withOpacity(
                                        0.3,
                                      ),
                                      minHeight: 10,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  category["label"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
            _buildNavIcon(Icons.home, () => Navigator.pop(context)),
            _buildNavIcon(Icons.message, () {}),
            _buildNavIcon(Icons.calendar_today, () {}),
            _buildNavIcon(Icons.bar_chart, () {}), // Already on this screen
            _buildNavIcon(Icons.arrow_forward, () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}
