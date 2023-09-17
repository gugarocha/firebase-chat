import 'package:flutter/material.dart';

import '../core/models/chat_message.dart';
import '../core/services/auth/auth_service.dart';
import '../core/services/chat/chat_service.dart';
import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Vamos conversar?'),
          );
        } else {
          final messages = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (ctx, i) {
              return MessageBubble(
                key: ValueKey(messages[i].id),
                message: messages[i],
                belongsToCurrentUser: messages[i].userId == currentUser?.id,
              );
            },
          );
        }
      },
    );
  }
}
