import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ta_osso/common/constants/app_colors.dart';
import 'package:ta_osso/common/constants/routes.dart';
import 'package:ta_osso/pages/home/home_page_view.dart';
import 'package:ta_osso/services/auth_service.dart';
import 'package:ta_osso/services/user_service.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: null, // TODO: arrumar
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: AppColors.timberwolf,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (_firebaseError)
                  //   const Text(
                  //     'Erro ao conectar com o Firebase. Algumas funcionalidades podem estar limitadas.',
                  //     style: TextStyle(color: Colors.red),
                  //   ),
                  // TODO: Arrumar tambem
                  const SizedBox(height: 40),
                  const Text(
                    "Bem-vindo ao Ta Osso 🦴",
                    style: TextStyle(
                      color: AppColors.eerieBlack,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Faça Seu Cadastro",
                    style: TextStyle(
                      color: AppColors.eerieBlack,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 44.0),
                  TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Nome Completo',
                      prefixIcon: Icon(Icons.person, color: AppColors.eerieBlack),
                    ),
                  ),
                  const SizedBox(height: 26.0),
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
                    decoration: const InputDecoration(
                      hintText: 'Senha',
                      prefixIcon: Icon(Icons.lock, color: AppColors.eerieBlack),
                    ),
                  ),
                  const SizedBox(height: 26.0),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Confirme a Senha',
                      prefixIcon: Icon(Icons.lock, color: AppColors.eerieBlack),
                    ),
                  ),
                  const SizedBox(height: 36.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        NamedRoutes.login,
                      );
                    },
                    child: const Text(
                      'Já tem login?',
                      style: TextStyle(color: AppColors.blue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: AppColors.aureolin,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () async {
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('As senhas não coincidem.')),
                          );
                          return;
                        }

                        User? user;

                    try {
                      // Criar usuário no Firebase Auth
                      User? user = await _authService.createUserWithEmailPassword(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                        _nameController.text.trim(),
                      );

                        if (user != null) {
                          Navigator.pushNamed(
                            context,
                            NamedRoutes.homepage,
                          );
                        }
                      },
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(color: AppColors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
