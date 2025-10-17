import 'package:flutter/material.dart';

class TestAssetScreen extends StatelessWidget {
  const TestAssetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Asset')),
      body: Center(
        child: Image.asset(
          'assets/icons/notification.png',
          width: 100,
          height: 100,
          errorBuilder: (context, error, stackTrace) {
            return const Text('❌ Failed to load asset');
          },
        ),
      ),
    );
  }
}