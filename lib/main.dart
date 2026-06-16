import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demo_app/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Hide system status bar and navigation bar (immersive sticky mode) for kiosk stand view
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // =================================================================
    // 👉 KID CODER TASK 1: CHANGE THE APP COLOR!
    // Find "Colors.deepPurple" below. Try changing it to another color:
    // Colors.blue, Colors.teal, Colors.amber, Colors.pink, Colors.red, Colors.green
    // Then press Save (Ctrl + S) to watch the app colors change instantly!
    // =================================================================
    const Color primarySeedColor = Colors.deepPurple;

    // =================================================================
    // 👉 KID CODER TASK 2: CHANGE APP BRIGHTNESS (LIGHT VS. DARK MODE)!
    // Find "Brightness.dark" below. Change it to "Brightness.light"
    // to see the app switch to light mode instantly!
    // =================================================================
    const Brightness appBrightness = Brightness.dark;

    return MaterialApp(
      title: 'TeenTech Hub 2026',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primarySeedColor,
          brightness: appBrightness,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // Modern, clean typography
      ),
      home: const HomePage(),
    );
  }
}
