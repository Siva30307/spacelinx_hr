import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/dashboard_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../widgets/common/glass_card.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      context.read<DashboardProvider>().fetchDashboardData(today);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<DashboardProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      'SpaceLinx Dashboard',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
                SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _buildSummaryCard(
                      'Total Employees',
                      provider.headcountSummary?.totalActive.toString() ?? '0',
                      Icons.people_outline,
                      Colors.blue,
                    ),
                    _buildSummaryCard(
                      'On Notice',
                      provider.headcountSummary?.totalOnNotice.toString() ?? '0',
                      Icons.notification_important_outlined,
                      Colors.orange,
                    ),
                    _buildSummaryCard(
                      'Present',
                      provider.attendanceSummary?.present.toString() ?? '0',
                      Icons.check_circle_outline,
                      Colors.green,
                    ),
                    _buildSummaryCard(
                      'Absent',
                      provider.attendanceSummary?.absent.toString() ?? '0',
                      Icons.cancel_outlined,
                      Colors.red,
                    ),
                    _buildSummaryCard(
                      'Leave Management',
                      'Overview',
                      Icons.beach_access_outlined,
                      Colors.teal,
                      onTap: () {
                        context.read<NavigationProvider>().setTab(1);
                      },
                    ),
                  ],
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: GlassCard(
                      height: 200,
                      child: Center(
                        child: Text('Headcount Trend Chart (fl_chart)'),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
