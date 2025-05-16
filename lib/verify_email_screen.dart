import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  VerifyEmailScreenState createState() => VerifyEmailScreenState();
}

class VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  bool _verifying = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _handleIncomingLinks() async {
    try {
      final Uri? initialUri = await _appLinks.getInitialLink(); // <-- fixed here
      if (initialUri != null) {
        await _processVerificationUri(initialUri);
      }

      _linkSubscription = _appLinks.uriLinkStream.listen((Uri uri) async {
        await _processVerificationUri(uri);
      }, onError: (err) {
        setState(() {
          _error = 'Error handling link: $err';
          _verifying = false;
        });
      });
    } catch (e) {
      setState(() {
        _error = 'Error during link handling: $e';
        _verifying = false;
      });
    }
  }

  Future<void> _processVerificationUri(Uri uri) async {
    try {
      final token = uri.queryParameters['token'];
      if (token != null) {
        // Simulate verification logic here
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/profile');
        }
      } else {
        setState(() {
          _error = 'Invalid verification link.';
          _verifying = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Verification failed: $e';
        _verifying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email Verification')),
      body: Center(
        child: _verifying
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Verifying your email..."),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              )
            : _error != null
                ? Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  )
                : const Text("Email verified successfully!"),
      ),
    );
  }
}
