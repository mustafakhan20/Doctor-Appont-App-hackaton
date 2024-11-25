import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final bool? softwrap;
  final double? fontsize;
  final FontWeight? fontweight;
  final Color? color;
  final FontStyle? fontstyle;
  final TextAlign? textalign;
  final fontfamily;
  final double? letterSpacing;
  final double? wordSpacing;

  const TextWidget({
    super.key,
    required this.text,
    this.fontsize,
    this.fontweight,
    this.color,
    this.fontstyle,
    this.textalign,
    this.softwrap,
    this.fontfamily,
    this.letterSpacing,
    this.wordSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textalign,
      softWrap: softwrap,
      style: TextStyle(
          fontSize: fontsize,
          fontWeight: fontweight,
          color: color,
          fontStyle: fontstyle,
          fontFamily: fontfamily,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing),
    );
  }
}
