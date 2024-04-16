import 'package:flutter/material.dart';

class Rabbit extends StatelessWidget {
  static const String _imageUrl =
      'https://thumbs.dreamstime.com/z/white-rabbit-isolated-white-background-39621701.jpg?ct=jpeg';
  const Rabbit({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.network(
        _imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.contain,
      ),
    );
  }
}
