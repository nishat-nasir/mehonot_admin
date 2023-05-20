import '../../template/template.dart';

class PrsmLocationButton extends StatelessWidget {
  final double? width;
  final TextStyle? textStyle;
  final VoidCallback onTap;
  final String text;
  final VoidCallback? onLongPress;

  PrsmLocationButton({
    Key? key,
    this.width,
    this.textStyle,
    required this.onTap,
    required this.text,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: ThemeColors.white,
        borderRadius: BorderRadius.circular(14.r),
        radius: 14.r,
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
            decoration: BoxDecoration(
              gradient: MehonotColorsCommon.locationContainerColor,
              borderRadius: BorderRadius.all(Radius.circular(14.r)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            height: 95.h,
            alignment: Alignment.center,
            child: SpacedRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SpacedRow(
                  horizontalSpace: 20,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HeroIcon(
                      HeroIcons.mapPin,
                      style: HeroIconStyle.outline,
                      color: ThemeColors.white,
                      size: 55.h,
                    ),
                    SizedText(
                        text: text,
                        textStyle: textStyle ??
                            ThemeTextBold.k14.apply(color: ThemeColors.white)),
                  ],
                ),
                HeroIcon(
                  HeroIcons.adjustmentsVertical,
                  style: HeroIconStyle.outline,
                  color: ThemeColors.white,
                  size: 55.h,
                ),
              ],
            )));
  }
}
