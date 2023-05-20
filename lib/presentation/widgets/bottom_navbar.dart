import '../template/template.dart';

class PrsmBottomNavbar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  const PrsmBottomNavbar(
      {Key? key, required this.index, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
        height: ThemeSizeStyle.bottomNavHeight.h,
        child: BottomNavigationBar(
            onTap: _onTap,
            currentIndex: index,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            elevation: 0,
            backgroundColor:
                isDark ? MehonotColorsDark.bottomNavBarColor : ThemeColors.white,
            type: BottomNavigationBarType.fixed,
            items: _getItems(index, context)));
  }

  void _onTap(int index) {
    onChanged(index);
  }

  List<BottomNavigationBarItem> _getItems(int i, BuildContext context) {
    List<BottomNavigationBarItem> list = [];

    list.add(_barItem(
      context: context,
      icon: HeroIcons.home,
      isActive: i >= 0 && i < 1,
    ));
    list.add(_barItem(
      context: context,
      icon: HeroIcons.magnifyingGlass,
      isActive: i >= 1 && i < 2,
    ));
    // list.add(_barItem(
    //   context: context,
    //   icon: HeroIcons.bars3,
    //   isActive: i >= 2 && i < 3,
    // ));
    list.add(_barItem(
      context: context,
      icon: HeroIcons.bookmark,
      isActive: i >= 2 && i < 3,
    ));
    list.add(_barItem(
      context: context,
      icon: HeroIcons.cog6Tooth,
      isActive: i >= 3 && i < 4,
    ));

    return list;
  }

  BottomNavigationBarItem _barItem({
    required HeroIcons icon,
    bool isActive = false,
    required BuildContext context,
  }) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBarItem(
        label: "",
        backgroundColor:
            isDark ? MehonotColorsDark.bottomNavBarColor : ThemeColors.white,
        icon: Column(children: [
          HeroIcon(
            icon,
            size: isActive ? 62.h : 50.h,
            style: isActive ? HeroIconStyle.solid : HeroIconStyle.outline,
            color: isDark ? ThemeColors.white : ThemeColors.black,
          ),
        ]));
  }
}
