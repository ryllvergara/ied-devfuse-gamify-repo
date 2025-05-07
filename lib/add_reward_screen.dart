import 'package:flutter/material.dart';

class AddRewardScreen extends StatelessWidget {
  const AddRewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'), // Background image asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Centered Coming Soon Text
          Center(
            child: Text(
              'COMING SOON', // Coming Soon text
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
