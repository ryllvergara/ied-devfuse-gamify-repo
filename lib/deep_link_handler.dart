import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';

class DeepLinkHandler extends StatefulWidget {
  final Widget child;

  const DeepLinkHandler({super.key, required this.child});

  @override
  State<DeepLinkHandler> createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends State<DeepLinkHandler> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _sub;
  Uri? _lastProcessedUri;

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
    _checkInitialLink();
  }

  void _initDeepLinkListener() {
    _sub = _appLinks.uriLinkStream.listen(
      (Uri uri) {
        _processLink(uri);
      },
      onError: (err) {
        debugPrint("Deep link error: $err");
      },
    );
  }

  Future<void> _checkInitialLink() async {
    try {
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _processLink(initialUri);
      }
    } catch (e) {
      debugPrint("Failed to get initial link: $e");
    }
  }

  void _processLink(Uri uri) {
    if (_lastProcessedUri == uri) return;
    _lastProcessedUri = uri;

    debugPrint("Deep link opened: $uri");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (uri.path.contains("verify")) {
        Navigator.pushNamed(context, '/verify-email');
      } else if (uri.path.contains("recover")) {
        final accessToken = uri.queryParameters['access_token'];
        Navigator.pushNamed(
          context,
          '/new-password',
          arguments: accessToken, // Pass token to screen
        );
      } else {
        debugPrint("Unhandled deep link path: ${uri.path}");
      }
    });
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
