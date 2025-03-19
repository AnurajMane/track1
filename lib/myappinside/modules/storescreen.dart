import 'package:flutter/material.dart';

class storescreen extends StatelessWidget {
  const storescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
      ),
      body: const Center(
        child: Text('Welcome to the Store Screen!'),
      ),
    );
  }
}