import 'dart:async';
import 'dart:math';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';
import 'chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: Random().nextDouble().toString(),
      text: 'Boa noite',
      createdAt: DateTime.now(),
      userId: '123456',
      userName: 'Gustavo',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: Random().nextDouble().toString(),
      text: 'Boa noite. Teremos reunião?',
      createdAt: DateTime.now(),
      userId: '456789',
      userName: 'Rocha',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: Random().nextDouble().toString(),
      text: 'Sim, agora',
      createdAt: DateTime.now(),
      userId: '123456',
      userName: 'Gustavo',
      userImageUrl: 'assets/images/avatar.png',
    ),
  ];

  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    _msgs.add(newMessage);

    _controller?.add(_msgs);

    return newMessage;
  }
}
