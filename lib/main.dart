import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/api/api_client.dart';
import 'providers/auth_provider.dart';
import 'core/theme/app_theme.dart';
import 'ui/screens/main_screen.dart';
import 'ui/screens/auth/login_screen.dart';
import 'core/auth/azure_auth_config.dart';
import 'data/repositories/leave_repository.dart';
import 'data/repositories/employee_repository.dart';
import 'data/repositories/attendance_repository.dart';
import 'data/repositories/dashboard_repository.dart'; // Added import
import 'providers/leave_provider.dart';
import 'providers/employee_provider.dart';
import 'providers/attendance_provider.dart';
import 'data/repositories/organization_repository.dart';
import 'providers/organization_provider.dart';
import 'providers/navigation_provider.dart';
import 'providers/dashboard_provider.dart'; // Added import

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final apiClient = ApiClient();
  final leaveRepo = LeaveRepository(apiClient);
  final employeeRepo = EmployeeRepository(apiClient);
  final attendanceRepo = AttendanceRepository(apiClient);
  final orgRepo = OrganizationRepository(apiClient);
  final dashboardRepo = DashboardRepository(apiClient); // Added initialization

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LeaveProvider(leaveRepo)),
        ChangeNotifierProvider(create: (_) => EmployeeProvider(employeeRepo)),
        ChangeNotifierProvider(create: (_) => AttendanceProvider(attendanceRepo)),
        ChangeNotifierProvider(create: (_) => OrganizationProvider(orgRepo)..fetchAllLookups()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider(dashboardRepo)), // Added DashboardProvider
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
