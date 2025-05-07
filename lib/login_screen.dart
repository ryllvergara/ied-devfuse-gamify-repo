import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_selection_screen.dart';  // Import ProfileSelectionScreen

class LoginScreen extends StatefulWidget {
  final String mode; // 'login' or 'signup'

  const LoginScreen({
    super.key,
    required this.mode,
  });

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  final Color darkOrange = const Color(0xFFB44A0A);
  final Color lightOrange = const Color(0xFFE07B3A);
  final Color inputBgColor = const Color(0xFFF4C9A7);
  final Color placeholderColor = const Color(0xFF7A5A44);

  Future<void> _handleAuth() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Please enter both email and password.", isError: true);
      return;
    }

    try {
      final auth = Supabase.instance.client.auth;
      if (widget.mode == 'login') {
        final response =
            await auth.signInWithPassword(email: email, password: password);
        if (response.user == null) {
          _showSnackBar("Login failed. Check your credentials.", isError: true);
          return;
        }
      } else {
        final response =
            await auth.signUp(email: email, password: password);
        if (response.user == null) {
          _showSnackBar("Signup failed. Try again.", isError: true);
          return;
        }
      }

      // Navigate to ProfileSelectionScreen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const ProfileSelectionScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar("Authentication failed. ${e.toString()}", isError: true);
      }
    }
  }

  Future<void> _handleForgotPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showSnackBar("Please enter your email to reset your password.", isError: true);
      return;
    }

    try {
      final auth = Supabase.instance.client.auth;
      await auth.resetPasswordForEmail(email);
      _showSnackBar("Password reset email sent! Check your inbox.");
    } catch (e) {
      _showSnackBar("Error: ${e.toString()}", isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.redAccent : Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = widget.mode == 'login';

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo + Tabs
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'asset/images/foxlogo.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (!isLogin) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/login',
                                      );
                                    }
                                  },
                                  child: Container(
                                    color: isLogin ? darkOrange : lightOrange,
                                    alignment: Alignment.center,
                                    height: 40,
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontFamily: 'Times New Romance',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (isLogin) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/signup',
                                      );
                                    }
                                  },
                                  child: Container(
                                    color: !isLogin ? darkOrange : lightOrange,
                                    alignment: Alignment.center,
                                    height: 40,
                                    child: const Text(
                                      'SIGNUP',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontFamily: 'Times New Romance',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    isLogin
                        ? 'Enter your credentials to login'
                        : 'Fill in the form to create an account',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Times New Romance',
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    bgColor: inputBgColor,
                    placeholderColor: placeholderColor,
                  ),
                  const SizedBox(height: 14),
                  _buildTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    bgColor: inputBgColor,
                    placeholderColor: placeholderColor,
                    obscureText: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: placeholderColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _handleAuth,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        isLogin ? 'LOGIN' : 'SIGN UP',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: 'Times New Romance',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Forgot password button
                  if (isLogin)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _handleForgotPassword,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: 'Times New Romance',
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          isLogin ? '/signup' : '/login',
                        );
                      },
                      child: Text(
                        isLogin
                            ? 'Don\'t have an account? Sign up'
                            : 'Already have an account? Log in',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'Times New Romance',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required Color bgColor,
    required Color placeholderColor,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: bgColor,
        hintText: hintText,
        hintStyle: TextStyle(
          color: placeholderColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: lightOrange, width: 2),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
