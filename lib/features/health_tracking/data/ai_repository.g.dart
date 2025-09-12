// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeRecommendationsProviderHash() =>
    r'fd3b276715aba06788f3a3bf79c225776a0c39fb';

/// Active Recommendations Provider (not completed)
///
/// Copied from [activeRecommendationsProvider].
@ProviderFor(activeRecommendationsProvider)
final activeRecommendationsProviderProvider =
    AutoDisposeProvider<List<AIRecommendation>>.internal(
  activeRecommendationsProvider,
  name: r'activeRecommendationsProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeRecommendationsProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ActiveRecommendationsProviderRef
    = AutoDisposeProviderRef<List<AIRecommendation>>;
String _$recommendationCategoriesProviderHash() =>
    r'6ae4d1821d4b69711552e64c335e1aa611f897be';

/// Recommendation Categories Provider
///
/// Copied from [recommendationCategoriesProvider].
@ProviderFor(recommendationCategoriesProvider)
final recommendationCategoriesProviderProvider =
    AutoDisposeProvider<Map<String, List<AIRecommendation>>>.internal(
  recommendationCategoriesProvider,
  name: r'recommendationCategoriesProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recommendationCategoriesProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecommendationCategoriesProviderRef
    = AutoDisposeProviderRef<Map<String, List<AIRecommendation>>>;
String _$healthInsightsProviderHash() =>
    r'7450958a7147c07ed0e90137b865a5bad443b2d0';

/// Health Insights Provider (summary statistics)
///
/// Copied from [healthInsightsProvider].
@ProviderFor(healthInsightsProvider)
final healthInsightsProviderProvider =
    AutoDisposeProvider<Map<String, dynamic>>.internal(
  healthInsightsProvider,
  name: r'healthInsightsProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthInsightsProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HealthInsightsProviderRef
    = AutoDisposeProviderRef<Map<String, dynamic>>;
String _$aiRepositoryHash() => r'787b2e535a850da2bce1aca0966d370b94a84abe';

/// AI Recommendations Repository - Manages AI-powered health insights
///
/// Copied from [AiRepository].
@ProviderFor(AiRepository)
final aiRepositoryProvider = AutoDisposeAsyncNotifierProvider<AiRepository,
    List<AIRecommendation>>.internal(
  AiRepository.new,
  name: r'aiRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$aiRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AiRepository = AutoDisposeAsyncNotifier<List<AIRecommendation>>;
String _$aiChatHistoryHash() => r'c6bde49e151ba1418eebd66dcb3b20c3dce5f327';

/// AI Chat History Provider
///
/// Copied from [AiChatHistory].
@ProviderFor(AiChatHistory)
final aiChatHistoryProvider = AutoDisposeNotifierProvider<AiChatHistory,
    List<Map<String, dynamic>>>.internal(
  AiChatHistory.new,
  name: r'aiChatHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aiChatHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AiChatHistory = AutoDisposeNotifier<List<Map<String, dynamic>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
