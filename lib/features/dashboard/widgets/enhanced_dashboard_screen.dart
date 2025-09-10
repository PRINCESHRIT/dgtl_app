// Enhanced dashboard screen showcasing integration of all components
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../shared/widgets/cards/empathy_card.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../providers/enhanced_dashboard_provider.dart';
import '../models/dashboard_models.dart';

class EnhancedDashboardScreen extends ConsumerStatefulWidget {
  const EnhancedDashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EnhancedDashboardScreen> createState() => _EnhancedDashboardScreenState();
}

class _EnhancedDashboardScreenState extends ConsumerState<EnhancedDashboardScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(enhancedDashboardProvider);
    
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(enhancedDashboardProvider.notifier).refreshData(),
          color: AppColors.primaryRed,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Enhanced App Bar with empathy greeting
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.empathyGradient,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(AppDimensions.radiusXL),
                        bottomRight: Radius.circular(AppDimensions.radiusXL),
                      ),
                    ),
                    child: Padding(
                      padding: AppDimensions.screenPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'DGTL किडनी केयर',
                            style: AppTextStyles.headerMedium.copyWith(
                              color: AppColors.surfaceWhite,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacingXS),
                          Text(
                            dashboardState.empathyGreeting,
                            style: AppTextStyles.empathyText.copyWith(
                              color: AppColors.surfaceWhite.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Dashboard content
              SliverPadding(
                padding: AppDimensions.screenPadding,
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Quick mood check section
                    _buildMoodSection(dashboardState),
                    
                    const SizedBox(height: AppDimensions.spacingL),
                    
                    // Medical data cards
                    _buildMedicalDataSection(dashboardState),
                    
                    const SizedBox(height: AppDimensions.spacingL),
                    
                    // Quick actions
                    _buildQuickActionsSection(),
                    
                    const SizedBox(height: AppDimensions.spacingL),
                    
                    // AI suggestion card
                    _buildAISuggestionCard(dashboardState),
                    
                    const SizedBox(height: AppDimensions.spacingXXL),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodSection(EnhancedDashboardState state) {
    final moods = [
      MoodData(id: 'happy', label: 'खुश', icon: Icons.sentiment_very_satisfied, color: AppColors.moodHappy),
      MoodData(id: 'calm', label: 'शांत', icon: Icons.sentiment_satisfied, color: AppColors.moodCalm),
      MoodData(id: 'tired', label: 'थका', icon: Icons.sentiment_neutral, color: AppColors.moodTired),
      MoodData(id: 'anxious', label: 'चिंतित', icon: Icons.sentiment_dissatisfied, color: AppColors.moodAnxious),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'आज आप कैसा महसूस कर रहे हैं?',
          style: AppTextStyles.headerSmall,
        ),
        const SizedBox(height: AppDimensions.spacingM),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: moods.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppDimensions.spacingM),
            itemBuilder: (context, index) {
              final mood = moods[index];
              final isSelected = state.currentMood == mood.id;
              
              return GestureDetector(
                onTap: () {
                  ref.read(enhancedDashboardProvider.notifier).updateMood(mood.id);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 80,
                  decoration: BoxDecoration(
                    color: isSelected ? mood.color : AppColors.surfaceWhite,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    border: Border.all(
                      color: mood.color,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: mood.color.withOpacity(0.3),
                        blurRadius: AppDimensions.elevationM,
                        offset: const Offset(0, 2),
                      ),
                    ] : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        mood.icon,
                        color: isSelected ? AppColors.surfaceWhite : mood.color,
                        size: AppDimensions.iconL,
                      ),
                      const SizedBox(height: AppDimensions.spacingXS),
                      Text(
                        mood.label,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isSelected ? AppColors.surfaceWhite : mood.color,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMedicalDataSection(EnhancedDashboardState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'आपका स्वास्थ्य डेटा',
          style: AppTextStyles.headerSmall,
        ),
        const SizedBox(height: AppDimensions.spacingM),
        if (state.isLoading)
          const Center(child: CircularProgressIndicator())
        else
          ...state.medicalCards.map((cardData) {
            return MedicalDataCard(
              label: cardData.label,
              value: cardData.value,
              unit: cardData.unit,
              status: cardData.status,
              icon: cardData.iconData,
              onTap: () {
                // Navigate to detailed view - integrates with your existing navigation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${cardData.label} विस्तार देखें')),
                );
              },
            );
          }).toList(),
      ],
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'त्वरित कार्य',
          style: AppTextStyles.headerSmall,
        ),
        const SizedBox(height: AppDimensions.spacingM),
        Row(
          children: [
            Expanded(
              child: EmpathyButton(
                text: 'लक्षण जोड़ें',
                icon: Icons.add_circle_outline,
                empathyColor: AppColors.empathyTeal,
                isCompact: true,
                onPressed: () {
                  // Navigate to symptom logging - integrates with your existing services
                  ref.read(enhancedDashboardProvider.notifier).recordSymptom('test');
                },
              ),
            ),
            const SizedBox(width: AppDimensions.spacingM),
            Expanded(
              child: EmpathyButton(
                text: 'AI चैट',
                icon: Icons.chat_bubble_outline,
                empathyColor: AppColors.primaryRed,
                isCompact: true,
                onPressed: () {
                  // Navigate to AI chat - integrates with your RAG service
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('AI चैट खुल रहा है...')),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAISuggestionCard(EnhancedDashboardState state) {
    return EmpathyCard(
      title: 'आज की सलाह',
      subtitle: state.moodSuggestion,
      icon: Icons.lightbulb_outline,
      backgroundColor: AppColors.empathyTeal,
      empathyMessage: 'हम आपकी देखभाल में यहाँ हैं',
      onTap: () {
        // Show detailed suggestions from your AI service
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('AI सुझाव देख रहे हैं...')),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
