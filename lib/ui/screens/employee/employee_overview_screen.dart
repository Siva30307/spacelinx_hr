import 'package:flutter/material.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'employee_list_screen.dart';
import 'onboarding_list_screen.dart';
import 'separation_list_screen.dart';

class EmployeeOverviewScreen extends StatelessWidget {
  const EmployeeOverviewScreen({super.key});

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
              const Text(
                'Employees',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                'Manage your workforce',
                style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.6)),
              ),
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
                    title: 'All Employees',
                    subtitle: 'View & manage staff',
                    icon: Icons.people,
                    gradient: const [Color(0xFF6366F1), Color(0xFF818CF8)],
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EmployeeListScreen())),
                  ),
                  _buildCard(
                    context,
                    title: 'Onboarding',
                    subtitle: 'Templates & tasks',
                    icon: Icons.how_to_reg,
                    gradient: const [Color(0xFF10B981), Color(0xFF34D399)],
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OnboardingListScreen())),
                  ),
                  _buildCard(
                    context,
                    title: 'Separation',
                    subtitle: 'Exits & F&F',
                    icon: Icons.exit_to_app,
                    gradient: const [Color(0xFFF59E0B), Color(0xFFFBBF24)],
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SeparationListScreen())),
                  ),
                  _buildCard(
                    context,
                    title: 'Directory',
                    subtitle: 'Quick lookup',
                    icon: Icons.contacts,
                    gradient: const [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EmployeeListScreen())),
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
