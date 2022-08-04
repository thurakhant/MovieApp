import 'package:flutter/material.dart';

class SeeMoreText extends StatelessWidget {
  final String text;

  const SeeMoreText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }
}
