import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  const SimpleText(
      {Key? key,
      required this.width,
      required this.text,
      required this.fontSize})
      : super(key: key);

  final double width;
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
