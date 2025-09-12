// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$latestCKDAssessmentProviderHash() =>
    r'c5e8f7b820d2d67aa539a0bda4202e3ce958c53d';

/// Latest CKD Big 7 Assessment Provider
///
/// Copied from [latestCKDAssessmentProvider].
@ProviderFor(latestCKDAssessmentProvider)
final latestCKDAssessmentProviderProvider =
    AutoDisposeFutureProvider<CKDBig7Assessment?>.internal(
  latestCKDAssessmentProvider,
  name: r'latestCKDAssessmentProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestCKDAssessmentProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LatestCKDAssessmentProviderRef
    = AutoDisposeFutureProviderRef<CKDBig7Assessment?>;
String _$labResultsByParameterProviderHash() =>
    r'eadf62cb3a54b234a6c4c25892788cdd1b4d96bf';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Lab Results by Parameter Provider
///
/// Copied from [labResultsByParameterProvider].
@ProviderFor(labResultsByParameterProvider)
const labResultsByParameterProviderProvider =
    LabResultsByParameterProviderFamily();

/// Lab Results by Parameter Provider
///
/// Copied from [labResultsByParameterProvider].
class LabResultsByParameterProviderFamily extends Family<List<LabResult>> {
  /// Lab Results by Parameter Provider
  ///
  /// Copied from [labResultsByParameterProvider].
  const LabResultsByParameterProviderFamily();

  /// Lab Results by Parameter Provider
  ///
  /// Copied from [labResultsByParameterProvider].
  LabResultsByParameterProviderProvider call(
    LabParameterType parameterType,
  ) {
    return LabResultsByParameterProviderProvider(
      parameterType,
    );
  }

  @override
  LabResultsByParameterProviderProvider getProviderOverride(
    covariant LabResultsByParameterProviderProvider provider,
  ) {
    return call(
      provider.parameterType,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'labResultsByParameterProviderProvider';
}

/// Lab Results by Parameter Provider
///
/// Copied from [labResultsByParameterProvider].
class LabResultsByParameterProviderProvider
    extends AutoDisposeProvider<List<LabResult>> {
  /// Lab Results by Parameter Provider
  ///
  /// Copied from [labResultsByParameterProvider].
  LabResultsByParameterProviderProvider(
    LabParameterType parameterType,
  ) : this._internal(
          (ref) => labResultsByParameterProvider(
            ref as LabResultsByParameterProviderRef,
            parameterType,
          ),
          from: labResultsByParameterProviderProvider,
          name: r'labResultsByParameterProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$labResultsByParameterProviderHash,
          dependencies: LabResultsByParameterProviderFamily._dependencies,
          allTransitiveDependencies:
              LabResultsByParameterProviderFamily._allTransitiveDependencies,
          parameterType: parameterType,
        );

  LabResultsByParameterProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parameterType,
  }) : super.internal();

  final LabParameterType parameterType;

  @override
  Override overrideWith(
    List<LabResult> Function(LabResultsByParameterProviderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LabResultsByParameterProviderProvider._internal(
        (ref) => create(ref as LabResultsByParameterProviderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parameterType: parameterType,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<LabResult>> createElement() {
    return _LabResultsByParameterProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LabResultsByParameterProviderProvider &&
        other.parameterType == parameterType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parameterType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LabResultsByParameterProviderRef
    on AutoDisposeProviderRef<List<LabResult>> {
  /// The parameter `parameterType` of this provider.
  LabParameterType get parameterType;
}

class _LabResultsByParameterProviderProviderElement
    extends AutoDisposeProviderElement<List<LabResult>>
    with LabResultsByParameterProviderRef {
  _LabResultsByParameterProviderProviderElement(super.provider);

  @override
  LabParameterType get parameterType =>
      (origin as LabResultsByParameterProviderProvider).parameterType;
}

String _$recentLabResultsProviderHash() =>
    r'46730bcddb8b1801996b6eb65d5f101dead91488';

/// Recent Lab Results Provider (last 30 days)
///
/// Copied from [recentLabResultsProvider].
@ProviderFor(recentLabResultsProvider)
final recentLabResultsProviderProvider =
    AutoDisposeProvider<List<LabResult>>.internal(
  recentLabResultsProvider,
  name: r'recentLabResultsProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentLabResultsProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecentLabResultsProviderRef = AutoDisposeProviderRef<List<LabResult>>;
String _$criticalLabResultsProviderHash() =>
    r'd22e5e79a68fdc32dff4b572b5a35321cf21e330';

/// Critical Lab Results Provider
///
/// Copied from [criticalLabResultsProvider].
@ProviderFor(criticalLabResultsProvider)
final criticalLabResultsProviderProvider =
    AutoDisposeProvider<List<LabResult>>.internal(
  criticalLabResultsProvider,
  name: r'criticalLabResultsProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$criticalLabResultsProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CriticalLabResultsProviderRef = AutoDisposeProviderRef<List<LabResult>>;
String _$ckdBig7ProgressProviderHash() =>
    r'1360da1af69c238d61dc0a62605e8a268d8f82d3';

/// CKD Big 7 Progress Provider
///
/// Copied from [ckdBig7ProgressProvider].
@ProviderFor(ckdBig7ProgressProvider)
final ckdBig7ProgressProviderProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
  ckdBig7ProgressProvider,
  name: r'ckdBig7ProgressProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ckdBig7ProgressProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CkdBig7ProgressProviderRef
    = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$labResultsSummaryProviderHash() =>
    r'00dba183b05fb36385e9668564e0b56d6d2c3dfe';

/// Lab Results Summary Provider
///
/// Copied from [labResultsSummaryProvider].
@ProviderFor(labResultsSummaryProvider)
final labResultsSummaryProviderProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
  labResultsSummaryProvider,
  name: r'labResultsSummaryProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$labResultsSummaryProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LabResultsSummaryProviderRef
    = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$labRepositoryHash() => r'a45588823c603a422a95de7af9867dbe04450874';

/// Lab Integration Repository - Manages lab results and CKD Big 7 tracking
///
/// Copied from [LabRepository].
@ProviderFor(LabRepository)
final labRepositoryProvider =
    AutoDisposeAsyncNotifierProvider<LabRepository, List<LabResult>>.internal(
  LabRepository.new,
  name: r'labRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$labRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LabRepository = AutoDisposeAsyncNotifier<List<LabResult>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
