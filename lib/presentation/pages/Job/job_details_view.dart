import 'package:auto_route/auto_route.dart';

import '../../../manager/models/Job/job_dtl_md.dart';
import '../../../manager/models/Job/job_md.dart';
import '../../../manager/navigation/router.gr.dart';
import '../../template/template.dart';
import '../../widgets/buttons/three_row_buttons.dart';
import '../../widgets/caousel_widget.dart';
import '../../widgets/circle_head_widget.dart';

class JobDetailsView extends StatefulWidget {
  final JobModel jobModel;
  final JobDetailModel jobDetailModel;
  final List<HeroIcons>? iconList;
  VoidCallback? onPress1;
  VoidCallback? onPress2;
  VoidCallback? onPress3;
  Widget? bottomBtn;

  JobDetailsView(
      {required this.jobModel,
      required this.jobDetailModel,
      this.iconList,
      this.onPress1,
      this.onPress2,
      this.onPress3,
      this.bottomBtn,
      Key? key})
      : super(key: key);

  @override
  State<JobDetailsView> createState() => _JobDetailsViewState();
}

class _JobDetailsViewState extends State<JobDetailsView> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    String jobWage = widget.jobDetailModel.workCondition.wageAmount.toString();
    String jobWageType = widget.jobDetailModel.workCondition.wageType!;
    String jobDuration = widget.jobDetailModel.workCondition.period!;

    return SizedBox(
      height: MediaQuery.of(context).size.height - 120,
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 52.w),
            child: SpacedColumn(
                verticalSpace: 22,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedText(
                      text: widget.jobDetailModel.createdAt, //"12.08.12",
                      textStyle: ThemeTextRegular.k14
                          .copyWith(color: ThemeColors.coolgray500)),
                  SizedText(
                      text: widget.jobModel.title,
                      textStyle: ThemeTextSemiBold.k18,
                      softWrap: true,
                      maxLines: 3),
                  _buildTopJobInfoSec(jobWage, jobWageType, jobDuration),
                  PrsmCarouselWidget(
                    imageList: const [
                      "assets/images/png/apple_store_1.png",
                      "assets/images/png/image_ex1.jpg",
                      "assets/images/png/image_ex2.jpg",
                      "assets/images/png/image_ex3.jpg",
                      "assets/images/png/image_ex4.jpg"
                    ],
                  ),
                  _buildCompanyTitleSec(
                      companyLogo: "assets/images/png/nft.jpg",
                      companyName: widget.jobModel.companyName,
                      isDark: isDark),
                  _buildJobDescSec(
                      jobDescription: widget.jobDetailModel.description,
                      isDark: isDark),
                  _buildJobOtherInfoSec(isDark),
                  _buildMoreInfoSec(isDark),
                  _buildBottomButtons(context),
                  SizedBox(height: 20.h)
                ])),
      ),
    );
  }

  Widget _buildTopJobInfoSec(
      String jobWage, String jobWageType, String jobDuration) {
    return SpacedColumn(verticalSpace: 5, children: [
      const Divider(color: ThemeColors.coolgray400, thickness: 1),
      SpacedRow(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CircleHeadWidget(
            title: S(context).wages,
            detailText: "${jobWage}TK/${jobWageType.replaceAll("ly", "")}"),
        CircleHeadWidget(title: S(context).duration, detailText: jobDuration),
        CircleHeadWidget(icon: HeroIcons.clock, detailText: "Dhaka"),
        CircleHeadWidget(icon: HeroIcons.calendar, detailText: "10:00-05:00"),
      ]),
      const Divider(color: ThemeColors.coolgray400, thickness: 1),
    ]);
  }

  Widget _buildCompanyTitleSec(
      {required String companyName,
      required String companyLogo,
      required bool isDark}) {
    return Padding(
        padding: EdgeInsets.all(8.w),
        child: Container(
            height: 155.h,
            decoration: BoxDecoration(
                color: isDark
                    ? MehonotColorsDark.formContainerBgColor
                    : ThemeColors.white,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: ThemeShadows.shadowSm),
            alignment: Alignment.center,
            child: SpacedRow(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                horizontalSpace: 40,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),
                      child: Image.asset(companyLogo,
                          fit: BoxFit.fill, width: 120.w, height: 120.h)),
                  SizedText(text: companyName, textStyle: ThemeTextBold.k18)
                ])));
  }

  Widget _buildJobDescSec(
      {required String? jobDescription, required bool isDark}) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 44.h),
        decoration: BoxDecoration(
            color: isDark
                ? MehonotColorsDark.formContainerBgColor
                : ThemeColors.white,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: ThemeShadows.shadowSm),
        child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalSpace: 34,
            children: [
              SizedText(
                  text: S(context).jobDescription,
                  textStyle: ThemeTextBold.k18),
              SizedText(
                  text: jobDescription ?? context.intl.thereIsNoJobDescription,
                  textStyle: ThemeTextRegular.k14,
                  softWrap: true)
            ]));
  }

  Widget _buildJobOtherInfoSec(isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
      decoration: BoxDecoration(
          color:
              isDark ? MehonotColorsDark.formContainerBgColor : ThemeColors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: ThemeShadows.shadowSm),
      child: SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalSpace: 5,
          children: [
            jobRecruitCond(),
            const Divider(),
            jobWorkCond(),
            const Divider(),
            jobAddressCond(),
          ]),
    );
  }

  Widget _buildMoreInfoSec(isDark) {
    return Container(
      width: double.infinity,
      height: widget.jobDetailModel.moreDetails == null ||
              widget.jobDetailModel.moreDetails!.length < 100
          ? 280.h
          : 440,
      padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 42.h),
      decoration: BoxDecoration(
          color:
              isDark ? MehonotColorsDark.formContainerBgColor : ThemeColors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: ThemeShadows.shadowSm),
      child: SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalSpace: 44,
          children: [
            SizedText(text: S(context).moreInfo, textStyle: ThemeTextBold.k18),
            SizedText(
              // textAlign: widget.jobDetailModel.moreDetails == null
              //     ? TextAlign.center
              //     : TextAlign.start,
              text: widget.jobDetailModel.moreDetails ?? "-",
              softWrap: true,
            )
          ]),
    );
  }

  //logger("Send Message to this owner of this job : ${widget.jobModel.companyName}");

  Widget _buildBottomButtons(BuildContext context) {
    return SpacedColumn(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          if (widget.iconList != null)
            PrsmThreeRowButtons(
              iconList: widget.iconList!,
              onTap1: widget.onPress1 ?? () {},
              onTap2: widget.onPress2 ?? () {},
              onTap3: widget.onPress3 ?? () {},
            ),
          if (widget.iconList == null && widget.bottomBtn != null)
            Align(alignment: Alignment.center, child: widget.bottomBtn!),
          SizedBox(height: 20.h)
        ]);
  }

  Widget jobRecruitCond() {
    return SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalSpace: 10,
        children: [
          SizedText(
              text: S(context).recruitCondition, textStyle: ThemeTextBold.k18),
          SizedBox(height: 20.h),
          infoHelper(
              title: S(context).education,
              desc: widget.jobDetailModel.recruitCondition.education!),
          infoHelper(
              title: S(context).personnel,
              desc: widget.jobDetailModel.recruitCondition.personnel!),
          infoHelper(
              title: S(context).deadline,
              desc: convertTimeStampToDate(convertStringToTimeStamp(
                  widget.jobDetailModel.recruitCondition.deadline))),
          infoHelper(
              title: S(context).gender,
              desc: widget.jobDetailModel.recruitCondition.gender!.isEmpty
                  ? "Male"
                  : "-"),
          infoHelper(
              title: S(context).age,
              desc: widget.jobDetailModel.recruitCondition.age == 0
                  ? "Any"
                  : widget.jobDetailModel.recruitCondition.age.toString()),
        ]);
  }

  Widget jobWorkCond() {
    return SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalSpace: 10,
        children: [
          SizedText(text: "Work Condition", textStyle: ThemeTextBold.k18),
          SizedBox(height: 20.h),
          infoHelper(
              title: S(context).workDays,
              desc:
                  "${widget.jobDetailModel.workCondition.workStartDay}-${widget.jobDetailModel.workCondition.workFinishDay}"),
          infoHelper(
              title: S(context).wages,
              desc: "${widget.jobDetailModel.workCondition.wageAmount} BDT"),
          infoHelper(
              title: S(context).period,
              desc: widget.jobDetailModel.workCondition.period!),
          infoHelper(title: S(context).type, desc: widget.jobModel.type),
        ]);
  }

  Widget jobAddressCond() {
    return SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalSpace: 10,
        children: [
          SizedText(text: S(context).address, textStyle: ThemeTextBold.k18),
          SizedBox(height: 20.h),
          infoHelper(
              title: S(context).division,
              desc: widget.jobModel.address.division),
          infoHelper(
              title: S(context).district,
              desc: widget.jobModel.address.district!.isEmpty
                  ? "-"
                  : widget.jobModel.address.district!),
          infoHelper(
              title: S(context).location,
              desc: widget.jobModel.address.area!.isEmpty
                  ? "-"
                  : widget.jobModel.address.area!),
        ]);
  }

  Widget infoHelper({required String title, required String desc}) {
    return SpacedRow(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedText(
          text: title,
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.fade,
          width: 280.w),
      SpacedRow(horizontalSpace: 40, children: [
        SizedText(text: ":"),
        SizedText(
            text: desc,
            maxLines: 3,
            softWrap: true,
            width: 340.w,
            textStyle: ThemeTextSemiBold.k14)
      ])
    ]);
  }
}
