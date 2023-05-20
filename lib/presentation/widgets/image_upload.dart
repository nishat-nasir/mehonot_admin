import 'package:dotted_border/dotted_border.dart';

import '../template/template.dart';

class PrsmImageUpload extends StatelessWidget {
  const PrsmImageUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 100.w,
        height: 450.h,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: ThemeColors.blue100,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: DottedBorder(
            strokeCap: StrokeCap.butt,
            color: ThemeColors.blue500,
            strokeWidth: 1.w,
            dashPattern: [6, 4],
            padding: EdgeInsets.all(15.w),
            radius: Radius.circular(20.r),
            child: Center(
              child: SpacedColumn(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/png/gallery_icon.png",
                        width: 140.w, height: 140.h),
                    PrimaryButton(
                        buttonText: "Upload Image",
                        buttonSize: ButtonSize.M,
                        onPressed: () {})
                  ]),
            )));
  }
}
