import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'pastel_colors.dart';
import 'pastel_text_styles.dart';

/// Pastel Card Container with soft shadows and animations
class PastelCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final bool showAnimation;

  const PastelCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.width,
    this.height,
    this.onTap,
    this.showAnimation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: backgroundColor != null
            ? null
            : PastelColors.cardGradient,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: PastelColors.mutedBlack.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: PastelColors.softWhite.withOpacity(0.8),
            blurRadius: 10,
            offset: const Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      card = GestureDetector(
        onTap: onTap,
        child: card,
      );
    }

    if (showAnimation) {
      return card
          .animate()
          .fadeIn(duration: 600.ms, curve: Curves.easeOut)
          .slideY(begin: 0.1, duration: 600.ms, curve: Curves.easeOut);
    }

    return card;
  }
}

/// Bubble-style button for interactive elements
class BubbleButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final bool isCompact;

  const BubbleButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.isCompact = false,
  }) : super(key: key);

  @override
  State<BubbleButton> createState() => _BubbleButtonState();
}

class _BubbleButtonState extends State<BubbleButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final padding = widget.isCompact 
        ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
        : const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
        
    final textStyle = widget.isCompact
        ? PastelTextStyles.buttonText.copyWith(fontSize: 14)
        : PastelTextStyles.buttonText;
    
    return SizedBox(
      width: widget.width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? PastelColors.softWhite,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: PastelColors.neutralGray.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: _isPressed ? [] : [
                BoxShadow(
                  color: PastelColors.neutralGray.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                widget.text,
                style: widget.textColor != null 
                    ? textStyle.copyWith(color: widget.textColor)
                    : textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    )
        .animate(target: _isPressed ? 0.95 : 1.0)
        .scale(duration: 100.ms, curve: Curves.easeInOut);
  }
}

/// Circular bubble button for numeric keypad
class CircleBubbleButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double size;
  final bool isSelected;

  const CircleBubbleButton({
    Key? key,
    required this.text,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.size = 60,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<CircleBubbleButton> createState() => _CircleBubbleButtonState();
}

class _CircleBubbleButtonState extends State<CircleBubbleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap?.call();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                gradient: widget.isSelected
                    ? LinearGradient(
                        colors: [
                          PastelColors.warmSaffron,
                          PastelColors.warmSaffron.withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : PastelColors.bubbleGradient,
                color: widget.backgroundColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: PastelColors.mutedBlack.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  BoxShadow(
                    color: PastelColors.softWhite.withOpacity(0.9),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: widget.textColor ?? PastelColors.mutedBlack,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Bubble progress indicator for analytics
class BubbleProgress extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String centerText;
  final Color? bubbleColor;
  final double size;

  const BubbleProgress({
    Key? key,
    required this.progress,
    required this.centerText,
    this.bubbleColor,
    this.size = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: PastelColors.bubbleGradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: PastelColors.mutedBlack.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size - 10,
            height: size - 10,
            child: CircularProgressIndicator(
              value: progress,
              backgroundColor: PastelColors.mutedBlack.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(
                bubbleColor ?? PastelColors.hopefulGreen,
              ),
              strokeWidth: 3,
            ),
          ),
          Text(
            centerText,
            style: TextStyle(
              fontSize: size * 0.2,
              fontWeight: FontWeight.w600,
              color: PastelColors.mutedBlack,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    )
        .animate()
        .scale(
          duration: 800.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 600.ms);
  }
}
