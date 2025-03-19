import 'package:flutter/material.dart';

class voicecallscreen extends StatelessWidget {
  const voicecallscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Call'),
      ),
      body: const Center(
        child: Text('Welcome to the Voice Call Screen!'),
      ),
    );
  }
}