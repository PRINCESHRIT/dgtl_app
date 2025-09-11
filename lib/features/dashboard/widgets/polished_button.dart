import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dgtl_app/app/design_system.dart';

class PolishedButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isEmpathy;
  final IconData? icon;
  final bool isLoading;
  final double? width;

  const PolishedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isPrimary = false,
    this.isEmpathy = false,
    this.icon,
    this.isLoading = false,
    this.width,
  });

  @override
  State<PolishedButton> createState() => _PolishedButtonState();
}

class _PolishedButtonState extends State<PolishedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      duration: PastelAnimations.quick,
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _pressController,
      curve: PastelAnimations.quickEase,
    ));
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  Color get _backgroundColor {
    if (widget.isPrimary) {
      return _isPressed ? PastelColors.primaryActionHover : PastelColors.primaryAction;
    } else if (widget.isEmpathy) {
      return _isPressed 
        ? PastelColors.empathyAccent.withOpacity(0.8) 
        : PastelColors.empathyAccent;
    }
    return _isPressed 
      ? PastelColors.softWhite.withOpacity(0.8) 
      : PastelColors.softWhite;
  }

  Color get _textColor {
    if (widget.isPrimary) return Colors.white;
    if (widget.isEmpathy) return PastelColors.empathyText;
    return PastelColors.mutedBlack;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pressController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) {
              setState(() => _isPressed = true);
              _pressController.forward();
            },
            onTapUp: (_) {
              setState(() => _isPressed = false);
              _pressController.reverse();
              if (widget.onPressed != null && !widget.isLoading) {
                widget.onPressed!();
              }
            },
            onTapCancel: () {
              setState(() => _isPressed = false);
              _pressController.reverse();
            },
            child: AnimatedContainer(
              duration: PastelAnimations.quick,
              curve: PastelAnimations.softEase,
              width: widget.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: PastelBorders.button,
                boxShadow: widget.isPrimary || widget.isEmpathy
                  ? (_isPressed ? PastelEffects.cardShadow : PastelEffects.elevatedShadow)
                  : PastelEffects.cardShadow,
                border: !widget.isPrimary && !widget.isEmpathy
                  ? Border.all(
                      color: PastelColors.mutedBlack.withOpacity(0.1),
                      width: 1,
                    )
                  : null,
              ),
              child: widget.isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: _textColor,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          size: 18,
                          color: _textColor,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.text,
                        style: PastelTextStyles.cardSubtitle.copyWith(
                          color: _textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
            ),
          ),
        );
      },
    ).animate()
      .fadeIn(duration: PastelAnimations.standard)
      .slideX(begin: 0.1, end: 0);
  }
}
