// lib/reset_password_screen.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // Controllers for both password fields
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // To show a loading spinner while updating password
  bool _isProcessing = false;

  // Called when user taps the button
  Future<void> _updatePassword() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Check if both fields match
    if (password != confirmPassword) {
      _showSnackBar("Passwords do not match!", isError: true);
      return;
    }

    // Password should be at least 6 characters long
    if (password.length < 6) {
      _showSnackBar("Password should be at least 6 characters.", isError: true);
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      // Try updating the password with Supabase
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: password),
      );

      // Clear text fields after success
      _passwordController.clear();
      _confirmPasswordController.clear();

      _showSnackBar("Password updated successfully!");

      // You can navigate to login screen if you want
      // Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      final errorMsg = e is AuthException ? e.message : "Something went wrong.";
      _showSnackBar("Error: $errorMsg", isError: true);
    }

    setState(() {
      _isProcessing = false;
    });
  }

  // For showing error/success messages
  void _showSnackBar(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set New Password")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // New password field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "New Password"),
            ),
            const SizedBox(height: 16),
            // Confirm password field
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Confirm Password"),
            ),
            const SizedBox(height: 24),
            // Update button
            ElevatedButton(
              onPressed: _isProcessing ? null : _updatePassword,
              child: _isProcessing
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text("Update Password"),
            ),
          ],
        ),
      ),
    );
  }
}
