import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSettingsTap;

  const AppHeader({super.key, required this.title, this.onSettingsTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          if (onSettingsTap != null)
            InkWell(
              onTap: onSettingsTap,
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
