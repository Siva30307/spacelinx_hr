import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/leave_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'leave_type_list_screen.dart';
import 'leave_policy_list_screen.dart';
import 'leave_request_list_screen.dart';
import 'holiday_calendar_screen.dart';

class LeaveOverviewScreen extends StatefulWidget {
  const LeaveOverviewScreen({super.key});

  @override
  State<LeaveOverviewScreen> createState() => _LeaveOverviewScreenState();
}

class _LeaveOverviewScreenState extends State<LeaveOverviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final leaveProvider = Provider.of<LeaveProvider>(context, listen: false);
      leaveProvider.fetchLeaveTypes();
      leaveProvider.fetchLeaveRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<LeaveProvider>(
        builder: (context, provider, _) {
          final pendingCount = provider.leaveRequests
              .where((r) => r.status == 'Pending')
              .length;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Text(
                  'Leave Management',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildOverviewCard(
                        context,
                        title: 'Leave Types',
                        value: provider.leaveTypes.length.toString(),
                        subtitle: 'configured',
                        icon: Icons.list_alt,
                        color: Colors.blue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LeaveTypeListScreen()),
                          );
                        },
                      ),
                      _buildOverviewCard(
                        context,
                        title: 'Pending Requests',
                        value: pendingCount.toString(),
                        subtitle: 'awaiting approval',
                        icon: Icons.event_note,
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LeaveRequestListScreen()),
                          );
                        },
                      ),
                      _buildOverviewCard(
                        context,
                        title: 'Leave Policies',
                        value: provider.leavePolicies.length.toString(),
                        subtitle: 'manage policies',
                        icon: Icons.policy,
                        color: Colors.purple,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LeavePolicyListScreen()),
                          );
                        },
                      ),
                      _buildOverviewCard(
                        context,
                        title: 'Holiday Calendar',
                        value: '—',
                        subtitle: 'manage holidays',
                        icon: Icons.calendar_month,
                        color: Colors.green,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const HolidayCalendarScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Quick Links',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildQuickLink(context, 'Leave Requests', () {}),
                    _buildQuickLink(context, 'Leave Types', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LeaveTypeListScreen()),
                      );
                    }),
                    _buildQuickLink(context, 'Leave Policies', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LeavePolicyListScreen()),
                      );
                    }),
                    _buildQuickLink(context, 'Holiday Calendar', () {}),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverviewCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLink(BuildContext context, String label, VoidCallback onTap) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(label),
    );
  }
}
