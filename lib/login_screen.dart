import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Amo ni ang login screen nga may form para sa email kag password
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required String mode}); // May mode siya pero indi ni ginagamit subong

  @override
  // Gamit naton ni para ma-control ang state sang screen
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers para makuha ang sulod sang text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;

  bool _isPasswordVisible = false; // Para makita kag taguon ang password
  bool _isLoading = false; // Indicator kung nagaload ang login

  // Color palette naton para may consistent nga design
  final Color darkOrange = const Color(0xFFB44A0A);
  final Color lightOrange = const Color(0xFFE07B3A);
  final Color inputBgColor = const Color(0xFFF4C9A7);
  final Color placeholderColor = const Color(0xFF7A5A44);

  // Ginalimpyuhan ang controllers kung ginalikawan na ang screen
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Amo ni ang login function gamit ang Supabase
  Future<void> _login() async {
    setState(() {
      _isLoading = true; // I-enable ang loading mode
    });

    try {
      // Ginatry naton mag-login gamit ang email kag password
      final response = await _supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final session = response.session;

      // Kun successful ang login, paadto ta siya sa character selection screen
      if (session != null) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/characterselectionscreen');
        }
      } else {
        // Kung indi successful, ipakita ta ang error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed. Please try again.')),
          );
        }
      }
    } on AuthException catch (e) {
      // Kung may error halin kay Supabase, ipakita man naton
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } catch (error) {
      // Para sa iban nga error, ipakita lang man
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $error')),
        );
      }
    } finally {
      // I-off ang loading state kung tapos na
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Function para makabuild sang input fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: inputBgColor, // Background color sang input
        hintText: hintText, // Placeholder
        hintStyle: TextStyle(color: placeholderColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightOrange, width: 2),
        ),
        suffixIcon: suffixIcon, // Optional icon (like show/hide password)
      ),
    );
  }

  // Amo ni ang itsura sang aton screen
  @override
  Widget build(BuildContext context) {
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
                  // Logo kag login/signup buttons
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'asset/images/foxlogo.png',
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Row(
                            children: [
                              // LOGIN button (active)
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {}, // Ara na kita sa login subong
                                  child: Container(
                                    color: darkOrange,
                                    alignment: Alignment.center,
                                    height: 40,
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // SIGNUP button
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/signup',
                                    );
                                  },
                                  child: Container(
                                    color: lightOrange,
                                    alignment: Alignment.center,
                                    height: 40,
                                    child: const Text(
                                      'SIGNUP',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
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

                  // Text instruction
                  const Text(
                    'Enter your credentials to login',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 14),

                  // Email input
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 14),

                  // Password input with show/hide icon
                  _buildTextField(
                    controller: _passwordController,
                    hintText: 'Password',
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

                  // LOGIN button
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            )
                          : const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Link to Signup screen
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Do not have an account? Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Forgot Password link
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.black,
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
}
