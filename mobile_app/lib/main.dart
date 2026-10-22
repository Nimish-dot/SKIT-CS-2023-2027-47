
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const SportsAIApp());
}

class SportsAIApp extends StatelessWidget {
  const SportsAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SportsAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
