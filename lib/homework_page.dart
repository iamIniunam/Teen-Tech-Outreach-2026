import 'package:flutter/material.dart';

class HomeworkPage extends StatefulWidget {
  const HomeworkPage({super.key});

  @override
  State<HomeworkPage> createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage> {
  bool isHomeWorkDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: colors[colorIndex],
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text
            Text(
              // messages[messageIndex],
              // 'yongdal academy is the best school',
              isHomeWorkDone
                  ? 'Good work, your assignment is done'
                  : 'Your maths home work is due tomorrow',
              textAlign: TextAlign.center,
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
                  isHomeWorkDone = !isHomeWorkDone;
                });
              },
              child: const Text('Mark as done'),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  isHomeWorkDone = false;
                });
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
