import 'package:flutter/material.dart';

class ProfileSelectionScreen extends StatelessWidget {
  const ProfileSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The screen for charcater selection'),
      ),
      body: const Center(
        child: Text('The screen for character selection.'),
      ),
    );
  }
}
