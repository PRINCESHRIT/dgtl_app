// Empathy-driven card component integrating with existing DGTL services
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';

class EmpathyCard extends ConsumerWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final bool isLoading;
  final Widget? trailing;
  final String? empathyMessage;
  
  const EmpathyCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
    this.backgroundColor,
    this.isLoading = false,
    this.trailing,
    this.empathyMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: AppDimensions.empathyCardHeight,
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingM),
      decoration: BoxDecoration(
        gradient: backgroundColor != null 
          ? null 
          : AppColors.empathyGradient,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: AppDimensions.elevationM,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          child: Padding(
            padding: AppDimensions.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon and title
                Row(
                  children: [
                    Container(
                      width: AppDimensions.iconXL,
                      height: AppDimensions.iconXL,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      ),
                      child: Icon(
                        icon,
                        color: AppColors.surfaceWhite,
                        size: AppDimensions.iconL,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spacingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.headerSmall.copyWith(
                              color: AppColors.surfaceWhite,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacingXS),
                          Text(
                            subtitle,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.surfaceWhite.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (trailing != null) trailing!,
                    if (isLoading)
                      SizedBox(
                        width: AppDimensions.iconM,
                        height: AppDimensions.iconM,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.surfaceWhite,
                          ),
                        ),
                      ),
                  ],
                ),
                
                const Spacer(),
                
                // Empathy message at bottom
                if (empathyMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacingM,
                      vertical: AppDimensions.spacingS,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceWhite.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: AppDimensions.iconS,
                          color: AppColors.surfaceWhite.withOpacity(0.8),
                        ),
                        const SizedBox(width: AppDimensions.spacingS),
                        Expanded(
                          child: Text(
                            empathyMessage!,
                            style: AppTextStyles.empathyText.copyWith(
                              color: AppColors.surfaceWhite.withOpacity(0.9),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Medical data empathy card - integrates with your DgtlClinicalService
class MedicalDataCard extends ConsumerWidget {
  final String label;
  final String value;
  final String unit;
  final String status;
  final IconData icon;
  final VoidCallback? onTap;
  
  const MedicalDataCard({
    Key? key,
    required this.label,
    required this.value,
    required this.unit,
    required this.status,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'normal':
        return AppColors.statusNormal;
      case 'warning':
        return AppColors.statusWarning;
      case 'critical':
        return AppColors.statusCritical;
      case 'excellent':
        return AppColors.statusExcellent;
      default:
        return AppColors.statusNormal;
    }
  }

  String _getEmpathyMessage(String status) {
    switch (status.toLowerCase()) {
      case 'normal':
        return 'आपके स्वास्थ्य की स्थिति अच्छी है';
      case 'warning':
        return 'हम आपकी निगरानी कर रहे हैं';
      case 'critical':
        return 'कृपया डॉक्टर से संपर्क करें';
      case 'excellent':
        return 'बहुत बढ़िया! आप अच्छा कर रहे हैं';
      default:
        return 'हम आपकी देखभाल कर रहे हैं';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusColor = _getStatusColor(status);
    
    return EmpathyCard(
      title: label,
      subtitle: '$value $unit',
      icon: icon,
      backgroundColor: statusColor,
      onTap: onTap,
      empathyMessage: _getEmpathyMessage(status),
      trailing: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingS,
          vertical: AppDimensions.spacingXS,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite.withOpacity(0.2),
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        ),
        child: Text(
          status.toUpperCase(),
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.surfaceWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
