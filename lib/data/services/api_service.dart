import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio;
  static const String baseUrl = 'https://spacelinx-hr-api-dev.azurewebsites.net/api/v1/';

  ApiService() : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        // Handle global errors (e.g., 401 Unauthorized)
        if (e.response?.statusCode == 401) {
          // Trigger logout or token refresh logic
        }
        return handler.next(e);
      },
    ));
  }

  Dio get client => _dio;

  // Potential Auth implementation
  Future<Response> login(String email, String password) async {
    return _dio.post('/Auth/login', data: {'email': email, 'password': password});
  }
}
