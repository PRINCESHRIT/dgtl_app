import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

/// App State Model
class AppStateModel {
  final bool isLoading;
  final bool isOnline;
  final SyncStatus syncStatus;
  final String? errorMessage;

  const AppStateModel({
    required this.isLoading,
    required this.isOnline,
    required this.syncStatus,
    this.errorMessage,
  });

  AppStateModel copyWith({
    bool? isLoading,
    bool? isOnline,
    SyncStatus? syncStatus,
    String? errorMessage,
  }) {
    return AppStateModel(
      isLoading: isLoading ?? this.isLoading,
      isOnline: isOnline ?? this.isOnline,
      syncStatus: syncStatus ?? this.syncStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Sync Status Enum
enum SyncStatus {
  synced,
  syncing,
  pendingSync,
  error,
}

/// Global App State Provider
@riverpod
class AppState extends _$AppState {
  @override
  AppStateModel build() {
    return const AppStateModel(
      isLoading: false,
      isOnline: true,
      syncStatus: SyncStatus.synced,
    );
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setOnlineStatus(bool online) {
    state = state.copyWith(isOnline: online);
    if (online && state.syncStatus == SyncStatus.pendingSync) {
      // Trigger sync when coming back online
      _triggerSync();
    }
  }

  void setSyncStatus(SyncStatus status) {
    state = state.copyWith(syncStatus: status);
  }

  void setError(String? error) {
    state = state.copyWith(errorMessage: error);
  }

  void _triggerSync() {
    // This will be implemented in Phase 2 with actual sync logic
    setSyncStatus(SyncStatus.syncing);
    // TODO: Implement actual sync logic
    Future.delayed(const Duration(seconds: 2), () {
      setSyncStatus(SyncStatus.synced);
    });
  }
}

/// Connection Status Provider
@riverpod
class ConnectionStatus extends _$ConnectionStatus {
  @override
  bool build() {
    // TODO: Implement actual connectivity checking
    return true; // Assume online for development
  }

  void updateStatus(bool isOnline) {
    state = isOnline;
    ref.read(appStateProvider.notifier).setOnlineStatus(isOnline);
  }
}
