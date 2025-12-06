// lib/screens/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:senior_connect/widgets/accessible_widgets.dart';
import '../services/openai_service.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String otherUserName;
  
  const ChatScreen({super.key, required this.chatId, required this.otherUserName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageCtrl = TextEditingController();
  final OpenAIService _ai = OpenAIService();
  
  // Dummy messages for UI demo
  final List<String> _messages = ["Hello!", "Hi there, nice to meet you."]; 

  void _sendMessage() {
    if (_messageCtrl.text.isNotEmpty) {
      setState(() {
        _messages.add(_messageCtrl.text);
        _messageCtrl.clear();
      });
      // In real app: Add to Firestore /chats/{id}/messages
    }
  }

  void _showAIHelper() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 300,
          child: Column(
            children: [
              const Text("Conversation Helper", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.lightbulb, size: 40, color: Colors.amber),
                title: const Text("Topic Ideas", style: TextStyle(fontSize: 20)),
                onTap: () async {
                  Navigator.pop(context);
                  String idea = await _ai.getChatSuggestion('topic', 'Gardening', 'History');
                  _showResponseDialog(idea);
                },
              ),
              ListTile(
                leading: const Icon(Icons.handyman, size: 40, color: Colors.blue),
                title: const Text("Project Ideas", style: TextStyle(fontSize: 20)),
                onTap: () async {
                  Navigator.pop(context);
                  String idea = await _ai.getChatSuggestion('project', 'Gardening', 'History');
                  _showResponseDialog(idea);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showResponseDialog(String text) {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text("Suggestion"),
      content: Text(text, style: const TextStyle(fontSize: 22)),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close", style: TextStyle(fontSize: 20)))],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherUserName),
        actions: [
          IconButton(
            icon: const Icon(Icons.assistant, size: 36, color: Colors.amber), // AI Button
            onPressed: _showAIHelper,
            tooltip: "Get Help",
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                // Simple message bubble
                bool isMe = index % 2 == 0; // Fake toggle
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(_messages[index], style: const TextStyle(fontSize: 20)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(child: BigTextField(label: "Type here...", controller: _messageCtrl)),
                const SizedBox(width: 10),
                IconButton(icon: const Icon(Icons.send, size: 40, color: Colors.blue), onPressed: _sendMessage),
              ],
            ),
          )
        ],
      ),
    );
  }
}