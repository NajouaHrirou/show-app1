import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);

    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': _emailController.text, 'password': _passwordController.text}),
    );

    setState(() => _isLoading = false);

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid credentials")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Column(
        children: [
          TextField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
          TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
          _isLoading ? const CircularProgressIndicator() : ElevatedButton(onPressed: _login, child: const Text("Login")),
        ],
      ),
    );
  }
}
