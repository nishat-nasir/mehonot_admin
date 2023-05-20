import '../template/template.dart';

class PrsmBottomSheetContainer extends StatelessWidget {
  final Widget child;
  const PrsmBottomSheetContainer({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
        decoration: BoxDecoration(
            color: isDark
                ? MehonotColorsDark.formContainerBgColor
                : ThemeColors.gray50,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r))),
        child: SpacedColumn(children: [
          SizedBox(height: 18.h),
          Container(
              height: 8.h,
              width: 200.w,
              decoration: BoxDecoration(
                  color: ThemeColors.coolgray400,
                  borderRadius: BorderRadius.circular(8.r))),
          SizedBox(height: 32.h),
          child
        ]));
  }
}
