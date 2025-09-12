// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeMedicationsProviderHash() =>
    r'f7c16faf53f13f51c59220f6565866100f5a09ea';

/// Active medications provider
///
/// Copied from [activeMedicationsProvider].
@ProviderFor(activeMedicationsProvider)
final activeMedicationsProviderProvider =
    AutoDisposeProvider<List<Medication>>.internal(
  activeMedicationsProvider,
  name: r'activeMedicationsProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeMedicationsProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ActiveMedicationsProviderRef = AutoDisposeProviderRef<List<Medication>>;
String _$todaysMedicationScheduleProviderHash() =>
    r'84ff1ede8e49fe2a40016ba9f2fb6b0bd7b927eb';

/// Today's medication schedule provider
///
/// Copied from [todaysMedicationScheduleProvider].
@ProviderFor(todaysMedicationScheduleProvider)
final todaysMedicationScheduleProviderProvider =
    AutoDisposeProvider<List<Map<String, dynamic>>>.internal(
  todaysMedicationScheduleProvider,
  name: r'todaysMedicationScheduleProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todaysMedicationScheduleProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodaysMedicationScheduleProviderRef
    = AutoDisposeProviderRef<List<Map<String, dynamic>>>;
String _$medicationAdherenceStatsProviderHash() =>
    r'0c2c21f971ff4e2f9bf0e6e7914aceeb46bf6005';

/// Medication adherence statistics provider
///
/// Copied from [medicationAdherenceStatsProvider].
@ProviderFor(medicationAdherenceStatsProvider)
final medicationAdherenceStatsProviderProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
  medicationAdherenceStatsProvider,
  name: r'medicationAdherenceStatsProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$medicationAdherenceStatsProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MedicationAdherenceStatsProviderRef
    = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$medicationRepositoryHash() =>
    r'c25ef8cc6f3e8735482d017b9ce7e01dcf918959';

/// Medication Repository - Manages medications and adherence
///
/// Copied from [MedicationRepository].
@ProviderFor(MedicationRepository)
final medicationRepositoryProvider = AutoDisposeAsyncNotifierProvider<
    MedicationRepository, List<Medication>>.internal(
  MedicationRepository.new,
  name: r'medicationRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$medicationRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MedicationRepository = AutoDisposeAsyncNotifier<List<Medication>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
