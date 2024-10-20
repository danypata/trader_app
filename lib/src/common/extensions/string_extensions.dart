import 'package:flutter/material.dart';

extension StringMeasurements on String {
  Size measureText(TextStyle style, {int maxLines = 1}) {
    final textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size;
  }
}
