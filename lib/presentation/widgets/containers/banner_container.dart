import '../../template/template.dart';class BannerContainer extends StatelessWidget {  final VoidCallback? onReqAccept;  final VoidCallback? onReqDecline;  final VoidCallback? onTap;  final VoidCallback? onEdit;  const BannerContainer({    Key? key,    this.onReqDecline,    this.onReqAccept,    this.onTap,    this.onEdit,  }) : super(key: key);  @override  Widget build(BuildContext context) {    return Container(        padding: EdgeInsets.all(24.w),        decoration: BoxDecoration(            color: ThemeColors.white,            borderRadius: BorderRadius.circular(12.r),            border: Border.all(color: ThemeColors.gray100, width: 1.w)),        child: SpacedColumn(          children: [            Padding(                padding: EdgeInsets.only(                    bottom: 10.h, top: 10.h, right: 20.w, left: 20.w),                child: SpacedRow(                  mainAxisAlignment: MainAxisAlignment.spaceBetween,                  crossAxisAlignment: CrossAxisAlignment.center,                  children: [                    SizedText(text: "Mehnat", textStyle: ThemeTextSemiBold.k10),                    SpacedRow(                      horizontalSpace: 30.w,                      children: [                        if (onReqDecline != null)                          InkWell(                              onTap: onReqDecline,                              child: Container(                                  decoration: BoxDecoration(                                      color: ThemeColors.red500,                                      borderRadius: BorderRadius.circular(8.r)),                                  padding: EdgeInsets.all(5.w),                                  child: HeroIcon(                                    HeroIcons.xMark,                                    size: 40.h,                                    color: ThemeColors.white,                                  ))),                        if (onReqDecline != null)                          InkWell(                              onTap: onReqAccept,                              child: Container(                                  decoration: BoxDecoration(                                      color: ThemeColors.green500,                                      borderRadius: BorderRadius.circular(8.r)),                                  padding: EdgeInsets.all(5.w),                                  child: HeroIcon(HeroIcons.check,                                      size: 40.h, color: ThemeColors.white))),                        if (onEdit != null)                          InkWell(                              onTap: onEdit,                              child: Container(                                  decoration: BoxDecoration(                                      color: ThemeColors.blue500,                                      borderRadius: BorderRadius.circular(8.r)),                                  padding: EdgeInsets.all(5.w),                                  child: HeroIcon(HeroIcons.pencilSquare,                                      size: 40.h, color: ThemeColors.white))),                      ],                    )                  ],                )),            Padding(                padding: EdgeInsets.all(28.w),                child: const SponsorBannerContainer())          ],        ));  }}