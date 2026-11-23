import 'package:flutter/material.dart';

import 'pages/homepage.dart';
import 'pages/signin.dart';
import 'pages/signup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PetopiaApp());
}

class PetopiaApp extends StatelessWidget {
  const PetopiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petopia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF55A6D9),
        useMaterial3: true,
      ),
      home: const SignInPage(),
      routes: {
        '/login': (context) => const SignInPage(),
        '/register': (context) => const SignUpPage(),
        '/home': (context) => const Homepage(),
      },
    );
  }
}