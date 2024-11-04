// lib/pages/login_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ta_osso/services/auth_services.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // Instância do AuthService
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Login no Ta Osso",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 44.0),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email, color: Colors.black),
              ),
            ),
            const SizedBox(height: 26.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Senha',
                prefixIcon: Icon(Icons.lock, color: Colors.black),
              ),
            ),
            const SizedBox(height: 88.0),
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color.fromARGB(255, 238, 196, 7),
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () async {
                  try {
                    User? user = await _authService.signInWithEmailPassword(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );

                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  } catch (e) {
                    setState(() {
                      _errorMessage = e.toString();
                    });
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
