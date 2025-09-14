import 'package:flutter/material.dart';

/// Simple working AI Chat page for testing
class SimpleAiChatPage extends StatefulWidget {
  const SimpleAiChatPage({Key? key}) : super(key: key);

  @override
  State<SimpleAiChatPage> createState() => _SimpleAiChatPageState();
}

class _SimpleAiChatPageState extends State<SimpleAiChatPage> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'Hello! I\'m your DGTL Healthcare AI assistant. I have access to your clinical data (74 records spanning 2017-2023) and evidence-based medical guidelines. How can I help you today?',
      isUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
  ];
  
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Health Assistant'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          const _PatientContextCard(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _ChatBubble(message: _messages[index]);
              },
            ),
          ),
          _MessageInput(
            controller: _textController,
            onSend: _handleSend,
          ),
        ],
      ),
    );
  }

  void _handleSend(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: message,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });

    _textController.clear();

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(ChatMessage(
          text: _generateResponse(message),
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
    });
  }

  String _generateResponse(String userMessage) {
    // Simple response simulation based on message content
    final msg = userMessage.toLowerCase();
    
    if (msg.contains('creatinine') || msg.contains('kidney')) {
      return 'Based on your latest clinical data (eGFR: 8.8 ml/min/1.73m²), your kidney function indicates Stage 5 CKD. According to evidence-based guidelines, this requires immediate nephrology consultation and preparation for renal replacement therapy. Your creatinine levels have been trending upward over the 6-year period in our database.';
    } else if (msg.contains('blood pressure') || msg.contains('bp')) {
      return 'Your blood pressure data shows values averaging 158/96 mmHg over the tracked period. This hypertension is concerning given your CKD status. The RAG system recommends ACE inhibitors or ARBs as first-line treatment, with target BP <130/80 mmHg according to current guidelines.';
    } else if (msg.contains('medication') || msg.contains('drug')) {
      return 'Based on your clinical profile and RAG-enhanced recommendations, medication management should focus on: 1) Nephrotoxic drug avoidance, 2) Dose adjustments for reduced eGFR, 3) Phosphate binders, 4) ESA therapy consideration. All changes should be coordinated with your nephrologist.';
    } else if (msg.contains('diet') || msg.contains('nutrition')) {
      return 'For Stage 5 CKD, nutritional guidelines recommend: Protein restriction (0.6-0.8g/kg/day), Phosphorus limitation (<800mg/day), Potassium monitoring, Fluid balance management. Your clinical trends suggest these interventions are critical at this stage.';
    } else {
      return 'I understand you\'re asking about: "$userMessage". Based on your 6-year clinical history and current Stage 5 CKD status, I can provide personalized medical insights. Could you be more specific about which aspect of your health you\'d like to discuss - kidney function, medications, symptoms, or treatment options?';
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class _PatientContextCard extends StatelessWidget {
  const _PatientContextCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patient Context Active',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'eGFR: 8.8 ml/min • Stage 5 CKD • 74 clinical records • RAG enhanced',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue.shade100,
              child: Icon(
                Icons.health_and_safety,
                size: 16,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.blue.shade500 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: message.isUser ? Colors.white70 : Colors.grey.shade600,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.green.shade100,
              child: Icon(
                Icons.person,
                size: 16,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend;

  const _MessageInput({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Ask about your health data...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              onSubmitted: onSend,
              maxLines: null,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => onSend(controller.text),
            icon: const Icon(Icons.send),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
