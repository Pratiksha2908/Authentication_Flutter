import 'package:authentication_app_flutter/screens/dashboard_screen.dart';
import 'package:authentication_app_flutter/screens/welcome_screen.dart';
import 'package:authentication_app_flutter/screens/login_screen.dart';
import 'package:authentication_app_flutter/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Authentication());
}

class Authentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        DashboardScreen.id: (context) => DashboardScreen(),
      },
    );
  }
}
