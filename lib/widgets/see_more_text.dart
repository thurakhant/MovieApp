import 'package:flutter/material.dart';

class SeeMoreText extends StatelessWidget {
  final String text;
  final Color textColor;

  const SeeMoreText(
    this.text, {
    this.textColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          decoration: TextDecoration.underline,
          color: textColor,
          fontWeight: FontWeight.bold),
    );
  }
}
