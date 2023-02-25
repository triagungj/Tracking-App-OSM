import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/auth/login_page.dart';
import 'package:mobile_app/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                AuthService().logout().then(
                      (value) => Get.offAll(() => const LoginPage()),
                    );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
