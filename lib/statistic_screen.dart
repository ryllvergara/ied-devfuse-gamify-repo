// lib/statistic.screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'task_progress_screen.dart'; // Make sure this file exists
import 'progress_data.dart'; // Import ProgressData class
import 'bottom_nav_bar.dart'; // Import your BottomNavBar

class StatisticScreen extends StatelessWidget {
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

  StatisticScreen({super.key});

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
                    children: categoryData.map((category) {
                      return GestureDetector(
                        onTap: () {
                          ProgressData progressData = ProgressData(progress: null);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskProgressScreen(
                                title: category["label"],
                                imagePath:
                                    "asset/images/${category["label"].toLowerCase().replaceAll(' ', '')}.png",
                                initialTasks: [],
                                tasks: null,
                                progressData: progressData,
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
                                  backgroundColor: Colors.white.withOpacity(0.3),
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
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }
}
