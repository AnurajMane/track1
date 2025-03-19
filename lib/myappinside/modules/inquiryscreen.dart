import 'package:flutter/material.dart';

class inquiryscreen extends StatelessWidget {
  const inquiryscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inquiry'),
      ),
      body: const Center(
        child: Text('Welcome to the Inquiry Screen!'),
      ),
    );
  }
}