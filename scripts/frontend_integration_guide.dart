// Frontend Integration Guide
// How to use the backend capabilities in your Flutter UI

/*
=============================================================================
BACKEND CAPABILITIES FOR FRONTEND INTEGRATION
=============================================================================

Your backend is READY for frontend development with these proven capabilities:

📱 IMMEDIATE INTEGRATION OPPORTUNITIES:

1. SYMPTOM TRACKER SCREEN
   → Use: SymptomLogsDao for CRUD operations
   → Use: EmbeddingGemmaService.generateEmbedding() for semantic search
   → Use: VectorSearchService.findSimilarSymptoms() for pattern recognition

2. LAB RESULTS DASHBOARD  
   → Use: LabTestsDao & LabResultsDao for data management
   → Use: Gemma3NRagService.answerQuestion() for natural language queries
   → Use: Database queries for trend analysis

3. AI CHAT INTERFACE
   → Use: Gemma3NRagService for question answering about patient data
   → Use: VectorSearchService for finding relevant historical context
   → Use: EmbeddingGemmaService for understanding user intent

4. PATIENT PROFILE
   → Use: PatientsDao for basic patient information
   → Use: Database relationships to show connected data (symptoms, labs, etc.)

=============================================================================
*/

// Example 1: Building a Symptom Input Screen
class SymptomInputExample {
  /*
  // In your Flutter screen:
  
  import 'package:get_it/get_it.dart';
  
  class SymptomInputScreen extends StatefulWidget {
    @override
    _SymptomInputScreenState createState() => _SymptomInputScreenState();
  }
  
  class _SymptomInputScreenState extends State<SymptomInputScreen> {
    final _controller = TextEditingController();
    final _embeddingService = GetIt.instance<EmbeddingGemmaService>();
    final _vectorSearchService = GetIt.instance<VectorSearchService>();
    final _database = GetIt.instance<AppDatabase>();
    
    Future<void> _saveSymptom() async {
      final description = _controller.text;
      
      // 1. Generate semantic embedding for the symptom
      final embedding = await _embeddingService.generateEmbedding(description);
      
      // 2. Save to database
      final symptom = SymptomLogsCompanion.insert(
        patientId: 1, // Your current patient
        symptomType: 'general',
        description: description,
        severity: 5, // User input
        timestamp: DateTime.now(),
        embedding: embedding.join(','), // Store as comma-separated string
      );
      
      await _database.symptomLogsDao.insertSymptomLog(symptom);
      
      // 3. Find similar past symptoms for context
      final similarSymptoms = await _vectorSearchService.findSimilarSymptoms(
        embedding, 
        patientId: 1,
        limit: 3
      );
      
      // 4. Show user similar past events
      if (similarSymptoms.isNotEmpty) {
        _showSimilarSymptomsDialog(similarSymptoms);
      }
      
      _controller.clear();
    }
    
    void _showSimilarSymptomsDialog(List<SimilarSymptom> similar) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Similar Past Symptoms'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: similar.map((s) => ListTile(
              title: Text(s.description),
              subtitle: Text('${(s.similarity * 100).toStringAsFixed(0)}% similar'),
              trailing: Text(s.timestamp.toString().split(' ')[0]),
            )).toList(),
          ),
        ),
      );
    }
    
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Log Symptom')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Describe the symptom',
                  hintText: 'e.g., "Maa ke pairo mein sujan hai" or "Swelling in feet"',
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveSymptom,
                child: Text('Save Symptom'),
              ),
            ],
          ),
        ),
      );
    }
  }
  */
}

// Example 2: Building an AI Chat Interface  
class AIChatExample {
  /*
  // In your Flutter screen:
  
  class AIChatScreen extends StatefulWidget {
    @override
    _AIChatScreenState createState() => _AIChatScreenState();
  }
  
  class _AIChatScreenState extends State<AIChatScreen> {
    final _controller = TextEditingController();
    final _ragService = GetIt.instance<Gemma3NRagService>();
    final List<ChatMessage> _messages = [];
    
    Future<void> _sendMessage() async {
      final question = _controller.text;
      if (question.isEmpty) return;
      
      // Add user message
      setState(() {
        _messages.add(ChatMessage(text: question, isUser: true));
      });
      
      _controller.clear();
      
      // Get AI response
      try {
        final response = await _ragService.answerQuestion(question, patientId: 1);
        
        setState(() {
          _messages.add(ChatMessage(text: response, isUser: false));
        });
      } catch (e) {
        setState(() {
          _messages.add(ChatMessage(
            text: 'Sorry, I couldn\'t process that question. Please try again.',
            isUser: false
          ));
        });
      }
    }
    
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Ask About Patient Data')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ChatBubble(
                    text: message.text,
                    isUser: message.isUser,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask about symptoms, lab results, trends...',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
  
  class ChatMessage {
    final String text;
    final bool isUser;
    
    ChatMessage({required this.text, required this.isUser});
  }
  */
}

// Example 3: Lab Results Trend Analysis
class LabTrendsExample {
  /*
  // In your Flutter screen:
  
  class LabTrendsScreen extends StatefulWidget {
    @override
    _LabTrendsScreenState createState() => _LabTrendsScreenState();
  }
  
  class _LabTrendsScreenState extends State<LabTrendsScreen> {
    final _database = GetIt.instance<AppDatabase>();
    List<LabResult> _creatinineResults = [];
    
    @override
    void initState() {
      super.initState();
      _loadCreatinineTrends();
    }
    
    Future<void> _loadCreatinineTrends() async {
      // Get creatinine results for the last 6 months
      final sixMonthsAgo = DateTime.now().subtract(Duration(days: 180));
      
      final results = await (_database.select(_database.labResults)
        ..where((tbl) => tbl.testName.equals('creatinine'))
        ..where((tbl) => tbl.resultDate.isBiggerThanValue(sixMonthsAgo))
        ..orderBy([(tbl) => OrderingTerm.asc(tbl.resultDate)]))
        .get();
      
      setState(() {
        _creatinineResults = results;
      });
    }
    
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Creatinine Trends')),
        body: Column(
          children: [
            // Chart widget showing trend line
            Container(
              height: 200,
              child: LineChart(_buildChartData()),
            ),
            
            // Latest values
            Card(
              child: ListTile(
                title: Text('Latest Creatinine'),
                subtitle: Text(_creatinineResults.isNotEmpty 
                  ? '${_creatinineResults.last.value} ${_creatinineResults.last.unit}'
                  : 'No data'),
                trailing: Icon(_getTrendIcon()),
              ),
            ),
            
            // Ask AI about trends
            ElevatedButton(
              onPressed: () => _askAIAboutTrends(),
              child: Text('Ask AI about these trends'),
            ),
          ],
        ),
      );
    }
    
    Future<void> _askAIAboutTrends() async {
      final ragService = GetIt.instance<Gemma3NRagService>();
      final analysis = await ragService.answerQuestion(
        'Analyze the creatinine trend over the last 6 months',
        patientId: 1
      );
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('AI Trend Analysis'),
          content: Text(analysis),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  */
}

void main() {
  print('📱 Frontend Integration Examples');
  print('=' * 40);
  
  print('\n🔧 STEP 1: Service Setup (Already Done)');
  print('   ✅ Services registered in lib/app/di.dart');
  print('   ✅ Database models in lib/core/database/');
  print('   ✅ AI services in lib/core/ai/');
  
  print('\n💡 STEP 2: Use in Your Screens');
  print('   → Import: GetIt.instance<ServiceName>()');
  print('   → Call: await service.method()');
  print('   → Handle: async/await with try-catch');
  
  print('\n🎯 RECOMMENDED STARTING POINTS:');
  print('   1. Simple symptom input form (Example 1 above)');
  print('   2. Basic patient dashboard with recent data');
  print('   3. Lab results list with trend indicators');
  print('   4. AI chat for simple questions');
  
  print('\n⚡ QUICK WINS:');
  print('   → Symptom autocomplete using embedding similarity');
  print('   → "Similar to previous symptoms" notifications');
  print('   → Natural language lab result queries');
  print('   → Trend analysis with AI explanations');
  
  print('\n🔄 DEVELOPMENT WORKFLOW:');
  print('   1. Build UI mockups/wireframes first');
  print('   2. Integrate one service at a time');
  print('   3. Test with real patient data');
  print('   4. Add AI features incrementally');
  print('   5. Polish UX based on caregiver feedback');
  
  print('\n✨ Your backend is production-ready for these use cases!');
}
