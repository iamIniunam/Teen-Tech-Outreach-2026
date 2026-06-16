import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demo_app/home_page.dart';
import 'package:demo_app/history_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HistoryState.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // =================================================================
    // TODO: KID CODER TASK 1 - CHANGE THE APP COLOR!
    // Find "Colors.deepPurple" below. Try changing it to another color:
    // Colors.blue, Colors.teal, Colors.amber, Colors.pink, Colors.red, Colors.green
    // Then press Save (Ctrl + S) to watch the app colors change instantly!
    // =================================================================
    const Color primarySeedColor = Colors.deepPurple;

    // =================================================================
    // TODO: KID CODER TASK 2 - CHANGE APP BRIGHTNESS (LIGHT VS. DARK MODE)!
    // Find "Brightness.dark" below. Change it to "Brightness.light"
    // to see the app switch to light mode instantly!
    // =================================================================
    const Brightness appBrightness = Brightness.dark;

    // Set the status bar and bottom navigation bar to be transparent.
    // The icon colors automatically adapt (light icons for dark mode, dark icons for light mode).
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          appBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
      statusBarBrightness: appBrightness, // for iOS
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          appBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ));

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
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(
              allowSnapshotting: false,
            ),
          },
        ),
      ),
      home: const HomePage(),
    );
  }
}
