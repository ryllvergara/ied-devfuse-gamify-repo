import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // Controllers to handle text input for new password and confirmation
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Track if the password update process is ongoing to disable button and show loading indicator
  bool _isProcessing = false;

  // Method to validate inputs and update password via Supabase
  Future<void> _updatePassword() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Check if passwords match
    if (password != confirmPassword) {
      _showSnackBar("Passwords do not match.", isError: true);
      return;
    }

    // Check for minimum password length
    if (password.length < 6) {
      _showSnackBar("Password must be at least 6 characters long.", isError: true);
      return;
    }

    setState(() => _isProcessing = true);

    try {
      // Attempt to update the user password with Supabase
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: password),
      );

      // Clear input fields after successful update
      _passwordController.clear();
      _confirmPasswordController.clear();

      _showSnackBar("Password updated successfully!");

      // Optional: Navigate to login screen after success
      // Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      // Handle errors, simplify error message if possible
      final errorMessage = e is AuthException ? e.message : 'Unknown error occurred';
      _showSnackBar("Failed to update password: $errorMessage", isError: true);
    }

    setState(() => _isProcessing = false);
  }

  // Helper method to show SnackBar messages
  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return; // Ensure widget is still mounted before showing SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set New Password")),
      // Wrap in SingleChildScrollView for smaller screens / keyboard handling
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input for new password
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "New Password"),
            ),
            const SizedBox(height: 16),
            // Input for confirm password
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Confirm Password"),
            ),
            const SizedBox(height: 24),
            // Button to trigger password update
            ElevatedButton(
              onPressed: _isProcessing ? null : _updatePassword,
              child: _isProcessing
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Text("Update Password"),
            ),
          ],
        ),
      ),
    );
  }
}
