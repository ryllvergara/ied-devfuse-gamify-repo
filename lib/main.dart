import 'package:flutter/material.dart';
import 'package:gamify/character_selection_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'task_path.dart';
import 'deep_link_handler.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'splash_screen.dart';
import 'verify_email_screen.dart';
import 'task_selection_screen.dart'; // Import the task screen after login or signup

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskItemDataAdapter());
  await Hive.openBox<List>('taskBox');

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://apcnhblhqlcletztzakq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFwY25oYmxocWxjbGV0enR6YWtxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY1MzU2NDksImV4cCI6MjA2MjExMTY0OX0.mfSg5CfOO012wzR1FlXzDRtrHPAu3uF45ZgSqbMJCd0',
  );

  runApp(const Gamify());
}

class Gamify extends StatelessWidget {
  const Gamify({super.key});

  @override
  Widget build(BuildContext context) {
    return DeepLinkHandler(
      child: MaterialApp(
        title: 'Gamify',
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash', // Default route to splash screen
        routes: {
          '/splash': (_) => const SplashScreen(),
          '/login': (_) => const LoginScreen(mode: 'login'),
          '/signup': (_) => const SignupScreen(),
          '/profile': (_) => CharacterSelectionScreen(),
          '/verify-email': (_) => VerifyEmailScreen(),
          '/tasks': (_) => const TaskSelectionScreen(), // Add Task Selection screen after login
        },
      ),
    );
  }
}
