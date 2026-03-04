import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/api/api_client.dart';
import 'data/repositories/dashboard_repository.dart';
import 'providers/auth_provider.dart';
import 'providers/dashboard_provider.dart';
import 'core/theme/app_theme.dart';
import 'ui/screens/main_screen.dart';
import 'ui/screens/auth/login_screen.dart';
import 'core/auth/azure_auth_config.dart';
import 'data/repositories/leave_repository.dart';
import 'providers/leave_provider.dart';
import 'providers/navigation_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final apiClient = ApiClient();
  final dashboardRepo = DashboardRepository(apiClient);
  final leaveRepo = LeaveRepository(apiClient);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider(dashboardRepo)),
        ChangeNotifierProvider(create: (_) => LeaveProvider(leaveRepo)),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: const SpaceLinxApp(),
    ),
  );
}

class SpaceLinxApp extends StatelessWidget {
  const SpaceLinxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AzureAuthConfig.navigatorKey,
      title: 'SpaceLinx.HR',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: child,
        );
      },
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return auth.isAuthenticated ? const MainScreen() : const LoginScreen();
        },
      ),
    );
  }
}
