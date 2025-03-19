import 'package:flutter/material.dart';

class mycanteenscreen extends StatelessWidget {
  const mycanteenscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Canteen'),
      ),
      body: const Center(
        child: Text('Welcome to the Canteenl Screen!'),
      ),
    );
  }
}