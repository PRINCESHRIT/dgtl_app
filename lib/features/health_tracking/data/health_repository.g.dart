// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bpHistoryProviderHash() => r'ba53b9c951a64b17fa6c7b5750e4d4685ee02e45';

/// BP History Provider (last 7 readings for chart)
///
/// Copied from [bpHistoryProvider].
@ProviderFor(bpHistoryProvider)
final bpHistoryProviderProvider =
    AutoDisposeProvider<List<Map<String, dynamic>>>.internal(
  bpHistoryProvider,
  name: r'bpHistoryProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bpHistoryProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BpHistoryProviderRef
    = AutoDisposeProviderRef<List<Map<String, dynamic>>>;
String _$bpTrendDataProviderHash() =>
    r'f3f76fe52789d11dc01cd049c2488e3c550830fa';

/// BP Trend Data Provider for enhanced visualization
///
/// Copied from [bpTrendDataProvider].
@ProviderFor(bpTrendDataProvider)
final bpTrendDataProviderProvider =
    AutoDisposeProvider<Map<String, dynamic>>.internal(
  bpTrendDataProvider,
  name: r'bpTrendDataProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bpTrendDataProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BpTrendDataProviderRef = AutoDisposeProviderRef<Map<String, dynamic>>;
String _$healthRepositoryHash() => r'987329a7ecf94768d59a4b1e2b5496e05c1f2f10';

/// Health Data Repository - Manages BP readings, symptoms, and vitals
///
/// Copied from [HealthRepository].
@ProviderFor(HealthRepository)
final healthRepositoryProvider = AutoDisposeAsyncNotifierProvider<
    HealthRepository, List<BPReading>>.internal(
  HealthRepository.new,
  name: r'healthRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HealthRepository = AutoDisposeAsyncNotifier<List<BPReading>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
