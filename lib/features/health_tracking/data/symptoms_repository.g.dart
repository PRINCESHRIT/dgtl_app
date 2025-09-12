// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptoms_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$symptomsAnalyticsProviderHash() =>
    r'b44050e413e6e4bbdcd51e69094fbe0c9ca8443a';

/// Symptoms Analytics Provider
///
/// Copied from [symptomsAnalyticsProvider].
@ProviderFor(symptomsAnalyticsProvider)
final symptomsAnalyticsProviderProvider =
    AutoDisposeProvider<Map<String, dynamic>>.internal(
  symptomsAnalyticsProvider,
  name: r'symptomsAnalyticsProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$symptomsAnalyticsProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SymptomsAnalyticsProviderRef
    = AutoDisposeProviderRef<Map<String, dynamic>>;
String _$recentSymptomsDisplayProviderHash() =>
    r'652e66382623c7523bd2a48411500099347d9867';

/// Recent Symptoms Provider (for display in UI)
///
/// Copied from [recentSymptomsDisplayProvider].
@ProviderFor(recentSymptomsDisplayProvider)
final recentSymptomsDisplayProviderProvider =
    AutoDisposeProvider<List<Map<String, dynamic>>>.internal(
  recentSymptomsDisplayProvider,
  name: r'recentSymptomsDisplayProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentSymptomsDisplayProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecentSymptomsDisplayProviderRef
    = AutoDisposeProviderRef<List<Map<String, dynamic>>>;
String _$commonSymptomsProviderHash() =>
    r'3ebfb530b7d51074f73240aaaa48b406828b6922';

/// Common Symptoms Provider for quick selection
///
/// Copied from [commonSymptomsProvider].
@ProviderFor(commonSymptomsProvider)
final commonSymptomsProviderProvider =
    AutoDisposeProvider<List<Map<String, String>>>.internal(
  commonSymptomsProvider,
  name: r'commonSymptomsProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$commonSymptomsProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CommonSymptomsProviderRef
    = AutoDisposeProviderRef<List<Map<String, String>>>;
String _$symptomsRepositoryHash() =>
    r'bc9dd4e31a0fd9773fa14e551570ee4721aa6aa0';

/// Symptoms Tracking Repository - Manages symptom logging and analysis
///
/// Copied from [SymptomsRepository].
@ProviderFor(SymptomsRepository)
final symptomsRepositoryProvider = AutoDisposeAsyncNotifierProvider<
    SymptomsRepository, List<HealthSymptoms>>.internal(
  SymptomsRepository.new,
  name: r'symptomsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$symptomsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SymptomsRepository = AutoDisposeAsyncNotifier<List<HealthSymptoms>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
