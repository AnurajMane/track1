import 'dart:io';

void main (){
  print("Welcome to Dart..!!");

  var myC = new Myclass();
  myC.printName("Anuraj");
  myC.printName("Suhas");
  print(myC.add(1,2));
  print(myC.add(5,4));


}

class Myclass{



  void printName(String name){
    print(name);
  }

  int add(int a, int b){

    int add = a + b;

    return(add);
  }

  Myclass(){
    print("object");
  }

}


/*
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:track1/new_instance.dart'; // Ensure this import is correct

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<loginscreen> {
  String? selectedRole;

  // Navigate to role-specific login form
  void _navigateToRoleLogin() {
    if (selectedRole == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoleLoginForm(role: selectedRole!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFFDF25FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Title with Animation (Non-scrollable)
              const SizedBox(height: 40,),
              const SizedBox(
                child: const Icon(
                  Icons.directions_bus,
                  size: 90,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'School Bus Tracking System',
                      textStyle: GoogleFonts.poppins(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
              ),
              const SizedBox(height: 20),

              // Role Selection Title (Non-scrollable)
              Text(
                'Who are you?',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Scrollable Role Selection
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(26),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _RoleButton(
                        role: 'Admin',
                        icon: Icons.admin_panel_settings,
                        description: 'Manage the system and users.',
                        isSelected: selectedRole == 'Admin',
                        onTap: () {
                          setState(() {
                            selectedRole = 'Admin';
                          });
                        },
                      ),
                      _RoleButton(
                        role: 'Student',
                        icon: Icons.school,
                        description: 'Track your bus and view schedules.',
                        isSelected: selectedRole == 'Student',
                        onTap: () {
                          setState(() {
                            selectedRole = 'Student';
                          });
                        },
                      ),
                      _RoleButton(
                        role: 'Driver',
                        icon: Icons.drive_eta,
                        description: 'Manage your route and bus details.',
                        isSelected: selectedRole == 'Driver',
                        onTap: () {
                          setState(() {
                            selectedRole = 'Driver';
                          });
                        },
                      ),
                      _RoleButton(
                        role: 'Parent',
                        icon: Icons.family_restroom,
                        description: 'Track your child\'s bus and schedules.',
                        isSelected: selectedRole == 'Parent',
                        onTap: () {
                          setState(() {
                            selectedRole = 'Parent';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Continue Button (Non-scrollable)
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: selectedRole != null ? _navigateToRoleLogin : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black,
                    ),
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

// Role Button Widget
class _RoleButton extends StatelessWidget {
  final String role;
  final IconData icon;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleButton({
    required this.role,
    required this.icon,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.white : Colors.blueAccent,
            ),
            const SizedBox(height: 10),
            Text(
              role,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Role-Specific Login Form
class RoleLoginForm extends StatefulWidget {
  final String role;

  const RoleLoginForm({Key? key, required this.role}) : super(key: key);

  @override
  _RoleLoginFormState createState() => _RoleLoginFormState();
}

class _RoleLoginFormState extends State<RoleLoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Ensure Supabase client is initialized
      if (Supabase.instance.client == null) {
        throw Exception('Supabase client is not initialized.');
      }

      // Authenticate the user using Supabase
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response.user != null) {
        // Fetch the user's role from the `users` table
        final userEmail = _emailController.text.trim();
        final userData = await Supabase.instance.client
            .from('Users')
            .select('role')
            .eq('email', userEmail)
            .maybeSingle(); // Use maybeSingle() to handle no rows

        if (userData == null) {
          throw Exception('User not found in the database.');
        }

        final userRole = userData['role'] as String;

        // Navigate to the appropriate screen based on the role
        switch (userRole) {
          case 'Admin':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
            break;
          case 'Student':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
            break;
          case 'Driver':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
            break;
          case 'Parent':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
            break;
          default:
            throw Exception('Unknown role: $userRole');
        }
      } else {
        // Show error message if authentication fails
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.role} Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
 */