import 'package:flutter/material.dart';
import 'main.dart'; // Import your main.dart file
import 'loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Initialize bounce animation
    _animation = Tween<double>(begin: 0, end: 20).animate(_controller);

    // Simulate loading process
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showButton = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bouncing School Bus Logo
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _animation.value),
                    child: const Icon(
                      Icons.directions_bus,
                      size: 100,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // App Title
              const Text(
                'School Bus Tracking System',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Loading Indicator
              if (!_showButton)
                const CircularProgressIndicator(
                  color: Colors.white,
                ),

              // Tap to Continue Button
              if (_showButton)
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the main app screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const loginscreen(), // Navigate to LoginScreen
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Tap to Continue',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF2575FC),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}