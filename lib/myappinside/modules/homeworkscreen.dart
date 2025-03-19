import 'package:flutter/material.dart';

class homeworkscreen extends StatelessWidget {
  const homeworkscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homeworks'),
      ),
      body: const Center(
        child: Text('Welcome to the Homeworks Screen!'),
      ),
    );
  }
}