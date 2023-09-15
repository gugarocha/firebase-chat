import 'package:flutter/material.dart';

import '../components/messages.dart';
import '../components/new_message.dart';
import '../core/services/auth/auth_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          DropdownButton(
            onChanged: (value) {
              switch (value) {
                case 'logout':
                  AuthService().logout();
              }
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: const [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text('Sair'),
                  ],
                ),
              ),
            ],
          ),
        ],
        title: const Text(
          'Chat Cod3r',
        ),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
