import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';
import '../core/services/chat/chat_service.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final messageEC = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null && messageEC.text.trim().isNotEmpty) {
      await ChatService().save(messageEC.text, user);
      messageEC.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: messageEC,
            decoration: const InputDecoration(labelText: 'Enviar mensagem...'),
            onSubmitted: (_) => _sendMessage(),
          ),
        ),
        IconButton(
          onPressed: _sendMessage,
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
