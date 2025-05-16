import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'character_selection_screen.dart';
import 'deep_link_handler.dart';
import 'forget_password.dart';
import 'home_screen.dart'; // Gamiton ni nga file para sa HomeScreen
import 'login_screen.dart';
import 'new_password.dart';
import 'signup_screen.dart';
import 'splash_screen.dart';
import 'task_path.dart';
import 'task_selection_screen.dart';
import 'verify_email_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Gina-setup naton ang Hive para ma-save ang mga tasks maski offline
  await Hive.initFlutter();
  Hive.registerAdapter(TaskItemDataAdapter());
  await Hive.openBox<List>('taskBox'); // Box nga magtago sang mga task list

  // Setup man naton ang Supabase para sa login kag signup nga features
  await Supabase.initialize(
    url: 'https://apcnhblhqlcletztzakq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFwY25oYmxocWxjbGV0enR6YWtxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY1MzU2NDksImV4cCI6MjA2MjExMTY0OX0.mfSg5CfOO012wzR1FlXzDRtrHPAu3uF45ZgSqbMJCd0',
  );

  // Amo ni ang pagsugod sang app, gamit ang Provider para sa character nga data
  runApp(
    ChangeNotifierProvider(
      create: (_) => CharacterProvider(),
      child: const Gamify(),
    ),
  );
}

class Gamify extends StatelessWidget {
  const Gamify({super.key});

  @override
  Widget build(BuildContext context) {
    return DeepLinkHandler(
      child: MaterialApp(
        title: 'Gamify',
        debugShowCheckedModeBanner: false, // Ginatago ang debug banner sa taas
        initialRoute: _determineInitialRoute(), // Una nga screen nga makita
        routes: {
          '/splash': (_) => const SplashScreen(), // Loading screen anay
          '/login': (_) => const LoginScreen(mode: '/characterselectionscreen'), // Login nga part
          '/signup': (_) => const SignupScreen(), // Signup para sa mga new user
          '/characterselectionscreen': (_) => const CharacterSelectionScreen(), // Pili ka character mo diri
          '/home': (_) => const HomeScreen(), // Home screen nga may mga tasks
          '/verify-email': (_) => const VerifyEmailScreen(), // Email verification nga part
          '/tasks': (_) => const TaskSelectionScreen(), // Pilian sang task categories
          '/forgot-password': (_) => const ForgotPasswordScreen(), // Kon nalimtan ang password
          '/new-password': (_) => const NewPasswordScreen(), // Para mag-set sang new password
        },
      ),
    );
  }

  // Amo ni ang logic kung diin nga screen kita paadto base sa session status
  String _determineInitialRoute() {
    final session = Supabase.instance.client.auth.currentSession;
    final user = Supabase.instance.client.auth.currentUser;

    if (session != null && user != null) {
      final action = user.appMetadata['action'];
      if (action == 'recovery') {
        return '/new-password'; // Kun nag-click siya sang reset password sa email
      }
    }
    return '/splash'; // Default screen kung wala session
  }
}
