import 'dart:io';

import 'package:flutter/material.dart';

class LuckWidget extends StatelessWidget {
  final double luckPercentage;
  const LuckWidget({super.key, required this.luckPercentage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AlertDialog(
          title: const Text('Your Luck Today'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text('Your luck today is '),
                  Text(
                    '$luckPercentage%',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: const Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }
}
