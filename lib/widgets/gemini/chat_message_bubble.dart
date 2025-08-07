import 'package:flutter/material.dart';
import 'package:travel_app/models/chat_message.dart';
import 'package:travel_app/utils/extensions/media_query_extension.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.005)),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              radius: context.dynamicWidth(0.04),
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.smart_toy_rounded,
                color: Colors.white,
                size: context.dynamicWidth(0.05),
              ),
            ),
            SizedBox(width: context.dynamicWidth(0.02)),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.dynamicWidth(0.04),
                vertical: context.dynamicHeight(0.015),
              ),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: message.isUser ? Colors.white : null,
                    ),
              ),
            ),
          ),
          if (message.isUser) ...[
            SizedBox(width: context.dynamicWidth(0.02)),
            CircleAvatar(
              radius: context.dynamicWidth(0.04),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: context.dynamicWidth(0.05),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
