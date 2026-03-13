import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int messageIndex = 0;
  int colorIndex = 0;

  List<String> messages = [
    'Hello Yongdal Academy!',
    'You built an app!',
    'Welcome to Tech!',
    'Future App Developer!',
  ];

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[colorIndex],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text
            Text(
              messages[messageIndex],
              style: const TextStyle(
                fontSize: 36,
                color: Colors.white,
              ),
            ),

            // Spacing
            const SizedBox(height: 20),

            // Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  messageIndex = (messageIndex + 1) % messages.length;
                  colorIndex = (colorIndex + 1) % colors.length;
                });
              },
              child: const Text('Tap me'),
            ),
          ],
        ),
      ),
    );
  }
}
