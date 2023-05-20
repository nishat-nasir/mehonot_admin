import 'package:mehonot_admin/presentation/template/template.dart';
import '../../../manager/models/model_exporter.dart';

class PrsmJobContainer extends StatelessWidget {
  final JobModel jobModel;
  final VoidCallback onTap;
  final VoidCallback? onReqAccept;
  final VoidCallback? onReqDecline;
  final bool? showAsAd;

  const PrsmJobContainer({
    Key? key,
    required this.jobModel,
    required this.onTap,
    this.onReqAccept,
    this.onReqDecline,
    this.showAsAd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(8.r);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          color: isDark
              ? MehonotColorsDark.formContainerBgColor
              : ThemeColors.white,
          child: SpacedRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              horizontalSpace: 20,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: ClipRRect(
                        borderRadius: borderRadius,
                        child: Image.asset('assets/images/png/nft.jpg',
                            fit: BoxFit.fill, width: 150.w, height: 150.h))),
                Container(
                    width: 1.w, height: 170.h, color: ThemeColors.coolgray500),
                SpacedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedText(
                        text: jobModel.title,
                        textStyle: ThemeTextSemiBold.k12,
                        maxLines: 2,
                        softWrap: true,
                        width: 650.w,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(
                        width: 650.w,
                        child: SpacedRow(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SpacedColumn(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildDetails(
                                      icon: HeroIcons.mapPin,
                                      text:
                                          "${jobModel.address.city ?? ""} ${jobModel.address.division}"),
                                  SizedBox(height: 5.h),
                                  Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: SpacedRow(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          horizontalSpace: 20,
                                          children: [
                                            buildDetails(
                                                icon: HeroIcons.clock,
                                                iconSize: 36.h,
                                                text:
                                                    "${jobModel.workStartTime.toString()}-${jobModel.workFinishTime.toString()}"),
                                            buildDetails(
                                                icon:
                                                    HeroIcons.informationCircle,
                                                iconSize: 36.h,
                                                text: jobModel.type ?? "")
                                          ]))
                                ]),
                          ],
                        ),
                      ),
                    ]),
                SpacedColumn(verticalSpace: 40, children: [
                  if (onReqDecline != null)
                    InkWell(
                        onTap: onReqDecline,
                        child: Container(
                            decoration: BoxDecoration(
                                color: ThemeColors.red500,
                                borderRadius: BorderRadius.circular(8.r)),
                            padding: EdgeInsets.all(5.w),
                            child: HeroIcon(
                              HeroIcons.xMark,
                              size: 40.h,
                              color: ThemeColors.white,
                            ))),
                  if (onReqDecline != null)
                    InkWell(
                        onTap: onReqAccept,
                        child: Container(
                            decoration: BoxDecoration(
                                color: ThemeColors.blue500,
                                borderRadius: BorderRadius.circular(8.r)),
                            padding: EdgeInsets.all(5.w),
                            child: HeroIcon(HeroIcons.check,
                                size: 40.h, color: ThemeColors.white)))
                ])
              ]),
        ));
  }

  Widget buildDetails(
      {required HeroIcons icon, required String text, double? iconSize}) {
    return SpacedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        horizontalSpace: 10,
        children: [
          HeroIcon(
            icon,
            style: HeroIconStyle.outline,
            size: iconSize ?? 30.h,
          ),
          SizedText(text: text, textStyle: ThemeTextRegular.k10)
        ]);
  }
}
