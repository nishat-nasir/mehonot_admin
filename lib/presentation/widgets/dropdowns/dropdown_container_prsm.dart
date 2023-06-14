import 'package:mehonot_admin/presentation/template/template.dart';

class PrsmDropdownContainer extends StatelessWidget {
  final String title;
  final PrsmDropdown prsmDropdown;
  final double width;

  const PrsmDropdownContainer({
    Key? key,
    required this.title,
    this.width = 500,
    required this.prsmDropdown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    Color fillColor =
        isDark ? PrsmColorsDark.formContainerBgColor : ThemeColors.white;
    Color borderColor =
        isDark ? PrsmColorsDark.formContainerBgColor : ThemeColors.white;
    Color textColor = isDark ? ThemeColors.gray100 : ThemeColors.gray800;

    return Container(
      width: width.w,
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: fillColor,
        boxShadow: ThemeShadows.shadowSm,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalSpace: 20,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: SizedText(text: title),
          ),
          prsmDropdown,
        ],
      ),
    );
  }
}
