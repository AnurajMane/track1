import 'package:flutter/material.dart';

class onlinetestscreen extends StatelessWidget {
  const onlinetestscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Tests'),
      ),
      body: const Center(
        child: Text('Welcome to the Online Tests Screen!'),
      ),
    );
  }
}