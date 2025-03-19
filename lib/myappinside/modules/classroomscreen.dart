import 'package:flutter/material.dart';

class classroomscreen extends StatelessWidget {
  const classroomscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom'),
      ),
      body: const Center(
        child: Text('Welcome to the Classroom Screen!'),
      ),
    );
  }
}