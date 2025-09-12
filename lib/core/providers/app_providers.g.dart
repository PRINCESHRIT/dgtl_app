// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appStateHash() => r'6b05ee30ec05dea0ef88ed82d3d3fa3190194068';

/// Global App State Provider
///
/// Copied from [AppState].
@ProviderFor(AppState)
final appStateProvider =
    AutoDisposeNotifierProvider<AppState, AppStateModel>.internal(
  AppState.new,
  name: r'appStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppState = AutoDisposeNotifier<AppStateModel>;
String _$connectionStatusHash() => r'81177bc408b56076ca2b63a4efd1f3f9daf6805f';

/// Connection Status Provider
///
/// Copied from [ConnectionStatus].
@ProviderFor(ConnectionStatus)
final connectionStatusProvider =
    AutoDisposeNotifierProvider<ConnectionStatus, bool>.internal(
  ConnectionStatus.new,
  name: r'connectionStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectionStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConnectionStatus = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
