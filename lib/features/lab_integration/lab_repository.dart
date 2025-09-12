import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';
import 'dart:convert';

import '../../../core/api/api_client.dart';
import '../../../core/models/lab_models.dart';
import '../../../core/providers/api_provider.dart';

part 'lab_repository.g.dart';

/// Lab Integration Repository - Manages lab results and CKD Big 7 tracking
@riverpod
class LabRepository extends _$LabRepository {
  late ApiClient _apiClient;
  late String _currentUserId;
  late Box<LabResult> _labResultsBox;
  late Box<CKDBig7Assessment> _assessmentBox;

  @override
  Future<List<LabResult>> build() async {
    _apiClient = ref.read(apiClientProvider);
    _currentUserId = ref.read(currentUserIdProvider);
    
    // Initialize Hive boxes for offline storage
    _labResultsBox = await Hive.openBox<LabResult>('lab_results');
    _assessmentBox = await Hive.openBox<CKDBig7Assessment>('ckd_assessments');
    
    // Load lab results from backend and cache locally
    return await _loadLabResults();
  }

  /// Load lab results from backend
  Future<List<LabResult>> _loadLabResults() async {
    try {
      final response = await _apiClient.getLabResults(_currentUserId, 12); // Last 12 months
      if (response.success && response.data != null) {
        // Cache lab results locally
        await _labResultsBox.clear();
        for (final result in response.data!) {
          await _labResultsBox.put(result.id, result);
        }
        return response.data!;
      }
      
      // Fallback to cached data
      return _labResultsBox.values.toList();
    } catch (e) {
      // Return cached results on error
      return _labResultsBox.values.toList();
    }
  }

  /// Upload lab report for processing
  Future<String> uploadLabReport(File file) async {
    try {
      // Create multipart request for file upload
      final uploadResponse = await _apiClient.uploadLabReport(_currentUserId, file);
      
      if (uploadResponse.success && uploadResponse.data != null) {
        return uploadResponse.data!.id;
      } else {
        throw Exception(uploadResponse.message ?? 'Upload failed');
      }
    } catch (e) {
      throw Exception('Failed to upload lab report: $e');
    }
  }

  /// Pick and upload lab report
  Future<String?> pickAndUploadLabReport() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.first.path!);
        return await uploadLabReport(file);
      }
      
      return null;
    } catch (e) {
      throw Exception('Failed to pick and upload file: $e');
    }
  }

  /// Get upload status
  Future<LabReportUpload?> getUploadStatus(String uploadId) async {
    try {
      final response = await _apiClient.getLabReportUpload(_currentUserId, uploadId);
      
      if (response.success && response.data != null) {
        return response.data!;
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Add manual lab result
  Future<void> addLabResult(LabResult labResult) async {
    try {
      final response = await _apiClient.addLabResult(labResult);
      
      if (response.success && response.data != null) {
        // Cache locally
        await _labResultsBox.put(labResult.id, response.data!);
        
        // Update state
        final current = state.value ?? [];
        state = AsyncValue.data([response.data!, ...current]);
        
        // Trigger CKD assessment update
        await _updateCKDAssessment();
      } else {
        throw Exception(response.message ?? 'Failed to add lab result');
      }
    } catch (e) {
      // Add to local cache for offline support
      await _labResultsBox.put(labResult.id, labResult);
      
      final current = state.value ?? [];
      state = AsyncValue.data([labResult, ...current]);
      
      rethrow;
    }
  }

  /// Update CKD Big 7 assessment
  Future<void> _updateCKDAssessment() async {
    try {
      final response = await _apiClient.updateCKDAssessment(_currentUserId);
      
      if (response.success && response.data != null) {
        // Cache assessment locally
        await _assessmentBox.put('latest', response.data!);
        
        // Invalidate assessment provider to refresh UI
        ref.invalidate(latestCKDAssessmentProvider);
      }
    } catch (e) {
      // Handle error silently as this is a background update
      print('Failed to update CKD assessment: $e');
    }
  }

  /// Delete lab result
  Future<void> deleteLabResult(String resultId) async {
    try {
      final response = await _apiClient.deleteLabResult(_currentUserId, resultId);
      
      if (response.success) {
        // Remove from local cache
        await _labResultsBox.delete(resultId);
        
        // Update state
        final current = state.value ?? [];
        final updated = current.where((result) => result.id != resultId).toList();
        state = AsyncValue.data(updated);
        
        // Update CKD assessment
        await _updateCKDAssessment();
      }
    } catch (e) {
      // Remove locally for offline support
      await _labResultsBox.delete(resultId);
      
      final current = state.value ?? [];
      final updated = current.where((result) => result.id != resultId).toList();
      state = AsyncValue.data(updated);
      
      rethrow;
    }
  }

  /// Refresh lab results from backend
  Future<void> refreshLabResults() async {
    state = const AsyncValue.loading();
    try {
      final results = await _loadLabResults();
      state = AsyncValue.data(results);
      await _updateCKDAssessment();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Get trend analysis for a parameter
  Future<LabTrendAnalysis?> getParameterTrend(LabParameterType parameterType) async {
    try {
      final response = await _apiClient.getLabTrendAnalysis(
        _currentUserId, 
        parameterType.toString().split('.').last,
      );
      
      if (response.success && response.data != null) {
        return response.data!;
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }
}

/// Latest CKD Big 7 Assessment Provider
@riverpod
Future<CKDBig7Assessment?> latestCKDAssessmentProvider(
    LatestCKDAssessmentProviderRef ref) async {
  final assessmentBox = await Hive.openBox<CKDBig7Assessment>('ckd_assessments');
  final cached = assessmentBox.get('latest');
  
  if (cached != null) {
    return cached;
  }
  
  // Try to fetch from backend
  try {
    final apiClient = ref.read(apiClientProvider);
    final userId = ref.read(currentUserIdProvider);
    
    final response = await apiClient.getLatestCKDAssessment(userId);
    if (response.success && response.data != null) {
      await assessmentBox.put('latest', response.data!);
      return response.data!;
    }
  } catch (e) {
    // Return null if backend fetch fails
  }
  
  return null;
}

/// Lab Results by Parameter Provider
@riverpod
List<LabResult> labResultsByParameterProvider(
    LabResultsByParameterProviderRef ref,
    LabParameterType parameterType) {
  final labResults = ref.watch(labRepositoryProvider);
  
  return labResults.when(
    loading: () => [],
    error: (_, __) => [],
    data: (results) => results
        .where((result) => result.parameterType == parameterType)
        .toList()
      ..sort((a, b) => b.testDate.compareTo(a.testDate)),
  );
}

/// Recent Lab Results Provider (last 30 days)
@riverpod
List<LabResult> recentLabResultsProvider(RecentLabResultsProviderRef ref) {
  final labResults = ref.watch(labRepositoryProvider);
  final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
  
  return labResults.when(
    loading: () => [],
    error: (_, __) => [],
    data: (results) => results
        .where((result) => result.testDate.isAfter(thirtyDaysAgo))
        .toList()
      ..sort((a, b) => b.testDate.compareTo(a.testDate)),
  );
}

/// Critical Lab Results Provider
@riverpod
List<LabResult> criticalLabResultsProvider(CriticalLabResultsProviderRef ref) {
  final labResults = ref.watch(labRepositoryProvider);
  
  return labResults.when(
    loading: () => [],
    error: (_, __) => [],
    data: (results) => results
        .where((result) => result.status.toLowerCase() == 'critical')
        .toList()
      ..sort((a, b) => b.testDate.compareTo(a.testDate)),
  );
}

/// CKD Big 7 Progress Provider
@riverpod
Future<Map<String, dynamic>> ckdBig7ProgressProvider(
    CkdBig7ProgressProviderRef ref) async {
  final assessment = await ref.watch(latestCKDAssessmentProvider.future);
  
  if (assessment == null) {
    return {
      'completionPercentage': 0.0,
      'overallScore': 0,
      'riskLevel': 'unknown',
      'riskLevelHindi': 'अज्ञात',
      'lastUpdated': null,
      'recommendations': <String>[],
    };
  }

  return {
    'completionPercentage': assessment.completionPercentage,
    'overallScore': assessment.overallScore,
    'riskLevel': assessment.riskLevel,
    'riskLevelHindi': assessment.riskLevelInHindi,
    'lastUpdated': assessment.assessmentDate,
    'recommendations': assessment.recommendations,
  };
}

/// Lab Results Summary Provider
@riverpod
Future<Map<String, dynamic>> labResultsSummaryProvider(
    LabResultsSummaryProviderRef ref) async {
  final labResults = ref.watch(labRepositoryProvider);
  
  return labResults.when(
    loading: () => {
      'totalResults': 0,
      'recentResults': 0,
      'criticalResults': 0,
      'lastTestDate': null,
    },
    error: (_, __) => {
      'totalResults': 0,
      'recentResults': 0,
      'criticalResults': 0,
      'lastTestDate': null,
    },
    data: (results) {
      final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
      final recentResults = results
          .where((result) => result.testDate.isAfter(thirtyDaysAgo))
          .length;
      final criticalResults = results
          .where((result) => result.status.toLowerCase() == 'critical')
          .length;
      
      DateTime? lastTestDate;
      if (results.isNotEmpty) {
        final sortedResults = results.toList()
          ..sort((a, b) => b.testDate.compareTo(a.testDate));
        lastTestDate = sortedResults.first.testDate;
      }

      return {
        'totalResults': results.length,
        'recentResults': recentResults,
        'criticalResults': criticalResults,
        'lastTestDate': lastTestDate,
      };
    },
  );
}
