import 'package:flutter/material.dart';
import 'package:ta_osso/Onboarding/onboarding_view.dart';
import 'package:ta_osso/pages/home_view.dart';

void main() {
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

