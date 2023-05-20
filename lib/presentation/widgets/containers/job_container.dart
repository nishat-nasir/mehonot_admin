import 'package:mehonot_admin/presentation/template/template.dart';
import '../../../manager/models/model_exporter.dart';

class PrsmJobContainer extends StatelessWidget {
  final JobModel jobModel;
  final VoidCallback onTap;
  final VoidCallback? onSaveItem;
  final VoidCallback? onShowFullItem;
  final VoidCallback? onEditItem;

  const PrsmJobContainer({
    Key? key,
    required this.jobModel,
    required this.onTap,
    this.onSaveItem,
    this.onShowFullItem,
    this.onEditItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(8.r);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      color: isDark ? MehonotColorsDark.formContainerBgColor : ThemeColors.white,
      child: SpacedRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          horizontalSpace: 20,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: ClipRRect(
                      borderRadius: borderRadius,
                      child: Image.asset('assets/images/png/nft.jpg',
                          fit: BoxFit.fill, width: 150.w, height: 150.h))),
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                  width: 1.w, height: 170.h, color: ThemeColors.coolgray500),
            ),
            SpacedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onTap,
                    child: SizedText(
                      text: jobModel.title,
                      textStyle: ThemeTextSemiBold.k12,
                      maxLines: 2,
                      softWrap: true,
                      width: MediaQuery.of(context).size.width - 280.w,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 280.w,
                    child: SpacedRow(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: onTap,
                          child: SpacedColumn(
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
                                              icon: HeroIcons.informationCircle,
                                              iconSize: 36.h,
                                              text: jobModel.type ?? "")
                                        ]))
                              ]),
                        ),
                        if (onSaveItem != null)
                          InkWell(
                            onTap: onSaveItem,
                            child: const Icon(Icons.bookmark_add_outlined,
                                color: ThemeColors.coolgray600),
                          ),
                        if (onShowFullItem != null)
                          InkWell(
                            onTap: onShowFullItem,
                            child: HeroIcon(HeroIcons.arrowTopRightOnSquare,
                                size: 56.h, color: ThemeColors.coolgray600),
                          ),
                        if (onEditItem != null)
                          InkWell(
                            onTap: onEditItem,
                            child: HeroIcon(HeroIcons.pencilSquare,
                                size: 56.h, color: ThemeColors.coolgray600),
                          ),
                      ],
                    ),
                  ),
                ])
          ]),
    );
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
