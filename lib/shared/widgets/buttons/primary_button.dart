// Enhanced button components with empathy-driven design
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool isSecondary;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final bool isSmall;
  
  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isSecondary = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.isSmall = false,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color get _backgroundColor {
    if (widget.backgroundColor != null) return widget.backgroundColor!;
    if (widget.isSecondary) return AppColors.surfaceWhite;
    return AppColors.primaryRed;
  }

  Color get _textColor {
    if (widget.textColor != null) return widget.textColor!;
    if (widget.isSecondary) return AppColors.primaryRed;
    return AppColors.surfaceWhite;
  }

  @override
  Widget build(BuildContext context) {
    final buttonHeight = widget.isSmall 
        ? AppDimensions.buttonHeightSmall 
        : AppDimensions.buttonHeight;
    
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: SizedBox(
            width: widget.width,
            height: buttonHeight,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: _backgroundColor,
                foregroundColor: _textColor,
                elevation: widget.isSecondary ? 0 : AppDimensions.elevationS,
                shadowColor: AppColors.shadowLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  side: widget.isSecondary
                      ? BorderSide(color: AppColors.primaryRed, width: 1.5)
                      : BorderSide.none,
                ),
                padding: AppDimensions.buttonPadding,
              ).copyWith(
                overlayColor: MaterialStateProperty.all(
                  _textColor.withOpacity(0.1),
                ),
              ),
              onTapDown: (_) => _animationController.forward(),
              onTapUp: (_) => _animationController.reverse(),
              onTapCancel: () => _animationController.reverse(),
              child: widget.isLoading
                  ? SizedBox(
                      width: AppDimensions.iconM,
                      height: AppDimensions.iconM,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(_textColor),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            size: AppDimensions.iconS,
                            color: _textColor,
                          ),
                          const SizedBox(width: AppDimensions.spacingS),
                        ],
                        Text(
                          widget.text,
                          style: AppTextStyles.buttonText.copyWith(
                            color: _textColor,
                            fontSize: widget.isSmall ? 14 : 16,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

// Empathy action button for gentle interactions
class EmpathyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData icon;
  final Color empathyColor;
  final bool isCompact;
  
  const EmpathyButton({
    Key? key,
    required this.text,
    required this.icon,
    this.onPressed,
    this.empathyColor = AppColors.empathyTeal,
    this.isCompact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            empathyColor.withOpacity(0.8),
            empathyColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        boxShadow: [
          BoxShadow(
            color: empathyColor.withOpacity(0.3),
            blurRadius: AppDimensions.elevationM,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          child: Padding(
            padding: isCompact 
                ? const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingM,
                    vertical: AppDimensions.spacingS,
                  )
                : AppDimensions.buttonPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: AppColors.surfaceWhite,
                  size: isCompact ? AppDimensions.iconS : AppDimensions.iconM,
                ),
                const SizedBox(width: AppDimensions.spacingS),
                Text(
                  text,
                  style: AppTextStyles.buttonText.copyWith(
                    fontSize: isCompact ? 14 : 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
