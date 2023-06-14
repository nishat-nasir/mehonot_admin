import '../template/template.dart';

class CircleHeadWidget extends StatelessWidget {
  String? title;
  String? detailText;
  HeroIcons? icon;
  double? circleSize;
  double? iconSize;

  CircleHeadWidget({
    super.key,
    this.title,
    this.detailText,
    this.icon,
    this.circleSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      children: [
        Container(
          height: circleSize ?? 180.w,
          width: circleSize ?? 180.w,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: PrsmColorsCommon.secondaryContainerColor),
          child: (icon == null)
              ? SizedText(
            text: title ?? "",
            textStyle:
            ThemeTextRegular.k12.copyWith(color: ThemeColors.white),
          )
              : HeroIcon(icon ?? HeroIcons.exclamationTriangle,
              size: iconSize ?? 100.h,
              color: ThemeColors.white,
              style: HeroIconStyle.outline),
        ),
        if (detailText != null)
          SizedText(
              text: detailText,
              width: 200.w,
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textStyle: ThemeTextSemiBold.k10)
      ],
    );
  }
}
