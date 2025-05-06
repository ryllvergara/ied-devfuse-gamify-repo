import 'package:flutter/material.dart';
import 'task_add_screen.dart';
import 'task_path.dart' as task_model;

class TaskProgressScreen extends StatefulWidget {
  final String title;
  final String imagePath;
  final List<task_model.TaskItemData> initialTasks;

  const TaskProgressScreen({
    super.key,
    required this.title,
    required this.imagePath,
    required this.initialTasks,
    required tasks,
  });

  @override
  State<TaskProgressScreen> createState() => _TaskProgressScreenState();
}

class _TaskProgressScreenState extends State<TaskProgressScreen> {
  late List<task_model.TaskItemData> tasks;

  @override
  void initState() {
    super.initState();
    tasks = List<task_model.TaskItemData>.from(widget.initialTasks);
  }

  @override
  Widget build(BuildContext context) {
    final totalXP = tasks.fold<int>(0, (sum, item) => sum + item.xp);
    final completedXP =
        tasks.where((item) => item.done).fold<int>(0, (sum, item) => sum + item.xp);
    final progress = totalXP == 0 ? 0.0 : completedXP / totalXP;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/images/task screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context, tasks),
                      child: Image.asset('asset/images/backbutton.png', height: 30),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TaskAddScreen(categoryKey: widget.title.toLowerCase()),
                          ),
                        ).then((newTask) {
                          if (newTask != null && newTask is task_model.TaskItemData) {
                            setState(() {
                              tasks.add(newTask);
                            });
                          }
                        });
                      },
                      child: Image.asset('asset/images/addbutton.png', height: 40),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Image.asset(widget.imagePath, height: 120)),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: const TextStyle(
                  fontFamily: 'Times New Romance',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          'XP',
                          style: TextStyle(
                            fontFamily: 'Times New Romance',
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: Color.fromARGB(255, 100, 31, 6),
                      valueColor: AlwaysStoppedAnimation(Color(0xFFEF500D)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '$completedXP / $totalXP',
                        style: TextStyle(
                          fontFamily: 'Times New Romance',
                          fontSize: 14,
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return GestureDetector(
                      onTap: () => _showTaskDetails(context, task),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  task.done = !task.done;
                                });
                              },
                              child: Image.asset(
                                task.done
                                    ? 'asset/images/sword.png'
                                    : 'asset/images/circle.png',
                                height: 28,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 50,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEF500D),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.brown, width: 2),
                                  ),
                                ),
                                Text(
                                  '${task.xp} XP',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  task.task,
                                  style: TextStyle(
                                    fontFamily: 'Times New Romance',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: task.done ? Colors.grey[700] : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTaskDetails(BuildContext context, task_model.TaskItemData task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task.task),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Notes: ${task.notes ?? 'None'}'),
              Text('Difficulty: ${'⭐' * (task.xp ~/ 10)}'),
              Text('Scheduled: ${task.scheduled ?? 'None'}'),
              Text('Repeat Days: ${task.days?.join(", ") ?? 'None'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.remove(task);
                });
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

