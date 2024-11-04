import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SingUpView extends StatefulWidget {
  const SingUpView({super.key});

  @override
  State<SingUpView> createState() => _SingUpViewState();
}

class _SingUpViewState extends State<SingUpView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _firebaseError = false;

  Future<FirebaseApp> _initializeFirebase() async {
    try {
      FirebaseApp firebaseApp = await Firebase.initializeApp();
      return firebaseApp;
    } catch (e) {
      setState(() {
        _firebaseError = true;
      });
      return Future.error('Erro ao inicializar o Firebase');
    }
  }

  static Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nenhum usuário encontrado para esse email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Senha incorreta fornecida.')),
        );
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_firebaseError)
                  const Text(
                    'Erro ao conectar com o Firebase. Algumas funcionalidades podem estar limitadas.',
                    style: TextStyle(color: Colors.red),
                  ),
                const Text(
                  "Bem-vindo ao Ta Osso 🦴",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Faça Seu Cadastro",
                  style: TextStyle(
                    color: Colors.black,
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
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 44.0),
                TextField(
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: '(xx)xxxxx-xxxx',
                    prefixIcon: Icon(Icons.phone, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 44.0),
                TextField(
                  controller: _birthdayController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'xx/xx/xxxx',
                    prefixIcon: Icon(Icons.date_range, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 44.0),
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
                const SizedBox(
                  height: 88.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RawMaterialButton(
                    fillColor: const Color.fromARGB(255, 238, 196, 7),
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () async {
                      User? user = await loginUsingEmailPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        context: context,
                      );

                      if (user != null) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Página Inicial"),
      ),
    );
  }
}