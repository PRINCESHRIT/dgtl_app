import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pastel_colors.dart';
import 'pastel_text_styles.dart';

/// Playful bubble-based analytics to replace rigid charts
/// Color-coded by emotion mapping with animated bubble growth
class BubbleAnalytics extends StatefulWidget {
  final String title;
  final double value;
  final double maxValue;
  final String unit;
  final BubbleAnalyticsType type;
  final String? doodleAsset;
  final bool showAnimation;

  const BubbleAnalytics({
    Key? key,
    required this.title,
    required this.value,
    required this.maxValue,
    required this.unit,
    required this.type,
    this.doodleAsset,
    this.showAnimation = true,
  }) : super(key: key);

  @override
  State<BubbleAnalytics> createState() => _BubbleAnalyticsState();
}

class _BubbleAnalyticsState extends State<BubbleAnalytics>
    with TickerProviderStateMixin {
  late AnimationController _bubbleController;
  late AnimationController _pulseController;
  late Animation<double> _bubbleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _bubbleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _bubbleAnimation = Tween<double>(
      begin: 0.0,
      end: widget.value / widget.maxValue,
    ).animate(CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.elasticOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (widget.showAnimation) {
      _bubbleController.forward();
      _pulseController.repeat(reverse: true);
    } else {
      _bubbleController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Color _getBubbleColor() {
    final percentage = widget.value / widget.maxValue;
    
    switch (widget.type) {
      case BubbleAnalyticsType.bloodPressure:
        if (percentage > 0.8) return PastelColors.anxiousRose;
        if (percentage > 0.6) return PastelColors.worriedYellow;
        return PastelColors.hopefulGreen;
      
      case BubbleAnalyticsType.vitals:
        if (percentage > 0.9 || percentage < 0.3) return PastelColors.anxiousRose;
        if (percentage > 0.7 || percentage < 0.5) return PastelColors.worriedYellow;
        return PastelColors.hopefulGreen;
      
      case BubbleAnalyticsType.progress:
        if (percentage > 0.7) return PastelColors.hopefulGreen;
        if (percentage > 0.4) return PastelColors.calmBlue;
        return PastelColors.worriedYellow;
      
      case BubbleAnalyticsType.positive:
        return PastelColors.hopefulGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Text(
            widget.title,
            style: PastelTextStyles.cardSubtitle,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 12),
          
          // Bubble with doodle center
          AnimatedBuilder(
            animation: Listenable.merge([_bubbleAnimation, _pulseAnimation]),
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _getBubbleColor().withOpacity(0.2),
                    border: Border.all(
                      color: _getBubbleColor(),
                      width: 3,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Animated fill
                      ClipOval(
                        child: Container(
                          width: 74,
                          height: 74,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 74 * _bubbleAnimation.value,
                                width: 74,
                                decoration: BoxDecoration(
                                  color: _getBubbleColor().withOpacity(0.4),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(37),
                                    bottomRight: Radius.circular(37),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Doodle or icon in center
                      if (widget.doodleAsset != null)
                        SvgPicture.asset(
                          widget.doodleAsset!,
                          width: 30,
                          height: 30,
                          color: _getBubbleColor(),
                        )
                      else
                        Icon(
                          _getIconForType(widget.type),
                          color: _getBubbleColor(),
                          size: 24,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 8),
          
          // Value display
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: widget.value.toStringAsFixed(1),
              style: PastelTextStyles.numberDisplay.copyWith(
                fontSize: 20,
                color: _getBubbleColor(),
              ),
              children: [
                TextSpan(
                  text: ' ${widget.unit}',
                  style: PastelTextStyles.cardSubtitle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          // Progress percentage
          Text(
            '${(widget.value / widget.maxValue * 100).round()}%',
            style: PastelTextStyles.cardSubtitle.copyWith(
              fontSize: 10,
              color: _getBubbleColor(),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(BubbleAnalyticsType type) {
    switch (type) {
      case BubbleAnalyticsType.bloodPressure:
        return Icons.favorite_outline;
      case BubbleAnalyticsType.vitals:
        return Icons.monitor_heart_outlined;
      case BubbleAnalyticsType.progress:
        return Icons.trending_up_outlined;
      case BubbleAnalyticsType.positive:
        return Icons.mood_outlined;
    }
  }
}

/// Multi-bubble display for comparing multiple values
class MultiBubbleAnalytics extends StatelessWidget {
  final List<BubbleData> bubbles;
  final String title;
  final CrossAxisAlignment alignment;

  const MultiBubbleAnalytics({
    Key? key,
    required this.bubbles,
    required this.title,
    this.alignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PastelColors.softWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: PastelColors.neutralGray.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            title,
            style: PastelTextStyles.cardTitle,
          ),
          
          const SizedBox(height: 16),
          
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: bubbles
                .asMap()
                .entries
                .map((entry) {
                  final index = entry.key;
                  final bubble = entry.value;
                  
                  return BubbleAnalytics(
                    title: bubble.title,
                    value: bubble.value,
                    maxValue: bubble.maxValue,
                    unit: bubble.unit,
                    type: bubble.type,
                    doodleAsset: bubble.doodleAsset,
                  )
                      .animate(delay: (index * 200).ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.3, duration: 400.ms);
                })
                .toList(),
          ),
        ],
      ),
    );
  }
}

/// Bubble progress ring for circular progress display
class BubbleProgressRing extends StatefulWidget {
  final double progress; // 0.0 to 1.0
  final String centerText;
  final String subtitle;
  final Color? color;
  final double size;

  const BubbleProgressRing({
    Key? key,
    required this.progress,
    required this.centerText,
    required this.subtitle,
    this.color,
    this.size = 120,
  }) : super(key: key);

  @override
  State<BubbleProgressRing> createState() => _BubbleProgressRingState();
}

class _BubbleProgressRingState extends State<BubbleProgressRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? PastelColors.calmBlue;
    
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: BubbleProgressPainter(
              progress: _animation.value,
              color: color,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.centerText,
                    style: PastelTextStyles.numberDisplay.copyWith(
                      fontSize: 24,
                      color: color,
                    ),
                  ),
                  Text(
                    widget.subtitle,
                    style: PastelTextStyles.cardSubtitle.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BubbleProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  BubbleProgressPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 8;
    
    // Background circle
    final backgroundPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    
    canvas.drawCircle(center, radius, backgroundPaint);
    
    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    
    const startAngle = -3.14159 / 2; // Start from top
    final sweepAngle = 2 * 3.14159 * progress;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(BubbleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

enum BubbleAnalyticsType {
  bloodPressure,
  vitals,
  progress,
  positive,
}

class BubbleData {
  final String title;
  final double value;
  final double maxValue;
  final String unit;
  final BubbleAnalyticsType type;
  final String? doodleAsset;

  BubbleData({
    required this.title,
    required this.value,
    required this.maxValue,
    required this.unit,
    required this.type,
    this.doodleAsset,
  });
}
