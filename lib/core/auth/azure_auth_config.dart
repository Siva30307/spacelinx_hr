import 'dart:convert';
import 'dart:math';

import 'package:aad_oauth/model/config.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AzureAuthConfig {
  static const String clientId = '748aa650-05ea-49d6-9c2f-aa0c83d2a024';
  static const String tenantId = '9a2ef642-7a2d-4c40-9e00-b8b132aef5b8'; 
  static const String authority = 'https://login.microsoftonline.com/common';
  
  // Use a safer way to get the base URL on web without dart:html
  static final String redirectUri = kIsWeb 
      ? '${Uri.base.origin}/' // Match React app redirectUri: "/"
      : 'http://localhost:5174/'; // Spoof React web URI for local Mobile testing

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // PKCE: Generate code_verifier (random 43-128 char string)
  static final String _codeVerifier = _generateCodeVerifier();
  // PKCE: Derive code_challenge from code_verifier using S256
  static final String _codeChallenge = _generateCodeChallenge(_codeVerifier);

  static String _generateCodeVerifier() {
    final random = Random.secure();
    final values = List<int>.generate(64, (_) => random.nextInt(256));
    return base64UrlEncode(values).replaceAll('=', '');
  }

  static String _generateCodeChallenge(String verifier) {
    final bytes = utf8.encode(verifier);
    final digest = sha256.convert(bytes);
    return base64UrlEncode(digest.bytes).replaceAll('=', '');
  }

  static final Config config = Config(
    tenant: 'common',
    clientId: clientId,
    scope: 'User.Read openid profile email',
    redirectUri: redirectUri,
    navigatorKey: navigatorKey,
    responseMode: 'query', // Force query params instead of fragments
    origin: 'http://localhost:5174', // Bypass SPA CORS on Mobile
    codeVerifier: _codeVerifier,
    codeChallenge: _codeChallenge,
    codeChallengeMethod: 'S256',
  );
}
