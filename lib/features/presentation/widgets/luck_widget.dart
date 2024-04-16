import 'package:flutter/material.dart';

class LuckWidget extends StatelessWidget {
  final double luckPercentage;
  const LuckWidget({super.key, required this.luckPercentage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AlertDialog(
          title: const Text('Your Luck Today'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your luck today is'),
              Text(
                '100%',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }
}
