import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'character_selection_screen.dart';
import 'deep_link_handler.dart';
import 'forget_password.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'new_password.dart';
import 'signup_screen.dart';
import 'splash_screen.dart';
import 'task_path.dart';
import 'task_selection_screen.dart';
import 'verify_email_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local task storage
  await Hive.initFlutter();
  Hive.registerAdapter(TaskItemDataAdapter());
  await Hive.openBox<List>('taskBox');

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://apcnhblhqlcletztzakq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFwY25oYmxocWxjbGV0enR6YWtxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY1MzU2NDksImV4cCI6MjA2MjExMTY0OX0.mfSg5CfOO012wzR1FlXzDRtrHPAu3uF45ZgSqbMJCd0',
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => CharacterProvider(),
      child: const Gamify(),
    ),
  );
}

class Gamify extends StatelessWidget {
  const Gamify({super.key});

  Future<String> _determineInitialRoute() async {
    final session = Supabase.instance.client.auth.currentSession;
    final user = Supabase.instance.client.auth.currentUser;

    if (session != null && user != null) {
      final action = user.appMetadata['action'];
      if (action == 'recovery') {
        return '/new-password';
      }
      return '/characterselectionscreen'; // or '/home' if user is already set up
    }

    return '/splash';
  }

  @override
  Widget build(BuildContext context) {
    return DeepLinkHandler(
      child: FutureBuilder<String>(
        future: _determineInitialRoute(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator())),
            );
          }

          return MaterialApp(
            title: 'Gamify',
            debugShowCheckedModeBanner: false,
            initialRoute: snapshot.data,
            routes: {
              '/splash': (_) => const SplashScreen(),
              '/login':
                  (_) => const LoginScreen(mode: '/characterselectionscreen'),
              '/signup': (_) => const SignupScreen(),
              '/characterselectionscreen':
                  (_) => const CharacterSelectionScreen(),
              '/home': (_) => const HomeScreen(),
              '/verify-email': (_) => const VerifyEmailScreen(),
              '/tasks': (_) => const TaskSelectionScreen(),
              '/forgot-password': (_) => const ForgotPasswordScreen(),
              '/new-password': (_) => const NewPasswordScreen(),
            },
          );
        },
      ),
    );
  }
}
