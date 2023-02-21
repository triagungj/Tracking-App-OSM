import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/auth/login_form.dart';
import 'package:mobile_app/app/home/home_page.dart';
import 'package:mobile_app/models/request/login_body.dart';
import 'package:mobile_app/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();

  // Controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Key
  final _formLoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 70),
                      child: Column(
                        children: [
                          Icon(
                            FluentIcons.location_20_filled,
                            color: Colors.blue.shade400,
                            size: 180,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Tracking App',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                          )
                        ],
                      ),
                    ),
                    FormLogin(
                      formLoginKey: _formLoginKey,
                      usernameController: usernameController,
                      passwordController: passwordController,
                      onLogin: onLogin,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onLogin() async {
    if (_formLoginKey.currentState!.validate()) {
      Get.dialog(
        Container(
          padding: const EdgeInsets.all(20),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );

      _formLoginKey.currentState!.save();

      final body = LoginBody(
        username: usernameController.text,
        password: passwordController.text,
      );

      final result = await AuthService().login(body);

      Get.back();
      if (result.token != null) {
        Get.to<void>(() => const HomePage());
      } else {
        Get.snackbar('Login Gagal', result.message);
      }
    }
  }
}
