// lib/task_selection_screen.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'task_path.dart';
import 'task_progress_screen.dart';
import 'bottom_nav_bar.dart'; // Import the reusable bottom nav bar
import 'progress_data.dart'; // Import ProgressData class

class TaskSelectionScreen extends StatefulWidget {
  const TaskSelectionScreen({super.key});

  @override
  TaskSelectionScreenState createState() => TaskSelectionScreenState();
}

class TaskSelectionScreenState extends State<TaskSelectionScreen> {
  final Box taskBox = Hive.box<List>('taskBox');

  final List<Map<String, dynamic>> taskCategories = [
    {
      'title': 'Health and Fitness',
      'image': 'asset/images/healthandfitness.png',
    },
    {
      'title': 'Growth and Learning',
      'image': 'asset/images/growthandlearning.png',
    },
    {'title': 'Productivity', 'image': 'asset/images/productivity.png'},
    {'title': 'Finances', 'image': 'asset/images/finances.png'},
    {'title': 'Social Life', 'image': 'asset/images/social life.png'},
    {'title': 'Creativity', 'image': 'asset/images/creativity.png'},
    {'title': 'Self Care', 'image': 'asset/images/self care.png'},
    {'title': 'Spiritual', 'image': 'asset/images/spirituality.png'},
  ];

  List<TaskItemData> _getTasksForCategory(String title) {
    final tasks = taskBox.get(title, defaultValue: <TaskItemData>[])!;
    return tasks.cast<TaskItemData>();
  }

  Future<void> _saveTasksForCategory(String title, List<TaskItemData> tasks) async {
    await taskBox.put(title, tasks);
  }

  void _navigateAndAddTask(BuildContext context, Map<String, dynamic> category) async {
    String title = category['title'];
    String image = category['image'];

    List<TaskItemData> currentTasks = _getTasksForCategory(title);

    // Create a default ProgressData object if progressData is null
    ProgressData progressData = ProgressData(progress: 0.0); // Default value

    final updatedTasks = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskProgressScreen(
          title: title,
          imagePath: image,
          initialTasks: currentTasks,
          tasks: null,
          progressData: progressData,  // Pass the valid ProgressData
        ),
      ),
    );

    if (updatedTasks != null) {
      await _saveTasksForCategory(title, updatedTasks);
    }
  }

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('EEE, MMM d').format(DateTime.now());

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'asset/images/task screen.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.grid_view, color: Colors.white, size: 36),
                        const SizedBox(width: 10),
                        Text(
                          today,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Romance',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Image.asset('asset/images/foxlogo.png', height: 60),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.9,
                    children: taskCategories.map((category) {
                      return Container(
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              category['title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Times New Romance',
                                color: Colors.brown,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Image.asset(
                                category['image'],
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                _navigateAndAddTask(context, category);
                              },
                              child: Container(
                                height: 30,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: const Color.fromARGB(255, 184, 73, 25).withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Progress Info',
                                    style: TextStyle(
                                      fontFamily: 'Times New Romance',
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
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
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }
}
