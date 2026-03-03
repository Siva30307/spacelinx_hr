import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _token;

  AuthProvider();

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;

  final AuthService _authService = AuthService();

  Future<void> loginWithMicrosoft() async {
    _isLoading = true;
    notifyListeners();
    try {
      final success = await _authService.loginWithMicrosoft();
      if (success) {
        _token = await _authService.getToken();
        _isAuthenticated = true;
      }
    } catch (e) {
      debugPrint('MSAL Login failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> mockLogin() async {
    _token = 'MOCK_TOKEN_FOR_DEV';
    await _authService.saveToken(_token!);
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      // In a real app, you'd call _apiClient.post(ApiEndpoints.login, ...)
      // Keeping it simple for now to focus on your diagnostic fixes.
    } catch (e) {
      debugPrint('Login failed: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authService.clearAuth();
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> checkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token');
    _isAuthenticated = _token != null;
    notifyListeners();
  }
}
