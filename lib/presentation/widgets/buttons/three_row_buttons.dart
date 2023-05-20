import '../../template/template.dart';

class PrsmThreeRowButtons extends StatelessWidget {
  final List<HeroIcons> iconList;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final VoidCallback onTap3;

  const PrsmThreeRowButtons({
    required this.iconList,
    required this.onTap1,
    required this.onTap2,
    required this.onTap3,
  });

  @override
  Widget build(BuildContext context) {
    return SpacedRow(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          singleButton(icon: iconList[0], leftRadius: true, onTap: onTap1),
          Container(width: 2.w, height: 68.h, color: ThemeColors.white),
          singleButton(icon: iconList[1], onTap: onTap2),
          Container(width: 2.w, height: 68.h, color: ThemeColors.white),
          singleButton(icon: iconList[2], rightRadius: true, onTap: onTap3),
        ]);
  }

  Widget singleButton({
    required HeroIcons icon,
    required VoidCallback onTap,
    bool? leftRadius,
    bool? rightRadius,
  }) {
    return SizedBox(
      height: 140.h,
      width: 240.w,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(MehonotColorsCommon.buttonColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: borderRadius(
                    leftRadius: leftRadius, rightRadius: rightRadius))),
          ),
          onPressed: onTap,
          child: HeroIcon(
            icon,
            color: ThemeColors.white,
            size: 80.h,
          )),
    );
  }

  BorderRadiusGeometry borderRadius({
    bool? leftRadius,
    bool? rightRadius,
  }) {
    if (leftRadius == true && rightRadius == true) {
      return BorderRadius.circular(18.r);
    } else if (leftRadius == true) {
      return BorderRadius.only(
          topLeft: Radius.circular(18.r), bottomLeft: Radius.circular(18.r));
    } else if (rightRadius == true) {
      return BorderRadius.only(
          topRight: Radius.circular(18.r), bottomRight: Radius.circular(18.r));
    } else {
      return BorderRadius.zero;
    }
  }
}
