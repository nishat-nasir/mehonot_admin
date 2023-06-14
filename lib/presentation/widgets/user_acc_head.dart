import '../template/template.dart';

class UserAccountHeadWidget extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback? onTap;

  const UserAccountHeadWidget({
    Key? key,
    required this.name,
    required this.email,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
          height: 180.h,
          decoration: BoxDecoration(
            color: isDark ? PrsmColorsDark.canvasColor : ThemeColors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color: isDark ? ThemeColors.bluegray600 : ThemeColors.gray200,
                width: .5.w),
            // boxShadow: ThemeShadows.shadowSm,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: SpacedRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpacedRow(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  horizontalSpace: 16,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: PrsmColorsCommon.secondaryContainerColor,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(
                            color: isDark
                                ? ThemeColors.bluegray600
                                : ThemeColors.gray200,
                            width: .5.w),
                        // boxShadow: ThemeShadows.shadowSm
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 22.w, vertical: 12.h),
                      child: const HeroIcon(
                        HeroIcons.user,
                        style: HeroIconStyle.solid,
                        color: ThemeColors.indigo200,
                      ),
                    ),
                    SpacedColumn(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedText(
                              text: name, textStyle: ThemeTextSemiBold.k14),
                          SizedText(
                              text: email, textStyle: ThemeTextRegular.k12),
                        ]),
                  ],
                ),
                const HeroIcon(HeroIcons.chevronRight,
                    style: HeroIconStyle.solid, color: ThemeColors.coolgray500)
              ])),
    );
  }
}
