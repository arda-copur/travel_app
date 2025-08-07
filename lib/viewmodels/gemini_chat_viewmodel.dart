import 'package:flutter/material.dart';
import 'package:travel_app/models/chat_message.dart';
import 'package:travel_app/services/gemini/gemini_service.dart';

class GeminiChatViewModel extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  bool _isInitialized = false;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;

  void initializeChat(BuildContext context) {
    if (_isInitialized) return;

    _geminiService.initializeChat(context);

    // Default Message for choosed language
    final welcomeMessage = ChatMessage(
      text: _geminiService.getWelcomeMessage(context),
      isUser: false,
    );
    _messages.add(welcomeMessage);
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add user message to the chat
    final userMessage = ChatMessage(text: message.trim(), isUser: true);
    _messages.add(userMessage);
    notifyListeners();

    _isLoading = true;
    notifyListeners();

    try {
      // Get response from Gemini service
      final response = await _geminiService.sendMessage(message);

      final botMessage = ChatMessage(text: response, isUser: false);
      _messages.add(botMessage);
    } catch (e) {
      final errorMessage = ChatMessage(
        text:
            'Es tut mir leid, es gab einen Fehler. Bitte versuchen Sie es erneut.',
        isUser: false,
      );
      _messages.add(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearChat(BuildContext context) {
    _messages.clear();
    _isInitialized = false;
    _geminiService.resetChat(context);
    initializeChat(context);
  }

  @override
  void dispose() {
    _messages.clear();
    super.dispose();
  }
}
