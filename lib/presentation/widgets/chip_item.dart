import '../template/template.dart';

class ChipItem extends StatefulWidget {
  String text;
  VoidCallback? onTap;
  double percentage;
  VoidCallback? onDeleted;

  ChipItem(
      {Key? key,
      required this.text,
      this.onTap,
      required this.percentage,
      this.onDeleted})
      : super(key: key);

  @override
  State<ChipItem> createState() => _ChipItemState();
}

class _ChipItemState extends State<ChipItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: Chip(
            backgroundColor: chipItemColor(widget.percentage),
            elevation: 2,
            deleteIcon:
                Icon(Icons.close, size: 24.h, color: ThemeColors.coolgray900),
            deleteButtonTooltipMessage: 'Close',
            deleteIconColor: ThemeColors.coolgray900,
            surfaceTintColor: isDark(context)
                ? PrsmColorsDark.accentColor
                : ThemeColors.lightblue200,
            autofocus: true,
            onDeleted: widget.onDeleted,
            // padding: const EdgeInsets.symmetric(horizontal: ),
            // avatar:
            //     Icon(Icons.add, color: ThemeColors.lightblue900, size: 32.h),
            label: SizedText(
              text: widget.text,
              textStyle: ThemeTextRegular.k10.copyWith(
                  color: widget.percentage >= 80
                      ? ThemeColors.white
                      : ThemeColors.coolgray900,
                  fontWeight: FontWeight.w500),
            )));
  }

  Color chipItemColor(double percentage) {
    logger("percentage : $percentage");
    if (percentage < 50) {
      return ThemeColors.indigo200;
    } else if (percentage < 80) {
      return ThemeColors.indigo400;
    } else {
      return ThemeColors.indigo600;
    }
  }
}
