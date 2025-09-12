import 'embedding_gemma_service.dart';
import 'vector_search_service.dart';
import '../database/database.dart';

/// Basic RAG service for answering questions about patient data
/// Uses rule-based responses with semantic search for immediate functionality
class Gemma3NRagService {
  final EmbeddingGemmaService embeddingService;
  final VectorSearchService vectorSearch;
  final AppDatabase database;
  
  Gemma3NRagService({
    required this.embeddingService,
    required this.vectorSearch,
    required this.database,
  });
  
  /// Answer basic questions about patient data
  Future<String> answerQuestion(String question, int patientId) async {
    print('🤔 Answering: "$question"');
    
    final questionLower = question.toLowerCase();
    
    // Handle lab result questions
    if (questionLower.contains('creatinine') && questionLower.contains('high')) {
      return await _findLastHighCreatinine(patientId);
    }
    
    if (questionLower.contains('last') && questionLower.contains('lab')) {
      return await _getLastLabResults(patientId);
    }
    
    // Handle symptom questions
    if (questionLower.contains('swelling') || questionLower.contains('puffy')) {
      return await _findSimilarSwellingEvents(patientId, question);
    }
    
    if (questionLower.contains('symptom')) {
      return await _getRecentSymptoms(patientId);
    }
    
    // Handle trend questions
    if (questionLower.contains('trend') || questionLower.contains('getting better') || questionLower.contains('getting worse')) {
      return await _analyzeTrends(patientId);
    }
    
    // Default response with available data summary
    return await _getDataSummary(patientId);
  }
  
  /// Find when creatinine was last high
  Future<String> _findLastHighCreatinine(int patientId) async {
    final labResults = await database.getLabResultsForPatient(patientId);
    
    final highCreatinineResults = labResults
        .where((result) => result.status?.toLowerCase().contains('high') == true)
        .toList();
    
    if (highCreatinineResults.isEmpty) {
      return "Good news! I don't see any recent high creatinine readings for Maa. Her kidney function seems stable based on the data we have.";
    }
    
    highCreatinineResults.sort((a, b) => b.testDate.compareTo(a.testDate));
    final lastHigh = highCreatinineResults.first;
    
    final daysSince = DateTime.now().difference(lastHigh.testDate).inDays;
    return "The last time Maa's creatinine was high was $daysSince days ago (${_formatDate(lastHigh.testDate)}). The value was ${lastHigh.value}. Since then, it's important to monitor her kidney function regularly.";
  }
  
  /// Find similar swelling events
  Future<String> _findSimilarSwellingEvents(int patientId, String query) async {
    final similarSymptoms = await vectorSearch.findSimilarSymptoms(
      queryText: query,
      patientId: patientId,
      limit: 3,
    );
    
    if (similarSymptoms.isEmpty) {
      return "This is the first time you've logged swelling for Maa. It's good that you're keeping track! If the swelling persists or gets worse, consider noting when it happens (morning/evening) and any activities that might be related.";
    }
    
    final buffer = StringBuffer();
    buffer.writeln("I found similar events you logged before:");
    
    for (final similar in similarSymptoms) {
      final daysSince = DateTime.now().difference(similar.symptomLog.logDate).inDays;
      buffer.writeln("• ${daysSince} days ago: \"${similar.symptomLog.symptom}\" (${(similar.similarity * 100).round()}% similar)");
    }
    
    buffer.writeln("\nThis pattern might be helpful to discuss with Maa's doctor during the next visit.");
    return buffer.toString();
  }
  
  /// Get recent symptoms summary
  Future<String> _getRecentSymptoms(int patientId) async {
    final recentSymptoms = await database.getRecentSymptoms(patientId, days: 7);
    
    if (recentSymptoms.isEmpty) {
      return "Maa hasn't had any logged symptoms in the past week. That's encouraging! Keep monitoring her daily and log anything new.";
    }
    
    final buffer = StringBuffer();
    buffer.writeln("Here are Maa's symptoms from the past week:");
    
    recentSymptoms.sort((a, b) => b.logDate.compareTo(a.logDate));
    
    for (final symptom in recentSymptoms.take(5)) {
      final daysSince = DateTime.now().difference(symptom.logDate).inDays;
      final timeRef = daysSince == 0 ? "today" : daysSince == 1 ? "yesterday" : "$daysSince days ago";
      buffer.writeln("• $timeRef: ${symptom.symptom} (severity: ${symptom.severity}/10)");
    }
    
    return buffer.toString();
  }
  
  /// Get last lab results
  Future<String> _getLastLabResults(int patientId) async {
    final labResults = await database.getRecentLabResults(patientId, days: 30);
    
    if (labResults.isEmpty) {
      return "I don't see any recent lab results in the past month. When was Maa's last doctor visit? It might be time to schedule a check-up.";
    }
    
    labResults.sort((a, b) => b.testDate.compareTo(a.testDate));
    final recent = labResults.take(3).toList();
    
    final buffer = StringBuffer();
    buffer.writeln("Maa's most recent lab results:");
    
    for (final result in recent) {
      final daysSince = DateTime.now().difference(result.testDate).inDays;
      final status = result.status ?? "normal";
      buffer.writeln("• ${_formatDate(result.testDate)} ($daysSince days ago): ${result.value} - $status");
    }
    
    return buffer.toString();
  }
  
  /// Analyze trends in data
  Future<String> _analyzeTrends(int patientId) async {
    final symptoms = await database.getRecentSymptoms(patientId, days: 14);
    final labs = await database.getRecentLabResults(patientId, days: 30);
    
    final buffer = StringBuffer();
    buffer.writeln("Based on the past 2 weeks:");
    
    if (symptoms.isEmpty && labs.isEmpty) {
      return "I need more data to identify trends. Try logging Maa's daily symptoms and any lab results for a clearer picture.";
    }
    
    // Simple trend analysis
    if (symptoms.length >= 3) {
      final recentSeverity = symptoms.take(3).map((s) => s.severity).reduce((a, b) => a + b) / 3;
      final olderSeverity = symptoms.skip(3).take(3).map((s) => s.severity).reduce((a, b) => a + b) / 3;
      
      if (recentSeverity > olderSeverity + 1) {
        buffer.writeln("⚠️ Maa's symptoms seem to be getting more intense recently.");
      } else if (recentSeverity < olderSeverity - 1) {
        buffer.writeln("✅ Good news! Maa's symptoms appear to be improving.");
      } else {
        buffer.writeln("📊 Maa's symptoms have been fairly stable.");
      }
    }
    
    return buffer.toString();
  }
  
  /// Get general data summary
  Future<String> _getDataSummary(int patientId) async {
    final symptoms = await database.getRecentSymptoms(patientId, days: 30);
    final labs = await database.getRecentLabResults(patientId, days: 30);
    
    return "Here's what I know about Maa:\n"
           "• ${symptoms.length} symptoms logged in the past month\n"
           "• ${labs.length} lab results recorded recently\n"
           "• You can ask me things like:\n"
           "  - 'When was creatinine last high?'\n"
           "  - 'Show me recent symptoms'\n"
           "  - 'Are things getting better or worse?'";
  }
  
  /// Format date for display
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
  
  /// Dispose resources
  Future<void> dispose() async {
    print('✅ Gemma3NRagService disposed');
  }
}
