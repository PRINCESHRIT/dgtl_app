// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$predictiveInsightsProviderHash() =>
    r'bdd97568f629b1a4a1f7303b376122e73ead3833';

/// Predictive Insights Provider
///
/// Copied from [predictiveInsightsProvider].
@ProviderFor(predictiveInsightsProvider)
final predictiveInsightsProviderProvider =
    AutoDisposeFutureProvider<List<PredictiveInsight>>.internal(
  predictiveInsightsProvider,
  name: r'predictiveInsightsProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$predictiveInsightsProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PredictiveInsightsProviderRef
    = AutoDisposeFutureProviderRef<List<PredictiveInsight>>;
String _$healthScoreTrendsProviderHash() =>
    r'ddaba4e8dee961c0279436fccc7df1d4043c02f9';

/// Health Score Trends Provider
///
/// Copied from [healthScoreTrendsProvider].
@ProviderFor(healthScoreTrendsProvider)
final healthScoreTrendsProviderProvider =
    AutoDisposeFutureProvider<Map<String, List<Map<String, dynamic>>>>.internal(
  healthScoreTrendsProvider,
  name: r'healthScoreTrendsProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthScoreTrendsProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HealthScoreTrendsProviderRef
    = AutoDisposeFutureProviderRef<Map<String, List<Map<String, dynamic>>>>;
String _$riskFactorsProviderHash() =>
    r'd3ac8f44a28812abf8f5b4117767a1a021c92ac7';

/// Risk Factors Provider
///
/// Copied from [riskFactorsProvider].
@ProviderFor(riskFactorsProvider)
final riskFactorsProviderProvider =
    AutoDisposeFutureProvider<List<Map<String, dynamic>>>.internal(
  riskFactorsProvider,
  name: r'riskFactorsProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$riskFactorsProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RiskFactorsProviderRef
    = AutoDisposeFutureProviderRef<List<Map<String, dynamic>>>;
String _$analyticsRepositoryHash() =>
    r'42eebae8aab60e3255b6bb0722acf981396ac985';

/// Analytics Repository - Manages health analytics and predictions
///
/// Copied from [AnalyticsRepository].
@ProviderFor(AnalyticsRepository)
final analyticsRepositoryProvider = AutoDisposeAsyncNotifierProvider<
    AnalyticsRepository, HealthAnalytics?>.internal(
  AnalyticsRepository.new,
  name: r'analyticsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$analyticsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AnalyticsRepository = AutoDisposeAsyncNotifier<HealthAnalytics?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
