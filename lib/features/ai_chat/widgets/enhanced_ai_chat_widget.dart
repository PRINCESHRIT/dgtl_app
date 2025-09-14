import 'package:flutter/material.dart';
import '../ai_chat_page.dart';

/// Enhanced Chat Bubble Widget for Medical AI Conversations
class EnhancedChatBubble extends StatelessWidget {
  final ChatMessage message;
  final Function(String)? onSourceTap;

  const EnhancedChatBubble({
    super.key,
    required this.message,
    this.onSourceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) _buildAvatarIcon(),
          if (message.isUser) const Spacer(),
          Flexible(
            flex: 4,
            child: _buildMessageBubble(context),
          ),
          if (message.isUser) _buildUserAvatar(),
          if (!message.isUser) const Spacer(),
        ],
      ),
    );
  }

  Widget _buildAvatarIcon() {
    IconData icon;
    Color color;
    
    switch (message.messageType) {
      case ChatMessageType.ai:
        icon = Icons.psychology;
        color = const Color(0xFF2E8B57);
        break;
      case ChatMessageType.system:
        icon = Icons.info_outline;
        color = const Color(0xFF1976D2);
        break;
      case ChatMessageType.error:
        icon = Icons.error_outline;
        color = const Color(0xFFD32F2F);
        break;
      default:
        icon = Icons.help_outline;
        color = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8.0),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0, top: 8.0),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Color(0xFF4CAF50),
        child: Icon(Icons.person, size: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: message.isUser ? const Color(0xFF2E8B57) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: message.isUser
            ? null
            : Border.all(color: const Color(0xFFE0E0E0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Message content
          SelectableText(
            message.content,
            style: TextStyle(
              color: message.isUser ? Colors.white : Colors.black87,
              fontSize: 15,
              height: 1.4,
            ),
          ),
          
          // Metadata for AI messages
          if (!message.isUser) ..._buildMessageMetadata(context),
          
          // Timestamp
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _formatTimestamp(message.timestamp),
              style: TextStyle(
                color: message.isUser
                    ? Colors.white.withOpacity(0.7)
                    : Colors.grey[600],
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMessageMetadata(BuildContext context) {
    final widgets = <Widget>[];

    // Confidence score
    if (message.confidence != null && message.confidence! > 0) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            children: [
              Icon(
                Icons.analytics_outlined,
                size: 14,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Text(
                'Confidence: ${(message.confidence! * 100).toInt()}%',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Clinical evidence
    if (message.clinicalEvidence != null) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Icon(
                Icons.medical_information_outlined,
                size: 14,
                color: Colors.blue[700],
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  message.clinicalEvidence!,
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Sources
    if (message.sources != null && message.sources!.isNotEmpty) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.source,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Clinical Sources:',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ...message.sources!.take(3).map((source) => _buildSourceChip(source)),
              if (message.sources!.length > 3)
                Text(
                  '+${message.sources!.length - 3} more sources',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  Widget _buildSourceChip(String source) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: GestureDetector(
        onTap: () => onSourceTap?.call(source),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF2E8B57).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF2E8B57).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            _truncateSource(source),
            style: const TextStyle(
              color: Color(0xFF2E8B57),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  String _truncateSource(String source) {
    if (source.length <= 40) return source;
    return '${source.substring(0, 37)}...';
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }
}
