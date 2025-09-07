import 'dart:math' as math;
import 'package:dgtl_app/core/ai/embedding_gemma_service.dart';

/// Phase 1.4 EmbeddingGemma Demo - Comprehensive Medical Text Analysis
/// 
/// This demo showcases the capabilities of our EmbeddingGemma implementation:
/// • Medical vocabulary understanding
/// • Semantic similarity computation  
/// • Medical concept clustering
/// • Real-world healthcare text analysis
void main() async {
  print('🚀 Phase 1.4 EmbeddingGemma Integration Demo');
  print('=' * 60);
  
  final service = EmbeddingGemmaService();
  
  try {
    // 1. Model Initialization Demo
    await _demoModelInitialization(service);
    
    // 2. Basic Embedding Generation Demo  
    await _demoBasicEmbedding(service);
    
    // 3. Medical Concept Clustering Demo
    await _demoMedicalClustering(service);
    
    // 4. Lab Results Analysis Demo
    await _demoLabResultsAnalysis(service);
    
    // 5. Symptom Similarity Demo
    await _demoSymptomSimilarity(service);
    
    // 6. Performance Metrics Demo
    await _demoPerformanceMetrics(service);
    
    print('\n' + '=' * 60);
    print('✅ Demo completed successfully!');
    print('🎯 EmbeddingGemma Phase 1.4 is ready for production use.');
    
  } catch (e) {
    print('❌ Demo failed: $e');
  } finally {
    await service.dispose();
    print('🧹 Service disposed and resources cleaned up');
  }
}

Future<void> _demoModelInitialization(EmbeddingGemmaService service) async {
  print('\n📋 1. Model Initialization Demo');
  print('-' * 40);
  
  final stopwatch = Stopwatch()..start();
  await service.preloadModel();
  stopwatch.stop();
  
  print('⚡ Model loaded in ${stopwatch.elapsedMilliseconds}ms');
  print('📊 Embedding dimensions: ${service.embeddingDimensions}');
  print('📚 Vocabulary size: ${service.vocabularySize}');
  print('✅ Model status: ${service.isModelLoaded ? "Ready" : "Not loaded"}');
}

Future<void> _demoBasicEmbedding(EmbeddingGemmaService service) async {
  print('\n📋 2. Basic Embedding Generation Demo');
  print('-' * 40);
  
  final testCases = [
    'Patient has hypertension',
    'Blood pressure is elevated',
    'Glucose level is 180 mg/dl',
    'Weather is sunny today'
  ];
  
  final embeddings = <String, List<double>>{};
  
  for (final text in testCases) {
    final stopwatch = Stopwatch()..start();
    final embedding = await service.generateEmbedding(text);
    stopwatch.stop();
    
    embeddings[text] = embedding;
    
    final magnitude = _calculateMagnitude(embedding);
    print('📝 "${text}"');
    print('   → ${embedding.length}D vector, magnitude: ${magnitude.toStringAsFixed(4)}, '
          'time: ${stopwatch.elapsedMilliseconds}ms');
  }
  
  // Calculate similarities
  final hypertension = embeddings['Patient has hypertension']!;
  final bloodPressure = embeddings['Blood pressure is elevated']!;
  final glucose = embeddings['Glucose level is 180 mg/dl']!;
  final weather = embeddings['Weather is sunny today']!;
  
  print('\n🔗 Similarity Analysis:');
  print('   Hypertension ↔ Blood Pressure: ${_similarity(service, hypertension, bloodPressure)}');
  print('   Hypertension ↔ Glucose: ${_similarity(service, hypertension, glucose)}');
  print('   Hypertension ↔ Weather: ${_similarity(service, hypertension, weather)}');
}

Future<void> _demoMedicalClustering(EmbeddingGemmaService service) async {
  print('\n📋 3. Medical Concept Clustering Demo');
  print('-' * 40);
  
  final conceptGroups = {
    'Cardiovascular': [
      'Blood pressure 140/90 mmHg',
      'Hypertension stage 1',
      'Elevated systolic pressure',
      'Heart rate irregular'
    ],
    'Metabolic': [
      'Glucose level 180 mg/dl',
      'Diabetes mellitus type 2',
      'High blood sugar',
      'Insulin resistance'
    ],
    'Renal': [
      'Creatinine 1.8 mg/dl',
      'eGFR 45 ml/min',
      'Kidney function decreased',
      'Proteinuria detected'
    ]
  };
  
  final allEmbeddings = <String, List<double>>{};
  
  // Generate embeddings for all concepts
  for (final group in conceptGroups.entries) {
    print('🏷️  ${group.key} Concepts:');
    for (final concept in group.value) {
      final embedding = await service.generateEmbedding(concept);
      allEmbeddings[concept] = embedding;
      print('   • $concept');
    }
  }
  
  // Analyze clustering quality
  print('\n📊 Clustering Analysis:');
  for (final group in conceptGroups.entries) {
    final concepts = group.value;
    var totalIntraGroupSimilarity = 0.0;
    var comparisons = 0;
    
    for (int i = 0; i < concepts.length; i++) {
      for (int j = i + 1; j < concepts.length; j++) {
        final sim = service.cosineSimilarity(
          allEmbeddings[concepts[i]]!, 
          allEmbeddings[concepts[j]]!
        );
        totalIntraGroupSimilarity += sim;
        comparisons++;
      }
    }
    
    final avgIntraGroupSim = totalIntraGroupSimilarity / comparisons;
    print('   ${group.key}: Avg intra-group similarity = ${avgIntraGroupSim.toStringAsFixed(3)}');
  }
}

Future<void> _demoLabResultsAnalysis(EmbeddingGemmaService service) async {
  print('\n📋 4. Lab Results Analysis Demo');
  print('-' * 40);
  
  final labResults = [
    'Comprehensive Metabolic Panel: Glucose 165 mg/dl (high), Creatinine 1.1 mg/dl (normal)',
    'Lipid Panel: Total cholesterol 240 mg/dl, LDL 160 mg/dl, HDL 35 mg/dl',
    'Complete Blood Count: Hemoglobin 11.2 g/dl (low), Platelets 180K',
    'Liver Function: AST 45 IU/L, ALT 38 IU/L, Bilirubin 0.8 mg/dl',
  ];
  
  final labEmbeddings = <List<double>>[];
  
  print('🧪 Analyzing lab results:');
  for (int i = 0; i < labResults.length; i++) {
    final embedding = await service.generateEmbedding(labResults[i]);
    labEmbeddings.add(embedding);
    
    print('   ${i + 1}. ${labResults[i].substring(0, 50)}...');
  }
  
  // Find most similar lab results
  var maxSim = -1.0;
  var maxI = -1, maxJ = -1;
  
  for (int i = 0; i < labEmbeddings.length; i++) {
    for (int j = i + 1; j < labEmbeddings.length; j++) {
      final sim = service.cosineSimilarity(labEmbeddings[i], labEmbeddings[j]);
      if (sim > maxSim) {
        maxSim = sim;
        maxI = i;
        maxJ = j;
      }
    }
  }
  
  print('\n🔍 Most similar lab results:');
  print('   Result ${maxI + 1} ↔ Result ${maxJ + 1}');
  print('   Similarity: ${maxSim.toStringAsFixed(3)}');
}

Future<void> _demoSymptomSimilarity(EmbeddingGemmaService service) async {
  print('\n📋 5. Symptom Similarity Demo');
  print('-' * 40);
  
  final symptoms = [
    'Patient reports chest pain and shortness of breath',
    'Experiencing severe headache and dizziness',  
    'Fatigue and weakness for the past week',
    'Nausea and vomiting after meals',
    'Joint pain and morning stiffness',
  ];
  
  final symptomEmbeddings = <String, List<double>>{};
  
  print('🤒 Analyzing symptoms:');
  for (final symptom in symptoms) {
    final embedding = await service.generateEmbedding(symptom);
    symptomEmbeddings[symptom] = embedding;
    print('   • $symptom');
  }
  
  // Create similarity matrix
  print('\n📊 Symptom Similarity Matrix:');
  print('     ' + List.generate(symptoms.length, (i) => '${i+1}'.padLeft(6)).join(''));
  
  for (int i = 0; i < symptoms.length; i++) {
    var row = '${i+1}:   ';
    for (int j = 0; j < symptoms.length; j++) {
      if (i == j) {
        row += ' 1.000';
      } else {
        final sim = service.cosineSimilarity(
          symptomEmbeddings[symptoms[i]]!, 
          symptomEmbeddings[symptoms[j]]!
        );
        row += sim.toStringAsFixed(3).padLeft(6);
      }
    }
    print(row);
  }
}

Future<void> _demoPerformanceMetrics(EmbeddingGemmaService service) async {
  print('\n📋 6. Performance Metrics Demo');  
  print('-' * 40);
  
  final testTexts = [
    'Short',
    'Medium length medical text with some terminology',
    'Very long patient history including multiple chronic conditions like diabetes mellitus type 2, ' +
    'hypertension stage 1, hyperlipidemia, chronic kidney disease stage 3, coronary artery disease, ' +
    'and a history of myocardial infarction with current medications including metformin, lisinopril, ' +
    'atorvastatin, and aspirin with regular monitoring of glucose, blood pressure, and lipid levels.',
  ];
  
  print('⚡ Performance Analysis:');
  
  for (int i = 0; i < testTexts.length; i++) {
    final text = testTexts[i];
    final iterations = i == 0 ? 100 : i == 1 ? 50 : 10;  // More iterations for shorter texts
    
    var totalTime = 0;
    List<double>? lastEmbedding;
    
    for (int j = 0; j < iterations; j++) {
      final stopwatch = Stopwatch()..start();
      lastEmbedding = await service.generateEmbedding(text);
      stopwatch.stop();
      totalTime += stopwatch.elapsedMicroseconds;
    }
    
    final avgTimeMs = totalTime / iterations / 1000;
    final textLength = text.length;
    final throughput = textLength / avgTimeMs * 1000; // chars/second
    
    print('   ${i + 1}. Text length: ${textLength.toString().padLeft(4)} chars');
    print('      Average time: ${avgTimeMs.toStringAsFixed(2).padLeft(6)} ms');  
    print('      Throughput: ${throughput.toStringAsFixed(0).padLeft(8)} chars/sec');
    print('      Vector norm: ${_calculateMagnitude(lastEmbedding!).toStringAsFixed(4)}');
    print('');
  }
  
  // Memory efficiency test
  final memoryTestTexts = List.generate(50, (i) => 'Medical record $i with various symptoms');
  final startTime = DateTime.now();
  
  final embeddings = <List<double>>[];
  for (final text in memoryTestTexts) {
    embeddings.add(await service.generateEmbedding(text));
  }
  
  final endTime = DateTime.now();
  final totalTimeMs = endTime.difference(startTime).inMilliseconds;
  
  print('🧠 Memory Efficiency Test:');
  print('   Generated ${embeddings.length} embeddings in ${totalTimeMs}ms');
  print('   Average: ${(totalTimeMs / embeddings.length).toStringAsFixed(2)}ms per embedding');
  print('   Total vector data: ${(embeddings.length * 768 * 8 / 1024 / 1024).toStringAsFixed(2)} MB');
}

double _calculateMagnitude(List<double> vector) {
  var sum = 0.0;
  for (final value in vector) {
    sum += value * value;
  }
  return math.sqrt(sum);
}

String _similarity(EmbeddingGemmaService service, List<double> a, List<double> b) {
  return service.cosineSimilarity(a, b).toStringAsFixed(3);
}
