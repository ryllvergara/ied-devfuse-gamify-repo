import 'package:flutter/material.dart'; //import the package
import 'package:gamify/selected_screen.dart'; //import the SelectedPage enum

import 'login_screen.dart'; //import the LoginScreen

//root of the splashscreen
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key}); // Constructor

  //helper function for fade navigation
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

  //builds the design for splash screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, //expands the stack to fit the entire screen
        children: [
          Image.asset(
            'asset/images/introbgc.jpg',
            fit: BoxFit.cover,
          ), //bgc for splash screen
          Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, //even space in a column
            children: [
              Image.asset(
                'asset/images/glogo.png',
                width: 300,
                height: 200,
              ), //gamify logo
              const SizedBox(height: 0), //no height spacer
              ElevatedButton(
                //start button
                onPressed: () {
                  //navigate to LoginPage with a valid selectedPage
                  _fadeNavigate(
                    context,
                    const LoginPage(
                      selectedPage: SelectedPage.login, //pass valid enum
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  //design for the button
                  foregroundColor: Colors.black, //text color
                  backgroundColor: const Color.fromARGB(
                    255,
                    235,
                    129,
                    48,
                  ), //bgc color
                  padding: const EdgeInsets.symmetric(
                    //padding size
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
