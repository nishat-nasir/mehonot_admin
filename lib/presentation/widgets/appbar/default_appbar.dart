import 'package:auto_route/auto_route.dart';

import '../../template/template.dart';

class PrsmDefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final HeroIcons? leftIcon;
  final HeroIcons? rightIcon;
  final double? paddingTop;
  final VoidCallback? onRightIconPress;
  final VoidCallback? onLeftIconPress;
  final GlobalKey<ScaffoldState>? generalWrapperGlobalKey;

  const PrsmDefaultAppBar({
    super.key,
    this.generalWrapperGlobalKey,
    this.titleText,
    this.leftIcon,
    this.rightIcon,
    this.paddingTop,
    this.onRightIconPress,
    this.onLeftIconPress,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? PrsmColorsDark.appBarColor
            : PrsmColorsLight.appBarColor,
        // boxShadow: ThemeShadows.shadowSm,
        // border: Border(
        //   bottom: BorderSide(
        //     width: .5.h,
        //     color:
        //         isDark ? PrsmColorsDark.appBarColor : ThemeColors.coolgray300,
        //   ),
        // ),
      ),
      padding:
      EdgeInsets.symmetric(horizontal: 30.w, vertical: paddingTop ?? 3.h),
      child: SafeArea(
        right: false,
        left: false,
        bottom: false,
        child: _getActions(context),
      ),
    );
  }

  Widget _getActions(BuildContext context) {
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return SpacedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            if (leftIcon == null)
              IconButton(
                  onPressed: () {
                    // Open generalWrapperGlobalKey drawer
                    if (generalWrapperGlobalKey != null) {
                      generalWrapperGlobalKey!.currentState!.openDrawer();
                    }
                  },
                  icon: HeroIcon(HeroIcons.bars3,
                      size: 54.w,
                      color: isDark ? ThemeColors.white : ThemeColors.black)),
            if (leftIcon != null)
              IconButton(
                  onPressed: onLeftIconPress ?? context.router.popTop,
                  icon: HeroIcon(leftIcon!,
                      size: 54.w,
                      color: isDark ? ThemeColors.white : ThemeColors.black)),
            if (titleText != null)
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Center(
                  child: SizedText(
                    text: titleText!,
                    textAlign: TextAlign.center,
                    textStyle: ThemeTextRegular.k18,
                  ),
                ),
              )
          ]),
          if (rightIcon != null)
            IconButton(
                onPressed: onRightIconPress,
                icon: HeroIcon(rightIcon!,
                    size: 54.w,
                    color: isDark ? ThemeColors.white : ThemeColors.black))
        ]);
  }

  @override
  Size get preferredSize =>
      Size(
        double.infinity,
        ThemeSizeStyle.appBarHeight.h,
      );
}
