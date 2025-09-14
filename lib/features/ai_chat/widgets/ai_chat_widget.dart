import 'package:flutter/material.dart';
import '../../core/api/backend_controller.dart';

/// AI Chat Widget with Backend Integration
/// Demonstrates how frontend connects to AI/ML/RAG backend
class AiChatWidget extends StatefulWidget {
  const AiChatWidget({Key? key}) : super(key: key);

  @override
  State<AiChatWidget> createState() => _AiChatWidgetState();
}

class _AiChatWidgetState extends State<AiChatWidget> {
  final TextEditingController _queryController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  bool _backendConnected = false;

  @override
  void initState() {
    super.initState();
    _checkBackendStatus();
  }

  /// Check if backend is connected
  Future<void> _checkBackendStatus() async {
    try {
      final healthCheck = await DgtlBackendController.healthCheck();
      setState(() {
        _backendConnected = healthCheck['backend_connected'] == true;
      });
    } catch (e) {
      setState(() {
        _backendConnected = false;
      });
    }
  }

  /// Send query to AI/ML/RAG backend
  Future<void> _sendQuery() async {
    if (_queryController.text.trim().isEmpty) return;
    
    final query = _queryController.text.trim();
    _queryController.clear();
    
    // Add user message
    setState(() {
      _messages.add(ChatMessage(
        message: query,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isLoading = true;
    });

    try {
      // Call backend AI/ML/RAG system
      final response = await DgtlBackendController.processChatQuery(
        query: query,
        context: 'healthcare_dashboard',
        patientContext: {
          'session_id': 'dashboard_${DateTime.now().millisecondsSinceEpoch}',
          'source': 'ai_chat_widget'
        },
      );

      setState(() {
        if (response['success'] == true) {
          _messages.add(ChatMessage(
            message: response['response'] ?? 'AI response received',
            isUser: false,
            timestamp: DateTime.now(),
            aiConfidence: 0.85, // Could be from AI response
          ));
        } else {
          _messages.add(ChatMessage(
            message: 'Error: ${response['error']}',
            isUser: false,
            timestamp: DateTime.now(),
            isError: true,
          ));
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          message: 'Connection error: $e',
          isUser: false,
          timestamp: DateTime.now(),
          isError: true,
        ));
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.smart_toy, color: Colors.blue),
              const SizedBox(width: 8),
              const Text(
                'AI Healthcare Assistant',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _backendConnected ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _backendConnected ? 'Connected' : 'Offline',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          
          // Messages
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Align(
                    alignment: message.isUser 
                        ? Alignment.centerRight 
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: message.isUser 
                            ? Colors.blue[100] 
                            : message.isError 
                                ? Colors.red[100] 
                                : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.message,
                            style: TextStyle(
                              color: message.isError ? Colors.red[800] : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                              if (message.aiConfidence != null) ...[
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.psychology,
                                  size: 12,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  '${(message.aiConfidence! * 100).toInt()}%',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Loading indicator
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text('AI is thinking...', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          
          // Input field
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _queryController,
                  decoration: const InputDecoration(
                    hintText: 'Ask about symptoms, medications, or health...',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onSubmitted: (_) => _sendQuery(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _backendConnected && !_isLoading ? _sendQuery : null,
                icon: const Icon(Icons.send),
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }
}

/// Chat message data model
class ChatMessage {
  final String message;
  final bool isUser;
  final DateTime timestamp;
  final double? aiConfidence;
  final bool isError;

  ChatMessage({
    required this.message,
    required this.isUser,
    required this.timestamp,
    this.aiConfidence,
    this.isError = false,
  });
}
