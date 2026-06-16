import 'package:flutter/material.dart';
import 'package:demo_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // =================================================================
    // 👉 KID CODER TASK: CHANGE THE APP COLOR!
    // Find "Colors.deepPurple" below. Try changing it to another color:
    // Colors.blue, Colors.teal, Colors.amber, Colors.pink, Colors.red, Colors.green
    // Then press Save (Ctrl + S) to watch the app colors change instantly!
    // =================================================================
    const Color primarySeedColor = Colors.deepPurple;

    return MaterialApp(
      title: 'TeenTech Hub 2026',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primarySeedColor,
          brightness: Brightness.dark, // Sleek dark mode for modern visual appeal
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // Modern, clean typography
      ),
      home: const HomePage(),
    );
  }
}
