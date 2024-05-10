// goals.dart
import 'package:flutter/material.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sparziele'),
      ),
      body: const Center(
        child: Text('Hier können Ziele gesetzt und verfolgt werden.'),
      ),
    );
  }
}
