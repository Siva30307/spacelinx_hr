import 'package:aad_oauth/model/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AzureAuthConfig {
  static const String clientId = '748aa650-05ea-49d6-9c2f-aa0c83d2a024';
  static const String tenantId = '9a2ef642-7a2d-4c40-9e00-b8b132aef5b8'; 
  static const String authority = 'https://login.microsoftonline.com/common';
  
  // Use a safer way to get the base URL on web without dart:html
  static final String redirectUri = kIsWeb 
      ? '${Uri.base.origin}/' // Match React app redirectUri: "/"
      : 'https://login.live.com/oauth20_desktop.srf';

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final Config config = Config(
    tenant: 'common',
    clientId: clientId,
    scope: 'User.Read openid profile email',
    redirectUri: redirectUri,
    navigatorKey: navigatorKey,
  );
}
