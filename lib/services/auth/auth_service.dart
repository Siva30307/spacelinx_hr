import 'package:shared_preferences/shared_preferences.dart';
import 'package:aad_oauth/aad_oauth.dart';
import 'package:flutter/foundation.dart';
import '../../core/auth/azure_auth_config.dart';

class AuthService {
  static const String _tokenKey = 'access_token';
  static const String _userKey = 'user_data';
  
  AadOAuth? _oauthInstance;
  AadOAuth get _oauth {
    _oauthInstance ??= AadOAuth(AzureAuthConfig.config);
    return _oauthInstance!;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
    await _oauth.logout();
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<bool> loginWithMicrosoft() async {
    try {
      await _oauth.login();
      final String? token = await _oauth.getIdToken();
      if (token != null) {
        await saveToken(token);
        return true;
      }
      return false;
    } catch (e, stacktrace) {
      debugPrint('AuthService Microsoft Login Exception: $e');
      debugPrint('Stacktrace: $stacktrace');
      return false;
    }
  }

  // Legacy/Mock login
  Future<bool> login(String username, String password) async {
    // In a real app with Azure AD, you'd use MSAL here.
    // This is where you call your backend login or AD portal.
    return false;
  }
}
