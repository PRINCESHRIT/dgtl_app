import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dgtl_app/app/design_system.dart';

class PolishedPastelCard extends StatefulWidget {
  final Widget child;
  final bool isEmpathy;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final bool enableHover;
  final bool enableGlow;

  const PolishedPastelCard({
    super.key,
    required this.child,
    this.isEmpathy = false,
    this.onTap,
    this.padding,
    this.enableHover = true,
    this.enableGlow = false,
  });

  @override
  State<PolishedPastelCard> createState() => _PolishedPastelCardState();
}

class _PolishedPastelCardState extends State<PolishedPastelCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: PastelAnimations.quick,
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: PastelAnimations.softEase,
    ));
    
    _elevationAnimation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: PastelAnimations.softEase,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool isHovered) {
    if (!widget.enableHover) return;
    
    setState(() {
      _isHovered = isHovered;
    });
    
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHoverChanged(true),
            onExit: (_) => _onHoverChanged(false),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                padding: widget.padding ?? const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: widget.isEmpathy 
                    ? PastelEffects.empathyGradient 
                    : PastelEffects.cardGradient,
                  borderRadius: PastelBorders.card,
                  boxShadow: [
                    ...(_isHovered ? PastelEffects.elevatedShadow : PastelEffects.cardShadow),
                    if (widget.enableGlow && widget.isEmpathy) ...PastelEffects.empathyGlow,
                  ],
                  border: widget.isEmpathy 
                    ? Border.all(
                        color: PastelColors.empathyBorder.withOpacity(_isHovered ? 0.6 : 0.3), 
                        width: _isHovered ? 1.5 : 1
                      )
                    : null,
                ),
                child: widget.child,
              ),
            ),
          ),
        );
      },
    ).animate()
      .fadeIn(duration: PastelAnimations.standard, curve: PastelAnimations.softEase)
      .slideY(begin: 0.1, end: 0, duration: PastelAnimations.standard);
  }
}
