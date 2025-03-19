import 'package:flutter/material.dart';

class libraryscreen extends StatelessWidget {
  const libraryscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: const Center(
        child: Text('Welcome to the Library Screen!'),
      ),
    );
  }
}