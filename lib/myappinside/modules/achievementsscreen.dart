import 'package:flutter/material.dart';

class achievementsscreen extends StatelessWidget {
  const achievementsscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: const Center(
        child: Text('Welcome to the Achievements Screen!'),
      ),
    );
  }
}