import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Adicionei Scaffold aqui
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bem vindo ao Ta Osso 🦴",
              style: TextStyle(
                color: Colors.black,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Login no Ta Osso",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 44.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email, color: Colors.black),
              ),
            ),
            SizedBox(height: 26.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Senha',
                prefixIcon: Icon(Icons.lock, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
