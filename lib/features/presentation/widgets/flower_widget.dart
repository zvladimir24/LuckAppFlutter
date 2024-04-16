import 'package:flutter/material.dart';

class Flower extends StatelessWidget {
  static const String _imageUrl =
      'https://thumbs.dreamstime.com/z/four-leaf-clover-13136197.jpg?ct=jpeg';
  const Flower({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      _imageUrl,
      width: 50,
      height: 50,
      fit: BoxFit.contain,
    );
  }
}
