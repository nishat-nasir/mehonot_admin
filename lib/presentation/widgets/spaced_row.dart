import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpacedRow extends StatelessWidget {
  //Do not add screenUtil, Just pass double value
  final double? horizontalSpace;
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const SpacedRow(
      {this.horizontalSpace = 0.0,
      required this.children,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.start,
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
          width: horizontalSpace!.w,
        ));
      }
    }
    return Row(
      mainAxisAlignment: mainAxisAlignment!,
      crossAxisAlignment: crossAxisAlignment!,
      children: widgets,
    );
  }
}
