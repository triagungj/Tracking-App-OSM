import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/order/order_tracking.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Test'),
            ElevatedButton(
              onPressed: () => Get.to(() => const OrderTracking()),
              child: const Text('Test'),
            )
          ],
        ),
      ),
    );
  }
}