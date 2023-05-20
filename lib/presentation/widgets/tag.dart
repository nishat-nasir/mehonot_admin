import '../template/template.dart';

class PrsmTag extends StatefulWidget {
  final String tagName;
  final Function(String)? onTap;

  PrsmTag({
    Key? key,
    required this.tagName,
    this.onTap,
  }) : super(key: key);

  @override
  State<PrsmTag> createState() => _PrsmTagState();
}

class _PrsmTagState extends State<PrsmTag> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        setState(() {
          isActive = !isActive;
        });
        if (widget.onTap != null) {
          widget.onTap!(widget.tagName);
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isActive
                ? ThemeColors.lightblue500
                : isDark
                    ? MehonotColorsDark.canvasColor
                    : ThemeColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color: isActive
                    ? ThemeColors.lightblue400
                    : ThemeColors.coolgray400),
          ),
          child:
              SizedText(text: widget.tagName, textStyle: ThemeTextRegular.k10)),
    );
  }
}
