import '../template/template.dart';

class SizedText extends StatelessWidget {
  final double? width;
  final double? height;
  final dynamic text;
  TextStyle? textStyle;
  final bool useLocaleText;
  final bool softWrap;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final int? maxLines;

  // final Color? color;
  // final double? fontSize;
  // final FontWeight? fontWeight;
  // final String? fontFamily;

  SizedText({
    this.width,
    this.height,
    required this.text,
    this.textStyle,
    this.useLocaleText = true,
    this.softWrap = false,
    this.overflow = TextOverflow.visible,
    this.textAlign = TextAlign.left,
    this.maxLines,
    // this.color,
    // this.fontSize,
    // this.fontWeight,
    // this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: width,
      height: height,
      child: Text(
        text.toString(),
        style: textStyle ??
            TextStyle(
              height: textStyle?.height,
              color: textStyle?.color,
              fontSize: ThemeTextRegular.k14.fontSize,
              fontWeight: textStyle?.fontWeight,
              decoration: textStyle?.decoration,
              background: textStyle?.background,
              fontFamily: textStyle?.fontFamily,
              fontFamilyFallback: textStyle?.fontFamilyFallback,
              fontStyle: textStyle?.fontStyle,
              wordSpacing: textStyle?.wordSpacing,
              textBaseline: textStyle?.textBaseline,
              overflow: textStyle?.overflow,
              letterSpacing: textStyle?.letterSpacing,
              decorationThickness: textStyle?.decorationThickness,
              decorationColor: textStyle?.decorationColor,
              decorationStyle: textStyle?.decorationStyle,
            ).copyWith(
              color: isDark ? ThemeColors.white : ThemeColors.black,
            ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
      ),
    );
  }
}
