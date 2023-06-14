import '../../template/template.dart';

class PrsmSecondaryButton extends StatelessWidget {
  final double? width;
  final TextStyle? textStyle;
  final VoidCallback onTap;
  final String text;
  final HeroIcons? icon;

  const PrsmSecondaryButton({
    Key? key,
    this.width,
    this.textStyle,
    required this.onTap,
    required this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: PrsmColorsCommon.secondaryContainerColor,
          borderRadius: BorderRadius.all(Radius.circular(18.r)),
        ),
        height: 85.h,
        width: width ?? 250.w,
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r)),
          ),
          child: SpacedRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            horizontalSpace: 20.w,
            children: [
              if (icon != null)
                HeroIcon(
                  icon!,
                  style: HeroIconStyle.solid,
                  color: ThemeColors.white,
                  size: 50.h,
                ),
              SizedText(
                  text: text,
                  textStyle: textStyle ??
                      ThemeTextBold.k14.apply(color: ThemeColors.white)),
            ],
          ),
        ));
  }
}
