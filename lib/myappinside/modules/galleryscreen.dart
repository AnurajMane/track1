import 'package:flutter/material.dart';

class galleryscreen extends StatelessWidget {
  const galleryscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: const Center(
        child: Text('Welcome to the Image Gallery Screen!'),
      ),
    );
  }
}