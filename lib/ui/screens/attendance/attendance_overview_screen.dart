import 'package:flutter/material.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import '../../../core/theme/app_theme.dart';
import 'daily_log_screen.dart';
import 'shift_list_screen.dart';
import 'shift_assignment_screen.dart';
import 'regularization_list_screen.dart';

class AttendanceOverviewScreen extends StatelessWidget {
  const AttendanceOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Attendance', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              const Text('Track time & shifts', style: TextStyle(fontSize: 13.5, color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildCard(
                    context,
                    title: 'Daily Log',
                    subtitle: 'Attendance records',
                    icon: Icons.schedule,
                    gradient: const [Color(0xFF3B82F6), Color(0xFF60A5FA)],
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DailyLogScreen())),
                  ),
                  _buildCard(
                    context,
                    title: 'Shifts',
                    subtitle: 'Manage shifts',
                    icon: Icons.access_time_filled,
                    gradient: const [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShiftListScreen())),
                  ),
                  _buildCard(
                    context,
                    title: 'Assignments',
                    subtitle: 'Shift assignments',
                    icon: Icons.assignment_ind,
                    gradient: const [Color(0xFF10B981), Color(0xFF34D399)],
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShiftAssignmentScreen())),
                  ),
                  _buildCard(
                    context,
                    title: 'Regularizations',
                    subtitle: 'Corrections & approvals',
                    icon: Icons.rule,
                    gradient: const [Color(0xFFF59E0B), Color(0xFFFBBF24)],
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegularizationListScreen())),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradient.map((c) => c.withValues(alpha: 0.15)).toList(),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: gradient[0].withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: gradient[0], size: 28),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.5))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
