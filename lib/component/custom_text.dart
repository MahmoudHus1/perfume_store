import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final double? textHeight;

  const CustomText(
      {required this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textAlign,
      this.textHeight = 1,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: textHeight,
        color: color,
      ),
      textAlign: textAlign,
    );
  }
}
