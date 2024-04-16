import 'package:flutter/material.dart';

class Hat extends StatelessWidget {
  final Widget? flower;
  final Widget? rabbit;

  static const String _imageUrl =
      'https://media.istockphoto.com/id/1131015471/vector/vintage-classic-top-hat-vector-illustration.jpg?s=1024x1024&w=is&k=20&c=qtwxIO5OjGDhhSBhDmLow1DqtU5mB0vmy9yjPQ3PymM=';
  const Hat({super.key, this.flower, this.rabbit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (flower != null) flower!,
        if (rabbit != null) rabbit!,
        const SizedBox(height: 10),
        SizedBox(
          child: Image.network(
            _imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
