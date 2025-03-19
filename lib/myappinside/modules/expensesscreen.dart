import 'package:flutter/material.dart';

class expensesscreen extends StatelessWidget {
  const expensesscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expences'),
      ),
      body: const Center(
        child: Text('Welcome to the Expences Screen!'),
      ),
    );
  }
}