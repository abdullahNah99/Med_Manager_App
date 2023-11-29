import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final int numOfTexts;
  final List<String> texts;
  final TextStyle? textStyle;
  final List<TextStyle?>? styles;
  const CustomRichText({
    super.key,
    required this.numOfTexts,
    required this.texts,
    this.textStyle,
    this.styles,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: textStyle,
        children: List.generate(
          numOfTexts,
          (index) => TextSpan(
            text: texts[index],
            style: styles != null ? styles![index] : null,
          ),
        ),
      ),
    );
  }
}
