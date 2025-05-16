import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

// Ini nga class naga handle sang deep links sa app
class DeepLinkHandler extends StatefulWidget {
  final Widget child;

  const DeepLinkHandler({super.key, required this.child});

  @override
  State<DeepLinkHandler> createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends State<DeepLinkHandler> {
  final AppLinks _appLinks = AppLinks(); // Gamit para sa pagkuha sang app links
  StreamSubscription<Uri>? _sub; // Listener ni sya sa mga links nga naga sulod
  Uri? _lastProcessedUri; // Ginatago ang last nga link nga na-process na

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener(); // Start listening sa new links
    _checkInitialLink(); // Check if may link na ginhatag pag open pa lang sang app
  }

  // Ginaset-up ang listener para kung may bago nga deep link nga masulod
  void _initDeepLinkListener() {
    _sub = _appLinks.uriLinkStream.listen(
      (Uri uri) {
        _processLink(uri); // Process the uri everytime may new link
      },
      onError: (err) {
        debugPrint("Deep link error: $err"); // I-print error kung may problema
      },
    );
  }

  // Ginalantaw kung may initial link nga ginhatag sang OS pag open sang app
  Future<void> _checkInitialLink() async {
    try {
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _processLink(initialUri); // If may ara, process dayon
      }
    } catch (e) {
      debugPrint(
        "Failed to get initial link: $e",
      ); // Print error kung indi magkuha
    }
  }

  // Amo ni ang function nga naga decide kung diin ka dal-on base sa uri
  void _processLink(Uri uri) {
    // Indi na pag usbon kung pareho lang sang last nga link
    if (_lastProcessedUri == uri) return;
    _lastProcessedUri = uri;

    debugPrint("Deep link opened: $uri"); // Ginaprint ang uri for debugging

    // Paabot ta gamay para sure nga ready na ang UI antes mag navigate
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      // Kung ang link naga contain sang "verify", dal-on sa verify-email screen
      if (uri.path.contains("verify")) {
        Navigator.pushNamed(context, '/verify-email');
      }
      // Kung "recover" naman, kuhaon ang access_token kag i-navigate sa new-password
      else if (uri.path.contains("recover")) {
        final accessToken = uri.queryParameters['access_token'];
        Navigator.pushNamed(
          context,
          '/new-password',
          arguments: accessToken, // Ginapasa ang token sa password reset screen
        );
      }
      // Kung indi kilala ang path, i-print lang para ma debug
      else {
        debugPrint("Unhandled deep link path: ${uri.path}");
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel(); // Stop listening kung gin close na ang screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child; // return lng, no changes
  }
}
