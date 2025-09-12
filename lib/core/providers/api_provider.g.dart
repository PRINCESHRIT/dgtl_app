// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'cfc23bc0586185e0f4e00343f6f777d3893e1392';

/// Dio HTTP Client Provider
///
/// Copied from [dio].
@ProviderFor(dio)
final dioProvider = AutoDisposeProvider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DioRef = AutoDisposeProviderRef<Dio>;
String _$apiClientHash() => r'8d4ee852aede3ba9e985179f2a2fc5ce7b0092c1';

/// API Client Provider
///
/// Copied from [apiClient].
@ProviderFor(apiClient)
final apiClientProvider = AutoDisposeProvider<ApiClient>.internal(
  apiClient,
  name: r'apiClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$apiClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ApiClientRef = AutoDisposeProviderRef<ApiClient>;
String _$currentUserIdHash() => r'2fbbff75ced4efb08d3feab0084e87ee668dbfc0';

/// Current User ID Provider (temporary hardcoded for development)
///
/// Copied from [currentUserId].
@ProviderFor(currentUserId)
final currentUserIdProvider = AutoDisposeProvider<String>.internal(
  currentUserId,
  name: r'currentUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserIdRef = AutoDisposeProviderRef<String>;
String _$authTokenHash() => r'cffa643a70f32acf493a2e55e10181a2bb144834';

/// Auth Token Provider
///
/// Copied from [AuthToken].
@ProviderFor(AuthToken)
final authTokenProvider =
    AutoDisposeNotifierProvider<AuthToken, String?>.internal(
  AuthToken.new,
  name: r'authTokenProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthToken = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
