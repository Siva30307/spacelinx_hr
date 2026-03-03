import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/api/api_client.dart';
import 'data/repositories/dashboard_repository.dart';
import 'providers/auth_provider.dart';
import 'providers/dashboard_provider.dart';
import 'core/theme/app_theme.dart';
import 'ui/screens/dashboard/dashboard_screen.dart';
import 'ui/screens/auth/login_screen.dart';
import 'core/auth/azure_auth_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final apiClient = ApiClient();
  final dashboardRepo = DashboardRepository(apiClient);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider(dashboardRepo)),
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
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return auth.isAuthenticated ? const DashboardScreen() : const LoginScreen();
        },
      ),
    );
  }
}
