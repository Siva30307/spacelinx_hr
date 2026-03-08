import 'package:flutter/material.dart';
import 'package:spacelinx_hr/core/theme/app_theme.dart';

/// A clean, minimal card widget used across the app.
/// Replaces the previous glassmorphism effect with a solid surface card.
class GlassCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const GlassCard({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outline.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
