import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Olá, ${AuthService().currentUser?.name}'),
          TextButton(
            onPressed: () {
              AuthService().logout();
            },
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}
