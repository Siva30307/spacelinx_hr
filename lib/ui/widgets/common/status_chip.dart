import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final Color? color;

  const StatusChip({super.key, required this.label, this.color});

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'approved':
      case 'present':
        return AppColors.success;
      case 'pending':
      case 'half day':
      case 'halfday':
      case 'onnotice':
      case 'on notice':
        return AppColors.warning;
      case 'rejected':
      case 'absent':
      case 'terminated':
      case 'separated':
        return AppColors.danger;
      case 'wfh':
      case 'work from home':
        return AppColors.purple;
      case 'on leave':
      case 'onleave':
        return AppColors.teal;
      case 'holiday':
        return AppColors.pink;
      default:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? getStatusColor(label);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: chipColor.withValues(alpha: 0.4), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: chipColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
