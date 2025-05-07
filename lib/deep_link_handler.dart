import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';

class DeepLinkHandler extends StatefulWidget {
  final Widget child;

  const DeepLinkHandler({super.key, required this.child});

  @override
  // ignore: library_private_types_in_public_api
  _DeepLinkHandlerState createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends State<DeepLinkHandler> {
  late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _handleDeepLink();
  }

  // This will handle incoming deep links
  Future<void> _handleDeepLink() async {
    _sub = linkStream.listen((String? link) async {
      if (link != null) {
        // Check if the link is for email verification
        if (link.contains("verify-email")) {
          if (mounted) { // Check if the widget is still mounted
            Navigator.pushNamed(context, '/verify-email');
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sub.cancel(); // Clean up the stream when the widget is disposed.
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
