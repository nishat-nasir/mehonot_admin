import '../../template/template.dart';

class PrsmSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final HeroIcons? leftIcon;
  final HeroIcons? rightIcon;
  final double? paddingTop;
  final VoidCallback? onRightIconPress;
  final VoidCallback? onLeftIconPress;
  final TextEditingController? searchController;
  final Function(String)? onSearch;

  const PrsmSearchAppBar({
    Key? key,
    this.titleText,
    this.leftIcon,
    this.rightIcon,
    this.paddingTop,
    this.onRightIconPress,
    this.onLeftIconPress,
    this.searchController,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
        height: ThemeSizeStyle.appBarHeight.h,
        decoration: BoxDecoration(
            color: isDark
                ? PrsmColorsDark.appBarColor
                : PrsmColorsLight.appBarColor,
            // boxShadow: ThemeShadows.shadowSm,
            border: Border(
                bottom: BorderSide(
                    width: .5.h,
                    color: isDark
                        ? PrsmColorsDark.appBarColor
                        : ThemeColors.coolgray300))),
        padding:
            EdgeInsets.symmetric(horizontal: 15.w, vertical: paddingTop ?? 3.h),
        child: SafeArea(
            right: false,
            left: false,
            bottom: false,
            child: _getActions(context)));
  }

  Widget _getActions(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SpacedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          SizedBox(
              width: MediaQuery.of(context).size.width - 300.w,
              height: 100.h,
              child: PrsmInputField(
                enableShadow: false,
                controller: searchController,
                onFieldSubmitted: onSearch,
                fillColor:
                    isDark ? PrsmColorsDark.formFillColor : ThemeColors.gray50,
                defaultBorderColor:
                    isDark ? ThemeColors.coolgray500 : ThemeColors.coolgray300,
              )),
          IconButton(
              onPressed: onRightIconPress,
              icon: HeroIcon(HeroIcons.magnifyingGlass,
                  size: 54.w,
                  color: isDark ? ThemeColors.white : ThemeColors.black)),
          const SizedBox(),
        ]);
  }

  @override
  Size get preferredSize => Size(double.infinity, 100.h);
}
