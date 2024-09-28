import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quick_task/Screens/Authentication/registeration.dart';
import 'package:quick_task/Screens/Dashboard/task_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              _isMobile(context) ? 'lib/assets/image_mobile.jpg' : 'lib/assets/image_desktop.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),
          Align(
            alignment: _isMobile(context) ? Alignment.center : Alignment.centerRight,
            child: Padding(
              padding: _isMobile(context)
                  ? const EdgeInsets.all(16.0)
                  : const EdgeInsets.only(left: 40.0, right: 40.0, top: 100.0), // added top padding
              child: Container(
                width: _isMobile(context)
                    ? MediaQuery.of(context).size.width * 0.8
                    : MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  mainAxisAlignment: _isMobile(context)
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  crossAxisAlignment: _isMobile(context)
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    if (!_isMobile(context))
                      SizedBox(height: 100), // added SizedBox to push the form down
                    const Icon(
                      Icons.task,
                      color: Colors.blueAccent,
                      size: 80,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _usernameController,
                      label: 'Username',
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      obscureText: true,
                      prefixIcon: Icons.lock,
                    ),
                    const SizedBox(height: 24),
                    _buildLoginButton(),
                    const SizedBox(height: 20),
                    _buildRegisterText(context),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required IconData prefixIcon,
  bool obscureText = false,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white30),
    ),
    child: AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            if (controller.text.isEmpty)
              Positioned(
                left: 50,
                child: Text(
                  label,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            TextFormField(
              controller: controller,
              obscureText: obscureText,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(prefixIcon, color: Colors.white70),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ],
        );
      },
    ),
  );
}

  Widget _buildLoginButton() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 10),
    child: ElevatedButton(
      onPressed: _isLoading ? null : _doLogin,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: _isLoading
          ? CircularProgressIndicator(color: Colors.white)
          : Text(
              'Login',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
    ),
  );
}

  Widget _buildRegisterText(BuildContext context) {
    return Row(
      mainAxisAlignment: _isMobile(context)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPage(),
              ),
            );
          },
          child: const Text(
            'Register',
            style: TextStyle(color: Colors.blueAccent, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Future<void> _doLogin() async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final user = ParseUser(username, password, null);
    var response = await user.login();

    setState(() {
      _isLoading = false;
    });

    if (response.success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TaskDashboard()),
      );
    } else {
      _showError(response.error!.message);
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Login Failed"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}