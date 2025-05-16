import 'package:flutter/material.dart';
import 'package:gamify/progress_data.dart';
import 'package:intl/intl.dart';

import 'bottom_nav_bar.dart';
import 'character_selection_screen.dart';
import 'task_progress_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('EEE, MMM d').format(DateTime.now());

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/images/home screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top: Logo + Date
                Row(
                  children: [
                    Image.asset(
                      'asset/images/glogo.png',
                      height: 30,
                    ), // Your logo image
                    const SizedBox(width: 10),
                    Text(
                      today.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Romance',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Warrior Card
                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CharacterSelectionScreen(),
                        ),
                      ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.brown, width: 4),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            'images/characters/1.jpeg',
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'WARRIORS CARD',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Times New Romance',
                              ),
                            ),
                            Text('Name: Mayara'),
                            Text('Specialty: Necromancer'),
                            Text(
                              'Rank: S-rank',
                              style: TextStyle(
                                color: Color(0xFFEAA51A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Toggle bar
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFCD7F32),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: const Text(
                        'TODAY',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Times New Romance',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.brown[400],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'ALL',
                        style: TextStyle(
                          fontFamily: 'Times New Romance',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Task list
                Expanded(
                  child: ListView(
                    children: const [
                      TaskItem(
                        category: 'HEALTH',
                        task: 'SLEEP BY 10-11 PM',
                        xp: '80 XP',
                      ),
                      TaskItem(
                        category: 'SCHOOL',
                        task: 'COMPLETE TODAY\'S HOMEWORK',
                        xp: '10 XP',
                      ),
                      TaskItem(
                        category: 'LIFE',
                        task: 'WRITE DOWN 3 THINGS YOU\'RE GRATEFUL FOR',
                        xp: '10 XP',
                      ),
                      TaskItem(
                        category: 'FAITH',
                        task: 'PRAY CONSISTENTLY',
                        xp: '10 XP',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String category;
  final String task;
  final String xp;

  const TaskItem({
    super.key,
    required this.category,
    required this.task,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the TaskProgressScreen, passing the category as an argument
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => TaskProgressScreen(
                  title: category,
                  imagePath:
                      'asset/images/task_image.png', // Provide the image path here
                  initialTasks: [], // Provide initial tasks here if needed
                  tasks: [], // Pass the tasks data here
                  progressData: ProgressData(
                    progress: null,
                  ), // Adjust as per your app's structure
                  category: category, // Ensure this is passed correctly
                ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            const Icon(Icons.edit, color: Colors.orangeAccent, size: 24),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Times New Romance',
                    color: Colors.black,
                  ),
                ),
                Text(
                  task,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Times New Romance',
                    color: Colors.black,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    xp,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
