import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para sa formatting sang date
import 'package:hive/hive.dart'; // Storage para sa local data
import 'task_path.dart' as task_model; // Gamiton ta ini para sa task model nga gindefine ta

// Amo ni ang screen para magdugang sang task
class TaskAddScreen extends StatefulWidget {
  final String categoryKey; // Key nga gamiton ta para ma-save sa correct nga category

  const TaskAddScreen({super.key, required this.categoryKey});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  // Initial values sang mga fields
  String _selectedDifficulty = 'Easy'; // Default difficulty
  final TextEditingController _titleController = TextEditingController(); // Para sa title input
  final TextEditingController _notesController = TextEditingController(); // Para sa notes input
  DateTime _startDate = DateTime.now(); // Default start date is subong nga adlaw
  final Set<String> _selectedDays = {}; // Days nga gina-select sang user

  // XP values kada difficulty
  final Map<String, int> difficultyXP = {'Easy': 10, 'Medium': 20, 'Hard': 30};

  // Para magpili sang start date
  void _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _startDate = picked); // Kung may napili, i-set ta siya
  }

  // Button para sa difficulty (Easy, Medium, Hard)
  Widget _buildDifficultyButton(String label, int stars) {
    final isSelected = _selectedDifficulty == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedDifficulty = label), // Set difficulty kung gin-tap
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange.shade100 : Colors.white70,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(stars, (index) => const Icon(Icons.star, color: Colors.orange)),
            ),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  // Button para pili-on ang weekdays (S, M, T, etc.)
  Widget _buildWeekdayButton(String day) {
    final isSelected = _selectedDays.contains(day);
    return GestureDetector(
      onTap: () => setState(() => isSelected ? _selectedDays.remove(day) : _selectedDays.add(day)),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  // Function para i-save ang task
  void _saveTask() async {
    // Kung wala title, indi magpadayon
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title.'), backgroundColor: Colors.redAccent),
      );
      return;
    }

    // Create new task object
    final newTask = task_model.TaskItemData(
      _titleController.text.trim(),
      difficultyXP[_selectedDifficulty]!,
      notes: _notesController.text.trim(),
      scheduled: _startDate.toIso8601String(),
      repeat: null,
      every: null,
      days: _selectedDays.toList(),
    );

    // Save to Hive box based sa category key
    final taskBox = await Hive.openBox<task_model.TaskItemData>(widget.categoryKey);
    await taskBox.add(newTask);

    if (!mounted) return;
    Navigator.pop(context, newTask); // Balik sa previous screen kag dal-on ang new task
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Indi na magmove ang background kung mag pop-up ang keyboard
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true, // Para ang background image ara gid sa likod
      body: Stack(
        children: [
          // Background image nga fullscreen
          Positioned.fill(
            child: Image.asset('asset/images/task screen.png', fit: BoxFit.cover),
          ),
          // SafeArea para indi magbangga sa mga system UI (notch, status bar, etc.)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row: back button kag title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                      ),
                      const Text(
                        'ADD NEW TASK',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Input para sa task title
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Task Title',
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Input para sa notes
                  TextField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Notes',
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Difficulty Section
                  const Text('DIFFICULTY', style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDifficultyButton('Easy', 1),
                      _buildDifficultyButton('Medium', 3),
                      _buildDifficultyButton('Hard', 5),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Scheduling Section
                  const Text('SCHEDULING', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  // Start date picker
                  GestureDetector(
                    onTap: _pickStartDate,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Start Date: ${DateFormat.yMMMd().format(_startDate)}'),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Weekday buttons
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 6,
                    runSpacing: 6,
                    children: ['S', 'M', 'T', 'W', 'Th', 'F', 'Su'].map(_buildWeekdayButton).toList(),
                  ),

                  // Spacer kag Save button sa ubos
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      onPressed: _saveTask,
                      child: const Text('SAVE', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
