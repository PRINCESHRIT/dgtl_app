import 'package:flutter/material.dart';
import 'dart:convert';
import '../../core/ai/dgtl_rag_service.dart';
import '../../core/database/database_production.dart';
import '../../core/services/clinical_data_service.dart';
import 'widgets/enhanced_ai_chat_widget.dart';

/// Enhanced AI Chat Page with RAG Integration
/// Connects to medical guidelines and clinical dataset
class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final DgtlRagService _ragService = DgtlRagService();
  final ClinicalDataService _clinicalService = ClinicalDataService();
  final List<ChatMessage> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  
  bool _isInitialized = false;
  bool _isLoading = false;
  Map<String, dynamic>? _patientContext;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    setState(() => _isLoading = true);
    
    try {
      // Initialize RAG service with enhanced knowledge base
      await _ragService.initialize();
      
      // Load patient clinical context
      _patientContext = await _clinicalService.getPatientContext('CLINICAL-P001');
      
      // Load personalized guidelines
      await _loadPersonalizedGuidelines();
      
      setState(() {
        _isInitialized = true;
        _isLoading = false;
      });
      
      // Welcome message with patient context
      _addSystemMessage(_generateWelcomeMessage());
      
    } catch (e) {
      setState(() => _isLoading = false);
      _addSystemMessage('System initialization error. Some features may be limited.');
      print('AI Chat initialization error: $e');
    }
  }

  Future<void> _loadPersonalizedGuidelines() async {
    try {
      // Load the integrated guidelines knowledge base
      final guidelinesFile = await DefaultAssetBundle.of(context)
          .loadString('assets/models/rag_guidelines_integrated.json');
      final guidelines = jsonDecode(guidelinesFile);
      
      // Seed RAG service with guidelines
      await _ragService.seedKnowledgeBase(guidelines['knowledge_entries']);
      
    } catch (e) {
      print('Guidelines loading error: $e');
    }
  }

  String _generateWelcomeMessage() {
    if (_patientContext == null) {
      return 'Hello! I\'m your AI healthcare assistant. How can I help you today?';
    }
    
    final egfr = _patientContext!['latest_egfr']?['value'] ?? 'unknown';
    final stage = _patientContext!['ckd_stage'] ?? 'unknown';
    
    return '''Hello! I'm your personalized AI healthcare assistant.

Based on your clinical profile:
• Current eGFR: $egfr ml/min
• CKD Stage: $stage
• I have access to your 6-year medical history and evidence-based guidelines

I can help you with:
🩺 Understanding your lab results
💊 Medication questions and interactions
🥗 Dietary recommendations for kidney health
📊 Trend analysis of your health data
⚕️ Evidence-based clinical guidance

What would you like to discuss today?''';
  }

  void _addSystemMessage(String content) {
    setState(() {
      _messages.add(ChatMessage(
        content: content,
        isUser: false,
        timestamp: DateTime.now(),
        messageType: ChatMessageType.system,
      ));
    });
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty || _isLoading) return;

    // Add user message
    setState(() {
      _messages.add(ChatMessage(
        content: message,
        isUser: true,
        timestamp: DateTime.now(),
        messageType: ChatMessageType.user,
      ));
      _isLoading = true;
    });

    _messageController.clear();

    try {
      // Generate AI response using RAG with clinical context
      final response = await _ragService.generateResponse(
        message,
        context: _patientContext,
      );

      // Add AI response
      setState(() {
        _messages.add(ChatMessage(
          content: response['response'],
          isUser: false,
          timestamp: DateTime.now(),
          messageType: ChatMessageType.ai,
          confidence: response['confidence'],
          sources: List<String>.from(response['sources'] ?? []),
          clinicalEvidence: response['clinical_evidence'],
        ));
        _isLoading = false;
      });

      // Log interaction for learning
      await _ragService.logInteraction(message, response['response']);

    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          content: 'I apologize, but I encountered an error. Please try rephrasing your question.',
          isUser: false,
          timestamp: DateTime.now(),
          messageType: ChatMessageType.error,
        ));
        _isLoading = false;
      });
      print('Message processing error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFE),
      appBar: AppBar(
        title: const Text(
          'AI Healthcare Assistant',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2E8B57),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          if (!_isInitialized)
            const LinearProgressIndicator(
              backgroundColor: Color(0xFFE8F5E8),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E8B57)),
            ),
          
          // Patient Context Card
          if (_patientContext != null)
            _buildPatientContextCard(),
          
          // Chat Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return EnhancedChatBubble(
                  message: _messages[index],
                  onSourceTap: (source) => _showSourceDetails(source),
                );
              },
            ),
          ),
          
          // Loading indicator
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text('AI is thinking...'),
                ],
              ),
            ),
          
          // Message Input
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildPatientContextCard() {
    final egfr = _patientContext!['latest_egfr']?['value']?.toString() ?? 'N/A';
    final creatinine = _patientContext!['latest_creatinine']?['value']?.toString() ?? 'N/A';
    final stage = _patientContext!['ckd_stage']?.toString() ?? 'Unknown';

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.person, color: Color(0xFF2E8B57), size: 20),
                SizedBox(width: 8),
                Text(
                  'Your Health Profile',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildHealthMetric('eGFR', egfr, 'ml/min'),
                ),
                Expanded(
                  child: _buildHealthMetric('Creatinine', creatinine, 'mg/dl'),
                ),
                Expanded(
                  child: _buildHealthMetric('CKD Stage', stage.replaceAll('Stage ', ''), ''),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthMetric(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        if (unit.isNotEmpty)
          Text(
            unit,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Ask about your health, medications, or symptoms...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Color(0xFF2E8B57)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onSubmitted: (_) => _sendMessage(),
              enabled: _isInitialized && !_isLoading,
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: _isInitialized && !_isLoading
                ? const Color(0xFF2E8B57)
                : Colors.grey,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: _isInitialized && !_isLoading ? _sendMessage : null,
            ),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AI Healthcare Assistant'),
        content: const Text(
          'This AI assistant uses your clinical data and evidence-based medical guidelines to provide personalized healthcare information.\n\n'
          'Features:\n'
          '• Analysis of your 6-year medical history\n'
          '• Evidence-based clinical recommendations\n'
          '• Stage 4 CKD management guidelines\n'
          '• Medication interaction checking\n'
          '• Dietary and lifestyle guidance\n\n'
          'Always consult your healthcare provider for medical decisions.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  void _showSourceDetails(String source) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clinical Source'),
        content: Text(source),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Enhanced Chat Message Model
class ChatMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final ChatMessageType messageType;
  final double? confidence;
  final List<String>? sources;
  final String? clinicalEvidence;

  ChatMessage({
    required this.content,
    required this.isUser,
    required this.timestamp,
    required this.messageType,
    this.confidence,
    this.sources,
    this.clinicalEvidence,
  });
}

enum ChatMessageType {
  user,
  ai,
  system,
  error,
}
