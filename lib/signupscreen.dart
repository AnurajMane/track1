import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<signupscreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? selectedRole;
  bool _isLoading = false;

  Future<void> _signup() async {
    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role.')),
      );
      return;
    }

    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response.user != null) {
        await Supabase.instance.client.from('Users').insert({
          'email': _emailController.text.trim(),
          'role': selectedRole,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup successful! Check your email to verify your account.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signupWithGoogle() async {
    try {
      await Supabase.instance.client.auth.signInWithOAuth(OAuthProvider.google);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Signup Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedRole,
              hint: const Text('Select Role'),
              items: ['Admin', 'Student', 'Driver', 'Parent']
                  .map((role) => DropdownMenuItem(
                value: role,
                child: Text(role),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _signup,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Sign Up'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _signupWithGoogle,
              child: const Text('Sign Up with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
