import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'bottom_nav_bar.dart';
import 'reward_screen.dart';
import 'statistic_screen.dart';
import 'task_selection_screen.dart';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warriors Card',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'TimesNewRoman'),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/tasks': (context) => const TaskSelectionScreen(),
        '/stats': (context) => StatisticScreen(),
        '/rewards': (context) => const RewardScreen(),
      },
    );
  }


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String _ = DateFormat('EEE, MMM d').format(DateTime.now());

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/images/home screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '9:41',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 300,
                  height: 120,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('asset/images/info card.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/characters/1.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'WARRIORS CARD',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Name: mayara',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Times New Romance',
                              ),
                            ),
                            Text(
                              'Specialty: necromancer',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Times New Romance',
                              ),
                            ),
                            Text(
                              'Rank: E-rank',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEAA51A),
                                fontFamily: 'Times New Romance',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFCD7F32),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  'TODAY',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Times New Romance',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    TaskItem(
                      category: 'HEALTH',
                      task: 'SLEEP BY 10-11 PM',
                      xp: '80 XP',

                    ),
                    const Divider(
                      color: Colors.white70,
                      thickness: 1,
                      height: 20,
                    ),
                    TaskItem(
                      category: 'SCHOOL',
                      task: 'COMPLETE TODAY\'S HOMEWORK',
                      xp: '10 XP',
                    ),
                    const Divider(
                      color: Colors.white70,
                      thickness: 1,
                      height: 20,
                    ),
                    TaskItem(
                      category: 'LIFE',
                      task: 'WRITE DOWN 3 THINGS YOU\'RE GRATEFUL FOR',
                      xp: '10 XP',
                    ),
                    const Divider(
                      color: Colors.white70,
                      thickness: 1,
                      height: 20,
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF3B3B3B),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(Icons.check_circle_outline, color: const Color.fromARGB(255, 208, 74, 3), size: 30),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  task,
                  style: const TextStyle(fontSize: 10, color: Color.fromARGB(255, 241, 235, 235)),
                ),
                Text(
                  xp,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
