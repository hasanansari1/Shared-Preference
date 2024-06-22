import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashBoard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isFilled = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (_) => _checkEmail(),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                onChanged: (_) => _checkPassword(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isFilled ? () => login(context) : null,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkEmail() {
    setState(() {
      _isEmailValid = RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text.trim());
      _isFilled = _isEmailValid && _isPasswordValid;
    });
  }

  void _checkPassword() {
    setState(() {
      _isPasswordValid = _passwordController.text.trim().length >= 6;
      _isFilled = _isEmailValid && _isPasswordValid;
    });
  }

  void login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('email', _emailController.text.trim()); // Store the entered email
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}
