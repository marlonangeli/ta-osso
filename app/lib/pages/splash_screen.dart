/*import 'package:flutter/material.dart';
import 'package:ta_osso/common/constants/routes.dart';
import 'package:ta_osso/services/prefs_service.dart';
import 'package:ta_osso/pages/Onboarding/onboarding_view.dart';
import 'package:ta_osso/pages/Auth/login_view.dart';

 class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
  
}

 class _SplashScreenState extends State<SplashScreen> {
  final PrefsService _prefsService = PrefsService();
  final String _onboardingKey = 'onboarding_completed';

  @override
  void initState(){
    super.initState();
    _checkOnboardingStatus();
  }
}

Future<void> _checkOnboardingStatus() async{
  bool jaConcluido = await _prefsService.carregarBool (_onboardingKey);
  if (jaConcluido){
    _irParaLogin();
  } else{
    _irParaOnboarding();
  }
}

void _irParaLogin(){
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => LoginScreen()));
}

*/