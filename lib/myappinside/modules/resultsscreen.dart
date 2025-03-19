import 'package:flutter/material.dart';

class resultsscreen extends StatelessWidget {
  const resultsscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results and Score Cards'),
      ),
      body: const Center(
        child: Text('Welcome to the Results Screen!'),
      ),
    );
  }
}