import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  Future<void> _handleIncomingLinks() async {
    // Get initial link if the app was opened from a deep link
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        // Parse the link and handle verification logic
        print('Verification URL: $initialLink');
        // Verify the email based on the URL (e.g., by extracting the token)
      }
    } catch (e) {
      print('Error handling deep link: $e');
    }

    // Listen for subsequent links while the app is in the background or foreground
    linkStream.listen((String? link) {
      if (link != null) {
        print('Verification URL: $link');
        // Handle verification URL
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email Verification')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Please verify your email to continue."),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
