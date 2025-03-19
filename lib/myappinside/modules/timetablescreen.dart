import 'package:flutter/material.dart';

class timetablescreen extends StatelessWidget {
  const timetablescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetables'),
      ),
      body: const Center(
        child: Text('Welcome to the Timetable Screen!'),
      ),
    );
  }
}