import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobile_app/app/auth/login_page.dart';
import 'package:mobile_app/app/home/home_page.dart';
import 'package:mobile_app/services/local_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<String?>(
          future: LocalService().getLocalToken(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingScreen();
            } else {
              return const LoginPage();
            }
          }),
    );
  }

  Widget loadingScreen() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
