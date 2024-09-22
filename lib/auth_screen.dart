import 'package:flutter/material.dart';
import 'auth_service.dart'; // Import the AuthService

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(); // New controller
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login / Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _emailController, // Email field
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final user = await _authService.signUp(
                  _usernameController.text,
                  _passwordController.text,
                  _emailController.text, // Pass email to signUp
                );
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/tasks');
                }
              },
              child: Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () async {
                final user = await _authService.login(
                  _usernameController.text,
                  _passwordController.text,
                );
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/tasks');
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
