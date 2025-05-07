import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _fadeNavigate(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('asset/images/introbgc.jpg', fit: BoxFit.cover),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('asset/images/glogo.png', width: 300, height: 200),
              ElevatedButton(
                onPressed: () {
<<<<<<< HEAD
                  _fadeNavigate(context, const LoginScreen(mode: 'login')); // <-- Removed selectedPage
=======
                  _fadeNavigate(context, const LoginPage(mode: 'login', selectedPage: null,));
>>>>>>> 1bbb1afef12affa6dee4b187b139e5b2ea117905
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 235, 129, 48),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Pixeled',
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('START'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
