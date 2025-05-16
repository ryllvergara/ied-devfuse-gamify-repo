import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';

// Screen para mag handle sang email verification gamit deep links
class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  VerifyEmailScreenState createState() => VerifyEmailScreenState();
}

class VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final AppLinks _appLinks = AppLinks(); // Para sa pag listen sang app deep links
  StreamSubscription<Uri>? _linkSubscription; // Subscription sa link stream
  bool _verifying = true; // Nagapakita nga naga verify pa ang system
  String? _error; // Variable para sa error message kung may problema

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks(); // Tawgon ang method para handle sang incoming deep links
  }

  @override
  void dispose() {
    _linkSubscription?.cancel(); // Cancel subscription para indi mag leak ang memory
    super.dispose();
  }

  // Method nga naga handle sang initial link kag subsequent incoming links
  Future<void> _handleIncomingLinks() async {
    try {
      final Uri? initialUri = await _appLinks.getInitialLink(); // Kuhaon ang initial link kung may ara
      if (initialUri != null) {
        await _processVerificationUri(initialUri); // Process sang verification link
      }

      // Listen sa stream sang incoming links samtang nagarunning ang app
      _linkSubscription = _appLinks.uriLinkStream.listen((Uri uri) async {
        await _processVerificationUri(uri);
      }, onError: (err) {
        // Kung may error sa pag handle sang link, ipakita error message
        setState(() {
          _error = 'Error handling link: $err';
          _verifying = false;
        });
      });
    } catch (e) {
      // Kung may exception, ipakita error message
      setState(() {
        _error = 'Error during link handling: $e';
        _verifying = false;
      });
    }
  }

  // Method para i-process ang verification uri gikan sa deep link
  Future<void> _processVerificationUri(Uri uri) async {
    try {
      final token = uri.queryParameters['token']; // Kuhaon ang token gikan sa query parameters
      if (token != null) {
        // Diri pwede i-implement ang actual verification logic gamit ang token
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/profile'); // Navigate sa profile screen pag successful
        }
      } else {
        setState(() {
          _error = 'Invalid verification link.'; // Kung wala token, error ini
          _verifying = false;
        });
      }
    } catch (e) {
      // Kung may error sa verification, ipakita error message
      setState(() {
        _error = 'Verification failed: $e';
        _verifying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email Verification')), // Title bar
      body: Center(
        child: _verifying
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Verifying your email..."), // Nagapakita nga naga verify pa
                  SizedBox(height: 20),
                  CircularProgressIndicator(), // Spinner nga nagapakita sang proseso
                ],
              )
            : _error != null
                ? Text(
                    _error!, // Ipakita ang error message kung may error
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  )
                : const Text("Email verified successfully!"), // Mensahe kon successful ang verification
      ),
    );
  }
}
