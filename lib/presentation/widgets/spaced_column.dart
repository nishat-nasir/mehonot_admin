import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpacedColumn extends StatelessWidget {
  //Do not add screenUtil, Just pass double value
  final double? verticalSpace;
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const SpacedColumn(
      {this.verticalSpace = 0.0,
      required this.children,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in children) {
      widgets.add(element);
      if (children.last == element) {
      } else {
        widgets.add(SizedBox(
          height: verticalSpace!.h,
        ));
      }
    }
    return Column(
      mainAxisAlignment: mainAxisAlignment!,
      crossAxisAlignment: crossAxisAlignment!,
      children: widgets,
    );
  }
}
