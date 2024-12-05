import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ta_osso/common/constants/app_colors.dart';
import 'package:ta_osso/common/constants/routes.dart';
import 'package:ta_osso/pages/Auth/signup_view.dart';
import 'package:ta_osso/pages/home/home_page_view.dart';
import 'package:ta_osso/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showPasswordResetDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _resetEmailController =
            TextEditingController();
        return AlertDialog(
          title: const Text("Recuperação de Senha"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Digite o e-mail associado à sua conta."),
              const SizedBox(height: 10),
              TextField(
                controller: _resetEmailController,
                decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                AuthService()
                    .sendPasswordResetEmail(_resetEmailController.text.trim());

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Código de recuperação enviado!')),
                );
              },
              child: const Text("Enviar Código"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.timberwolf,
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
        future: null,
        // future: _initializeFirebase(),
        builder: (context, snapshot) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (_firebaseError)
                  //   const Text(
                  //     'Erro ao conectar com o Firebase. Algumas funcionalidades podem estar limitadas.',
                  //     style: TextStyle(color: Colors.red),
                  //   ),
                  const Spacer(),
                  const Text(
                    "Bem-vindo ao Ta Osso 🦴",
                    style: TextStyle(
                      color: AppColors.eerieBlack,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Login no Ta Osso",
                    style: TextStyle(
                      color: AppColors.eerieBlack,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 44.0),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email, color: AppColors.eerieBlack),
                    ),
                  ),
                  const SizedBox(height: 26.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      hintText: 'Senha',
                      prefixIcon: Icon(Icons.lock, color: AppColors.eerieBlack),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: _showPasswordResetDialog,
                    child: const Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(color: AppColors.blue),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        NamedRoutes.signup,
                      );
                    },
                    child: const Text(
                      'Cadastrar Agora',
                      style: TextStyle(color: AppColors.blue),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: RawMaterialButton(
                    fillColor: AppColors.jonquil,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () async {
                        User? user;

                        try {
                          user = await AuthService().signInWithEmailPassword(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }

                        if (user != null) {
                          Navigator.pushNamed(
                            context,
                            NamedRoutes.homepage,
                          );
                        }
                      },
                      child: const Text(
                        "Entrar",
                        style: TextStyle(color: AppColors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
