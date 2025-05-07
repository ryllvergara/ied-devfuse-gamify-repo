import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient supabaseClient;

  AuthRepository({required this.supabaseClient});

  Future<void> signUp(String email, String password, String username) async {
    final response = await supabaseClient.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Sign-up failed. Please try again.');
    }

    // Optionally save user profile data
    await supabaseClient.from('users').insert({
      'id': response.user!.id,
      'email': email,
      'username': username,
    });
  }

  Future<void> signIn(String email, String password) async {
    final response = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Login failed. Please check your credentials.');
    }
  }
}
