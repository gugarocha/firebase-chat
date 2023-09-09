import 'dart:io';

enum AuthMode {
  signup,
  login,
}

class AuthFormData {
  String name;
  String email;
  String password;
  File? image;
  AuthMode _mode = AuthMode.login;

  AuthFormData({
    required this.name,
    required this.email,
    required this.password,
    this.image,
  });

  bool get isLogin => _mode == AuthMode.login;
  bool get isSignup => _mode == AuthMode.signup;

  void toggleAuthMode() {
    _mode = isLogin ? AuthMode.signup : AuthMode.login;
  }
}
