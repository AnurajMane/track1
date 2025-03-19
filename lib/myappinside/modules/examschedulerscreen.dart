import 'package:flutter/material.dart';

class examschedulerscreen extends StatelessWidget {
  const examschedulerscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exams'),
      ),
      body: const Center(
        child: Text('Welcome to the Exam schedular Screen!'),
      ),
    );
  }
}