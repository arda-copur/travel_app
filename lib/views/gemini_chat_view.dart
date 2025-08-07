import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/utils/extensions/media_query_extension.dart';
import 'package:travel_app/viewmodels/gemini_chat_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travel_app/widgets/gemini/chat_message_bubble.dart';
import 'package:travel_app/widgets/gemini/typing_indicator.dart';

class GeminiChatView extends StatefulWidget {
  const GeminiChatView({super.key});

  @override
  State<GeminiChatView> createState() => _GeminiChatViewState();
}

class _GeminiChatViewState extends State<GeminiChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late GeminiChatViewModel _chatViewModel;

  @override
  void initState() {
    super.initState();
    _chatViewModel = GeminiChatViewModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatViewModel.initializeChat(context);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _chatViewModel.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      _chatViewModel.sendMessage(message);
      _messageController.clear();
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _chatViewModel,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(context.dynamicWidth(0.05)),
        child: Container(
          width: double.infinity,
          height: context.dynamicHeight(0.8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(context.dynamicWidth(0.04)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.smart_toy_rounded,
                      color: Colors.white,
                      size: context.dynamicWidth(0.08),
                    ),
                    SizedBox(width: context.dynamicWidth(0.03)),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)?.travelAssistant ??
                            'Travel Assistant',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _chatViewModel.clearChat(context);
                      },
                      icon: const Icon(Icons.refresh_rounded,
                          color: Colors.white),
                      tooltip: AppLocalizations.of(context)?.clearChat ??
                          'Clear Chat',
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon:
                          const Icon(Icons.close_rounded, color: Colors.white),
                      tooltip: AppLocalizations.of(context)?.close ?? 'Close',
                    ),
                  ],
                ),
              ),
              // Chat Messages
              Expanded(
                child: Consumer<GeminiChatViewModel>(
                  builder: (context, chatViewModel, child) {
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => _scrollToBottom());

                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.all(context.dynamicWidth(0.04)),
                      itemCount: chatViewModel.messages.length +
                          (chatViewModel.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == chatViewModel.messages.length &&
                            chatViewModel.isLoading) {
                          return const TypingIndicator();
                        }

                        final message = chatViewModel.messages[index];
                        return ChatMessageBubble(message: message);
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(context.dynamicWidth(0.04)),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)?.typeMessage ??
                              'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: context.dynamicWidth(0.04),
                            vertical: context.dynamicHeight(0.015),
                          ),
                        ),
                        maxLines: null,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    SizedBox(width: context.dynamicWidth(0.02)),
                    Consumer<GeminiChatViewModel>(
                      builder: (context, chatViewModel, child) {
                        return FloatingActionButton(
                          onPressed:
                              chatViewModel.isLoading ? null : _sendMessage,
                          mini: true,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: chatViewModel.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : const Icon(Icons.send_rounded,
                                  color: Colors.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
