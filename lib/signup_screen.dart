import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
<<<<<<< HEAD
import 'auth_repository.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool acceptedTerms = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  final _authRepository = AuthRepository(supabaseClient: Supabase.instance.client);
  bool _isLoading = false;
=======
import 'profile_selection_screen.dart'; // Replace with your actual path

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isPasswordVisible = false;
>>>>>>> 1bbb1afef12affa6dee4b187b139e5b2ea117905

  final Color darkOrange = const Color(0xFFB44A0A);
  final Color lightOrange = const Color(0xFFE07B3A);
  final Color inputBgColor = const Color(0xFFF4C9A7);
  final Color placeholderColor = const Color(0xFF7A5A44);

<<<<<<< HEAD
  // Function to handle signup
  void _signup() async {
    setState(() => _isLoading = true);
    try {
      await _authRepository.signUp(
        _emailController.text, 
        _passwordController.text,
        _usernameController.text, // Username from the controller
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Signup successful! Check your email.")));
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup failed: ${e.toString()}")));
    } finally {
      setState(() => _isLoading = false);
=======
  Future<void> _handleSignup() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();

    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
      );

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup successful! Verify your email.")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const CharacterSelectionScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup failed: ${e.toString()}")),
      );
>>>>>>> 1bbb1afef12affa6dee4b187b139e5b2ea117905
    }
  }

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
                  Row(
                    children: [
                      Image.asset(
                        'asset/images/foxlogo.png',
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(width: 16),
<<<<<<< HEAD
                      AuthButtons(
                        isLogin: false,
                        onLoginTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        onSignupTap: () {},
=======
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                                  child: Container(
                                    color: lightOrange,
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: const Text('LOGIN'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: darkOrange,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: const Text('SIGNUP'),
                                ),
                              ),
                            ],
                          ),
                        ),
>>>>>>> 1bbb1afef12affa6dee4b187b139e5b2ea117905
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
<<<<<<< HEAD
                    'Fill up the form to create an account',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Times New Romance',
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Username field
                  _buildTextField(
                    controller: _usernameController,
                    hintText: 'Username',
                    bgColor: inputBgColor,
                    placeholderColor: placeholderColor,
                  ),
                  const SizedBox(height: 14),
                  // Email field
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    bgColor: inputBgColor,
                    placeholderColor: placeholderColor,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),
                  // Password field
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
                  const SizedBox(height: 14),
                  // Confirm Password field
                  _buildTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    bgColor: inputBgColor,
                    placeholderColor: placeholderColor,
                    obscureText: !_isConfirmPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: placeholderColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Sign Up button
=======
                    'Create your account',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 14),
                  _buildTextField(
                    controller: _usernameController,
                    hintText: 'Username',
                  ),
                  const SizedBox(height: 14),
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 14),
                  _buildTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: placeholderColor,
                      ),
                      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                    ),
                  ),
                  const SizedBox(height: 24),
>>>>>>> 1bbb1afef12affa6dee4b187b139e5b2ea117905
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
<<<<<<< HEAD
                      onPressed: _signup,
=======
                      onPressed: _handleSignup,
>>>>>>> 1bbb1afef12affa6dee4b187b139e5b2ea117905
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
<<<<<<< HEAD
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontFamily: 'Times New Romance',
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Redirect to Login
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        'Already have an account? Login',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: 'Times New Romance',
                        ),
=======
>>>>>>> 1bbb1afef12affa6dee4b187b139e5b2ea117905
                      ),
                      child: const Text('SIGNUP'),
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
    bool obscureText = false,
<<<<<<< HEAD
    TextInputType keyboardType = TextInputType.text,
=======
>>>>>>> 1bbb1afef12affa6dee4b187b139e5b2ea117905
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: inputBgColor,
        hintText: hintText,
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
<<<<<<< HEAD
      ),
    );
  }
}

class AuthButtons extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onLoginTap;
  final VoidCallback onSignupTap;

  const AuthButtons({
    super.key,
    required this.isLogin,
    required this.onLoginTap,
    required this.onSignupTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color darkOrange = const Color(0xFFB44A0A);
    final Color lightOrange = const Color(0xFFE07B3A);

    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onLoginTap,
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
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onSignupTap,
                child: Container(
                  color: isLogin ? lightOrange : darkOrange,
                  alignment: Alignment.center,
                  height: 40,
                  child: const Text(
                    'SIGNUP',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
=======
>>>>>>> 1bbb1afef12affa6dee4b187b139e5b2ea117905
      ),
    );
  }
}
