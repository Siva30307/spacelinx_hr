import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/leave_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import '../../../core/theme/app_theme.dart';
import 'leave_balance_screen.dart';
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
      final leaveProvider = context.read<LeaveProvider>();

      leaveProvider.fetchLeaveTypes();
      leaveProvider.fetchLeaveRequests();
      leaveProvider.fetchLeavePolicies();
      leaveProvider.fetchHolidayCalendars();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(
        builder: (context) {

          final provider = context.watch<LeaveProvider>();

          final leaveTypesCount = provider.leaveTypes.length;
          final leavePoliciesCount = provider.leavePolicies.length;
          final pendingCount = provider.leaveRequests
              .where((r) => r.status.toLowerCase() == 'pending')
              .length;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'Leave',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),

                const SizedBox(height: 4),

                const Text(
                  'Requests, balances, policies',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 32),

                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [

                      /// Leave Types
                      _buildOverviewCard(
                        context,
                        title: 'Leave Types',
                        value: leaveTypesCount.toString(),
                        subtitle: 'configured',
                        icon: Icons.list_alt,
                        color: Colors.blue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LeaveTypeListScreen(),
                            ),
                          );
                        },
                      ),

                      /// Pending Requests
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
                            MaterialPageRoute(
                              builder: (_) => const LeaveRequestListScreen(),
                            ),
                          );
                        },
                      ),

                      /// Leave Balances
                      _buildOverviewCard(
                        context,
                        title: 'Leave Balances',
                        value: provider.leaveBalances.isEmpty
                            ? '—'
                            : provider.leaveBalances.length.toString(),
                        subtitle: 'view balances',
                        icon: Icons.account_balance_wallet_outlined,
                        color: Colors.teal,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LeaveBalanceScreen(),
                            ),
                          );
                        },
                      ),

                      /// Leave Policies
                      _buildOverviewCard(
                        context,
                        title: 'Leave Policies',
                        value: leavePoliciesCount.toString(),
                        subtitle: 'manage policies',
                        icon: Icons.policy,
                        color: Colors.purple,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LeavePolicyListScreen(),
                            ),
                          );
                        },
                      ),

                      /// Holiday Calendar
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
                            MaterialPageRoute(
                              builder: (_) => const HolidayCalendarScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
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
                    fontWeight: FontWeight.w800,
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
}