import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    // Add other common headers
    options.headers['Accept'] = 'application/json';
    options.contentType = Headers.jsonContentType;
    options.headers['SPACELINX-APP-NAME'] = 'SPACELINX-HR';

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Handle Unauthorized error (e.g., redirect to login or refresh token)
      debugPrint('Unauthorized! Token might be expired.');
    }
    return handler.next(err);
  }
}
