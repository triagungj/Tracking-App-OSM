import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({
    Key? key,
    required this.formLoginKey,
    required this.usernameController,
    required this.passwordController,
    this.onLogin,
  }) : super(key: key);

  final GlobalKey<FormState> formLoginKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final Function()? onLogin;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formLoginKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Login',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          _UsernameField(
            key: const Key('usernameField'),
            usernameController: usernameController,
          ),
          const SizedBox(height: 10),
          _PasswordField(
            key: const Key('passwordField'),
            passwordController: passwordController,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            key: const Key('loginBtn'),
            onPressed: onLogin,
            child: const Text('LOGIN'),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _UsernameField extends StatelessWidget {
  const _UsernameField({
    Key? key,
    required this.usernameController,
  }) : super(key: key);

  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: usernameController,
      decoration: const InputDecoration(
        hintText: 'Username',
        prefixIcon: Icon(FluentIcons.person_12_regular),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final obscure = ValueNotifier<bool>(true);

    return ValueListenableBuilder(
      valueListenable: obscure,
      builder: (context, _, __) => TextFormField(
        controller: passwordController,
        obscureText: obscure.value,
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: const Icon(FluentIcons.lock_closed_24_regular),
          suffixIcon: IconButton(
            key: const Key('obscureButton'),
            onPressed: () {
              obscure.value = !obscure.value;
            },
            icon: obscure.value
                ? const Icon(FluentIcons.eye_24_regular)
                : const Icon(FluentIcons.eye_off_20_regular),
          ),
        ),
      ),
    );
  }
}
