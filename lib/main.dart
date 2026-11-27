import 'package:fe/pages/splasshscreen.dart';
import 'package:flutter/material.dart';
import 'components/main_navigation.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(), 
        '/main': (context) => const MainNavigation(),       
        '/login': (context) => const SignInPage(),
        '/register': (context) => const SignUpPage(),
        '/home': (context) => const Homepage(),
      },
    );
  }
}