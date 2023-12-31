import 'dart:async';
import 'dart:math';

import '../../models/chat_user.dart';
import 'dart:io';

import 'auth_service.dart';

class AuthMockService implements AuthService {
  static final defaultUser = ChatUser(
    id: '123456',
    name: 'Gustavo',
    email: 'guga@teste.com',
    imageUrl: 'assets/images/avatar.png',
  );

  static Map<String, ChatUser> users = {
    defaultUser.email: defaultUser,
  };
  static ChatUser? _currentUser;

  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(defaultUser);
  });

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  @override
  Future<void> login(String email, String password) async {
    _updateUser(users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/avatar.png',
    );

    users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }
}
