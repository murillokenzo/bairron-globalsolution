import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const BairroOnApp());
}

class BairroOnApp extends StatelessWidget {
  const BairroOnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BairroOn',
      debugShowCheckedModeBanner: false,
      theme: criarTema(),
      home: const WelcomeScreen(),
    );
  }
}
