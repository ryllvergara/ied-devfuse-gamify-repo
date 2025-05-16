import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient supabaseClient;

  // Constructor to inject the Supabase client
  AuthRepository({required this.supabaseClient});

  /// Signs up a new user with email, password, and username.
  /// Also inserts a profile row into the 'users' table.
  Future<void> signUp(String email, String password, String username) async {
    try {
      // Create the user with email & password
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      // If no user returned, something went wrong
      if (response.user == null) {
        throw Exception('Sign-up failed. Please try again.');
      }

      // Insert additional user info into your custom 'users' table
      final insertResponse = await supabaseClient.from('users').insert({
        'id': response.user!.id,
        'email': email,
        'username': username,
      });

      // Check for any insertion errors
      if (insertResponse.error != null) {
        // Cannot delete users from client in Supabase 2.x+ (admin only)
        // Consider logging this issue or alerting admins via a backend
        throw Exception(
            'Failed to save user profile: ${insertResponse.error!.message}');
      }
    } catch (e) {
      // Re-throw error to allow UI to handle it
      rethrow;
    }
  }

  /// Logs in an existing user using email and password.
  Future<void> signIn(String email, String password) async {
    try {
      // Authenticate using email and password
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // If login fails, throw an error
      if (response.user == null) {
        throw Exception('Login failed. Please check your credentials.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
