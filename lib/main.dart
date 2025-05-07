import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'task_path.dart';
import 'deep_link_handler.dart';
import 'login_screen.dart';
<<<<<<< HEAD
import 'profile_selection_screen.dart';
import 'signup_screen.dart';
import 'splash_screen.dart';
import 'verify_email_screen.dart';

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

=======
import 'signup_screen.dart';
import 'splash_screen.dart';
import 'supabase_config.dart';
import 'reward_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseApiKey);
>>>>>>> 1bbb1afef12affa6dee4b187b139e5b2ea117905
  runApp(const Gamify());
}

class Gamify extends StatelessWidget {
  const Gamify({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return DeepLinkHandler(
      child: MaterialApp(
        title: 'Gamify',
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (_) => const SplashScreen(),
          '/login': (_) => const LoginScreen(mode: 'login'),
          '/signup': (_) => const SignupScreen(),
          '/profile': (_) => const ProfileSelectionScreen(),
          '/verify-email': (_) => const VerifyEmailScreen(),
        },
      ),
=======
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/login':
            return MaterialPageRoute(
              builder:
                  (_) => const LoginPage(mode: 'login', selectedPage: null),
            );
          case '/signup':
            return MaterialPageRoute(
              builder:
                  (_) => const LoginPage(mode: 'signup', selectedPage: null),
            );
          case '/rewards':
            return MaterialPageRoute(
              builder: (_) => const RewardApp(),// New Reward Screen
            );
          default:
            return MaterialPageRoute(
              builder:
                  (_) => const Scaffold(
                    body: Center(child: Text('Page not found')),
                  ),
            );
        }
      },
>>>>>>> 1bbb1afef12affa6dee4b187b139e5b2ea117905
    );
  }
}
