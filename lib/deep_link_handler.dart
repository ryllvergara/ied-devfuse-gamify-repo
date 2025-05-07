import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';

class DeepLinkHandler extends StatefulWidget {
  final Widget child;

  const DeepLinkHandler({super.key, required this.child});

  @override
  State<DeepLinkHandler> createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends State<DeepLinkHandler> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleDeepLink();
  }

  Future<void> _handleDeepLink() async {
    if (!kIsWeb) {
      // Only listen to linkStream on mobile/desktop
      _sub = linkStream.listen((String? link) {
        _processLink(link);
      });
    } else {
      // On web, just check once at startup
      final link = await getInitialLink();
      _processLink(link);
    }
  }

  void _processLink(String? link) {
    if (link != null && link.contains("verify-email")) {
      if (mounted) {
        Navigator.pushNamed(context, '/verify-email');
      }
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
