import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Returns the app's primary font family.
/// Update this when a custom font is added to pubspec.yaml.
String? fontSelection() => null;

/// Maps an integer index to a [FontWeight].
///
/// | index | weight        |
/// |-------|---------------|
/// | 0     | w100 – Thin   |
/// | 1     | w200          |
/// | 2     | w300 – Light  |
/// | 3     | w400 – Normal |
/// | 4     | w500 – Medium |
/// | 5     | w600 – SemiBold |
/// | 6     | w700 – Bold   |
/// | 7     | w800 – ExtraBold |
/// | 8     | w900 – Black  |
FontWeight? fontWeightSelection({int? fontWeightIndex}) {
  if (fontWeightIndex == null) return null;
  const weights = [
    FontWeight.w100,
    FontWeight.w200,
    FontWeight.w300,
    FontWeight.w400,
    FontWeight.w500,
    FontWeight.w600,
    FontWeight.w700,
    FontWeight.w800,
    FontWeight.w900,
  ];
  if (fontWeightIndex < 0 || fontWeightIndex >= weights.length) return null;
  return weights[fontWeightIndex];
}

class AppTextWidget extends StatefulWidget {
  const AppTextWidget({
    super.key,
    required this.text,
    this.textColor,
    this.textSize,
    this.textWidth,
    this.isTextCenter,
    this.textAlign,
    this.fontWeightIndex,
    this.isEllipsisTextOverflow,
    this.maxLines,
    this.decorationText = TextDecoration.none,
    this.decorationTextColor,
    this.letterSpacing,
  });

  final String text;
  final Color? textColor;
  final double? textSize;
  final double? textWidth;
  final bool? isTextCenter;
  final TextAlign? textAlign;
  final int? fontWeightIndex;
  final bool? isEllipsisTextOverflow;
  final int? maxLines;
  final TextDecoration decorationText;
  final Color? decorationTextColor;
  final double? letterSpacing;

  @override
  State<AppTextWidget> createState() => _AppTextWidgetState();
}

class _AppTextWidgetState extends State<AppTextWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.textWidth,
      child: Text(
        widget.text,
        textAlign: widget.textAlign ??
            (widget.isTextCenter == true ? TextAlign.center : TextAlign.start),
        maxLines: widget.maxLines,
        softWrap: true,
        style: TextStyle(
          overflow: widget.isEllipsisTextOverflow == true
              ? TextOverflow.ellipsis
              : TextOverflow.visible,
          fontSize: widget.textSize,
          fontWeight: fontWeightSelection(fontWeightIndex: widget.fontWeightIndex),
          color: widget.textColor ?? AppColors.blackColor,
          fontFamily: fontSelection(),
          fontFamilyFallback: const [
            'Apple Color Emoji',
            'Noto Color Emoji',
            'Segoe UI Emoji',
          ],
          decoration: widget.decorationText,
          decorationColor: widget.decorationTextColor,
          decorationThickness: 3,
          letterSpacing: widget.letterSpacing,
        ),
      ),
    );
  }
}
