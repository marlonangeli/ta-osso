import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ta_osso/pages/Onboarding/onboarding_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await dotenv.load(fileName: '../.env');
    final firebaseOptions = FirebaseOptions(
      apiKey: dotenv.env['API_KEY']!,
      messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
      measurementId: dotenv.env['MEASUREMENT_ID']!,
      authDomain: dotenv.env['AUTH_DOMAIN']!,
      projectId: dotenv.env['PROJECT_ID']!,
      appId: dotenv.env['WEB_APP_ID']!,
      storageBucket: dotenv.env['WEB_STORAGE_BUCKET']!,
    );
    await Firebase.initializeApp(options: firebaseOptions);

  } else {
    await Firebase.initializeApp();
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ta Osso',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
        useMaterial3: true,
      ),
      home: const OnboardingView(),
    );
  }
}
