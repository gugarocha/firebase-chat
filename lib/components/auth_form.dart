import 'dart:io';

import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../core/models/auth_form_data.dart';
import 'user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormState>();
  final authFormData = AuthFormData(
    name: '',
    email: '',
    password: '',
  );

  void handlePickImage(File image) {
    authFormData.image = image;
  }

  void submit() {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    widget.onSubmit(authFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              if (authFormData.isSignup)
                UserImagePicker(
                  onPickImage: handlePickImage,
                ),
              if (authFormData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: authFormData.name,
                  onChanged: (value) => authFormData.name = value,
                  validator: Validatorless.required('Campo Obrigatório'),
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
              TextFormField(
                key: const ValueKey('e-mail'),
                initialValue: authFormData.email,
                onChanged: (value) => authFormData.email = value,
                validator: Validatorless.multiple([
                  Validatorless.required('Campo Obrigatório'),
                  Validatorless.email('Digite um e-mail válido'),
                ]),
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: authFormData.password,
                onChanged: (value) => authFormData.password = value,
                validator: Validatorless.multiple([
                  Validatorless.required('Campo Obrigatório'),
                  Validatorless.min(
                    6,
                    'Senha deve conter no mínimo 6 caracteres',
                  ),
                ]),
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: submit,
                child: Text(
                  authFormData.isLogin ? 'Entrar' : 'Cadastrar',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    authFormData.toggleAuthMode();
                  });
                },
                child: Text(
                  authFormData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
