import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/models/health_data.dart';
import '../../../core/models/ai_response.dart';
import '../../../core/providers/api_provider.dart';

part 'ai_repository.g.dart';

/// AI Recommendations Repository - Manages AI-powered health insights
@riverpod
class AiRepository extends _$AiRepository {
  late ApiClient _apiClient;
  late String _currentUserId;

  @override
  Future<List<AIRecommendation>> build() async {
    _apiClient = ref.read(apiClientProvider);
    _currentUserId = ref.read(currentUserIdProvider);
    
    // Load recent AI recommendations
    return await _loadRecentRecommendations();
  }

  /// Get personalized AI recommendations based on health data
  Future<List<AIRecommendation>> generateRecommendations() async {
    try {
      final request = AIRecommendationRequest(
        userId: _currentUserId,
        includeHealthHistory: true,
        recommendationTypes: ['lifestyle', 'medication', 'monitoring', 'exercise'],
      );

      final response = await _apiClient.getAIRecommendations(request);
      
      if (response.success && response.data != null) {
        // Update local state with new recommendations
        state = AsyncValue.data(response.data!);
        return response.data!;
      } else {
        throw Exception(response.message ?? 'Failed to generate recommendations');
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// Chat with AI about health concerns
  Future<Map<String, dynamic>> chatWithAI(String question) async {
    try {
      final request = AIChatRequest(
        userId: _currentUserId,
        question: question,
        includeHealthContext: true,
        language: 'hindi', // Support Hindi responses
      );

      final response = await _apiClient.chatWithAI(request);
      
      if (response.success && response.data != null) {
        return {
          'success': true,
          'response': response.data!.response,
          'confidence': response.data!.confidence,
          'followUpQuestions': response.data!.followUpQuestions,
          'resources': response.data!.resources,
        };
      } else {
        throw Exception(response.message ?? 'AI chat failed');
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'AI सेवा अनुपलब्ध है। कृपया बाद में पुनः प्रयास करें।',
      };
    }
  }

  /// Load recent AI recommendations from backend
  Future<List<AIRecommendation>> _loadRecentRecommendations() async {
    try {
      final response = await _apiClient.getRecentRecommendations(_currentUserId, 10);
      if (response.success && response.data != null) {
        return response.data!;
      }
      return _getDefaultRecommendations();
    } catch (e) {
      return _getDefaultRecommendations();
    }
  }

  /// Get default recommendations when backend is unavailable
  List<AIRecommendation> _getDefaultRecommendations() {
    return [
      AIRecommendation(
        id: 'default_1',
        title: 'दैनिक BP मॉनिटरिंग',
        description: 'अपने ब्लड प्रेशर की नियमित जांच करें और रिकॉर्ड रखें।',
        category: 'monitoring',
        priority: 'high',
        timestamp: DateTime.now(),
        isCompleted: false,
      ),
      AIRecommendation(
        id: 'default_2',
        title: 'नमक कम करें',
        description: 'दैनिक नमक का सेवन 6 ग्राम से कम रखें।',
        category: 'lifestyle',
        priority: 'medium',
        timestamp: DateTime.now(),
        isCompleted: false,
      ),
      AIRecommendation(
        id: 'default_3',
        title: 'नियमित व्यायाम',
        description: 'दिन में 30 मिनट तेज चहलकदमी करें।',
        category: 'exercise',
        priority: 'medium',
        timestamp: DateTime.now(),
        isCompleted: false,
      ),
    ];
  }

  /// Mark recommendation as completed
  Future<void> markRecommendationCompleted(String recommendationId) async {
    try {
      final response = await _apiClient.markRecommendationCompleted(
        _currentUserId,
        recommendationId,
      );

      if (response.success) {
        // Update local state
        final current = state.value ?? [];
        final updated = current.map((rec) {
          if (rec.id == recommendationId) {
            return rec.copyWith(isCompleted: true);
          }
          return rec;
        }).toList();
        
        state = AsyncValue.data(updated);
      }
    } catch (e) {
      // Handle error silently for now
    }
  }
}

/// AI Chat History Provider
@riverpod
class AiChatHistory extends _$AiChatHistory {
  @override
  List<Map<String, dynamic>> build() {
    return [
      {
        'type': 'assistant',
        'message': 'नमस्ते! मैं आपका AI स्वास्थ्य सहायक हूं। आप कैसा महसूस कर रहे हैं?',
        'timestamp': DateTime.now(),
      },
    ];
  }

  /// Add message to chat history
  void addMessage(String message, String type) {
    final current = state;
    state = [
      ...current,
      {
        'type': type,
        'message': message,
        'timestamp': DateTime.now(),
      },
    ];
  }

  /// Clear chat history
  void clearHistory() {
    state = [
      {
        'type': 'assistant',
        'message': 'नमस्ते! मैं आपका AI स्वास्थ्य सहायक हूं। आप कैसा महसूस कर रहे हैं?',
        'timestamp': DateTime.now(),
      },
    ];
  }
}

/// Active Recommendations Provider (not completed)
@riverpod
List<AIRecommendation> activeRecommendationsProvider(ActiveRecommendationsProviderRef ref) {
  final aiData = ref.watch(aiRepositoryProvider);
  
  return aiData.when(
    loading: () => [],
    error: (_, __) => [],
    data: (recommendations) {
      return recommendations.where((rec) => !rec.isCompleted).toList();
    },
  );
}

/// Recommendation Categories Provider
@riverpod
Map<String, List<AIRecommendation>> recommendationCategoriesProvider(
    RecommendationCategoriesProviderRef ref) {
  final aiData = ref.watch(aiRepositoryProvider);
  
  return aiData.when(
    loading: () => <String, List<AIRecommendation>>{},
    error: (_, __) => <String, List<AIRecommendation>>{},
    data: (recommendations) {
      final categories = <String, List<AIRecommendation>>{};
      
      for (final rec in recommendations) {
        if (!categories.containsKey(rec.category)) {
          categories[rec.category] = [];
        }
        categories[rec.category]!.add(rec);
      }
      
      return categories;
    },
  );
}

/// Health Insights Provider (summary statistics)
@riverpod
Map<String, dynamic> healthInsightsProvider(HealthInsightsProviderRef ref) {
  final aiData = ref.watch(aiRepositoryProvider);
  
  return aiData.when(
    loading: () => _getDefaultInsights(),
    error: (_, __) => _getDefaultInsights(),
    data: (recommendations) {
      final total = recommendations.length;
      final completed = recommendations.where((rec) => rec.isCompleted).length;
      final highPriority = recommendations.where((rec) => rec.priority == 'high').length;
      
      return {
        'totalRecommendations': total,
        'completedRecommendations': completed,
        'completionRate': total > 0 ? (completed / total * 100).round() : 0,
        'highPriorityPending': highPriority,
        'lastUpdated': DateTime.now(),
      };
    },
  );
}

/// Default health insights
Map<String, dynamic> _getDefaultInsights() {
  return {
    'totalRecommendations': 3,
    'completedRecommendations': 0,
    'completionRate': 0,
    'highPriorityPending': 1,
    'lastUpdated': DateTime.now(),
  };
}
