import 'package:flutter/material.dart';
import 'package:gamify/login_screen.dart'; //import the Login page
import 'package:gamify/selected_screen.dart'; //import the enum that tells us what screen is selected
import 'package:gamify/signup_screen.dart'; //import the Signup page
import 'package:gamify/splash_screen.dart'; //import the Splash page (the first screen)

void main() {
  //start gamify and show the first screen
  runApp(const Gamify());
}

class Gamify extends StatelessWidget {
  //constructor
  const Gamify({super.key});

  @override
  Widget build(BuildContext context) {
    //main setup
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //removes the debug banner in the upper right corner
      initialRoute: '/', //first screen (the SplashScreen)
      //defines all the possible screens/routes in the app
      routes: {
        '/': (context) => const SplashScreen(), //SplashScreen is shown first
        '/login':
            (context) => const LoginPage(
              selectedPage:
                  SelectedPage.login, //we're passing the login page enum value
            ),
        '/signup':
            (context) => const SignupPage(
              selectedPage:
                  SelectedPage
                      .signup, //we're passing the signup page enum value
            ),
      },
    );
  }
}
