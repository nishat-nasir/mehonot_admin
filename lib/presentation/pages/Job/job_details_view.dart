import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../manager/models/Job/job_dtl_md.dart';
import '../../../manager/models/Job/job_md.dart';
import '../../../manager/navigation/router.gr.dart';
import '../../template/template.dart';
import '../../utils/common/helper_function.dart';
import '../../widgets/buttons/three_row_buttons.dart';
import '../../widgets/circle_head_widget.dart';
import '../../widgets/photo_widgets/carousel_widget.dart';
import '../../widgets/photo_widgets/company_logo_loader.dart';
import '../../widgets/containers/job_status.dart';
import '../../utils/common/helper_function.dart';

class JobDetailsView extends StatefulWidget {
  final JobModel jobModel;
  final JobDetailModel jobDetailModel;
  final List<HeroIcons>? iconList;
  VoidCallback? onPress1;
  VoidCallback? onPress2;
  VoidCallback? onPress3;
  Widget? bottomBtn;
  VoidCallback? onTapCross;
  bool? showXMark;
  bool? showStatus;
  VoidCallback? onTapApplicationList;

  JobDetailsView(
      {required this.jobModel,
      required this.jobDetailModel,
      this.iconList,
      this.onPress1,
      this.onPress2,
      this.onPress3,
      this.bottomBtn,
      this.onTapCross,
      this.showXMark,
      this.showStatus,
      this.onTapApplicationList,
      Key? key})
      : super(key: key);

  @override
  State<JobDetailsView> createState() => _JobDetailsViewState();
}

class _JobDetailsViewState extends State<JobDetailsView> {
  List<String> jobCategories = [];

  QuillController quillText = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    String jobWage = widget.jobModel.wageAmount.toString();
    String jobWageType = widget.jobDetailModel.workCondition.wageType!;
    String jobDuration = widget.jobDetailModel.workCondition.period!;
    String jobLocation = widget.jobModel.address.division;
    setState(() {
      jobCategories =
          widget.jobModel.category.isNotEmpty ? widget.jobModel.category : [];
    });
    if (widget.jobDetailModel.moreDetails != null &&
        widget.jobDetailModel.moreDetails!.isNotEmpty) {
      convertJsonToQuillController(widget.jobDetailModel.moreDetails!);
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height - 120,
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 52.w),
            child: SpacedColumn(
                verticalSpace: 22,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  SpacedColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SpacedRow(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.showStatus == true)
                                JobStatusChip(jobStatus: widget.jobModel.status)
                              else
                                const SizedBox(),
                              if (widget.showXMark ?? false)
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: widget.onTapCross ??
                                          () {
                                            context.router.popTop();
                                          },
                                      child: HeroIcon(HeroIcons.xMark,
                                          size: 100.h),
                                    )),
                            ]),
                        SizedText(
                            text: calculateDuration(
                                widget.jobModel.timestamp, context),
                            textStyle: ThemeTextRegular.k10
                                .copyWith(color: ThemeColors.coolgray500)),
                        SizedText(
                            text: widget.jobModel.title,
                            textStyle: ThemeTextSemiBold.k18,
                            softWrap: true,
                            maxLines: 3),
                      ]),
                  _buildTopJobInfoSec(
                      jobWage, jobWageType, jobDuration, jobLocation),
                  if (widget.jobDetailModel.images.isNotEmpty)
                    PrsmCarouselImageWidget(
                      showFromNetwork: true,
                      imageList: widget.jobDetailModel.images,
                      // imageList: widget.jobModel.images ??
                      //     ["assets/images/png/apple_store_1.png"],
                    ),
                  _buildCompanyTitleSec(
                      companyLogo: widget.jobModel.companyLogo ?? "",
                      companyName: widget.jobModel.companyName,
                      isDark: isDark),
                  _buildJobDescSec(
                      jobDescription: widget.jobDetailModel.description,
                      isDark: isDark),
                  _buildJobOtherInfoSec(isDark),
                  if (widget.jobDetailModel.website != null &&
                      widget.jobDetailModel.website != "")
                    _buildMoreInfoSec(),
                  SizedBox(height: 40.h),
                  // if (widget.jobDetailModel.moreDetails != null &&
                  //     widget.jobDetailModel.moreDetails != "" &&
                  //     widget.jobDetailModel.moreDetails!.isNotEmpty)
                  //   const Divider(),
                  if (widget.jobDetailModel.moreDetails != null &&
                      widget.jobDetailModel.moreDetails != "" &&
                      widget.jobDetailModel.moreDetails!.isNotEmpty)
                    SizedText(
                      text: "${S(context).moreInfo} :",
                      textStyle: ThemeTextSemiBold.k18,
                    ),
                  if (widget.jobDetailModel.moreDetails != null &&
                      widget.jobDetailModel.moreDetails != "" &&
                      widget.jobDetailModel.moreDetails!.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: QuillEditor(
                        controller: quillText,
                        readOnly: true,
                        focusNode: FocusNode(),
                        scrollController: ScrollController(),
                        scrollable: true,
                        padding: EdgeInsets.zero,
                        autoFocus: false,
                        expands: false,
                        showCursor: false,
                      ),
                    ),
                  Container(
                      height: 1.h,
                      color: isDark
                          ? ThemeColors.coolgray400
                          : ThemeColors.coolgray500),
                  if (widget.jobModel.category.isNotEmpty) _buildCatInfoSec(),
                  _buildBottomButtons(context),
                  SizedBox(height: 60.h)
                ])),
      ),
    );
  }

  Widget _buildTopJobInfoSec(String jobWage, String jobWageType,
      String jobDuration, String jobLocation) {
    return SpacedColumn(verticalSpace: 5, children: [
      const Divider(color: ThemeColors.coolgray400, thickness: 1),
      SpacedRow(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CircleHeadWidget(
            title: S(context).wages,
            detailText: "${jobWage}TK/${jobWageType.replaceAll("ly", "")}"),
        CircleHeadWidget(title: S(context).duration, detailText: jobDuration),
        CircleHeadWidget(
            icon: HeroIcons.mapPin,
            detailText:
                trLocationName(locationName: jobLocation, context: context)),
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
                    ? PrsmColorsDark.formContainerBgColor
                    : ThemeColors.white,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: ThemeShadows.shadowSm),
            alignment: Alignment.center,
            child: SpacedRow(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                horizontalSpace: 40,
                children: [
                  CompanyLogoLoader(companyLogoUrl: companyLogo, size: 120.h),
                  SizedText(
                    textAlign: TextAlign.start,
                    width: 700.w,
                    text: companyName,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textStyle: ThemeTextSemiBold.k14,
                    maxLines: 2,
                  )
                ])));
  }

  Widget _buildJobDescSec(
      {required String? jobDescription, required bool isDark}) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 44.h),
        decoration: BoxDecoration(
            color: isDark
                ? PrsmColorsDark.formContainerBgColor
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
              isDark ? PrsmColorsDark.formContainerBgColor : ThemeColors.white,
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

  Widget _buildMoreInfoSec() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 42.h),
      decoration: BoxDecoration(
          color: isDark(context)
              ? PrsmColorsDark.formContainerBgColor
              : ThemeColors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: ThemeShadows.shadowSm),
      child: SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalSpace: 4,
          children: [
            if (widget.jobDetailModel.website != null &&
                widget.jobDetailModel.website != "")
              const Divider(),
            if (widget.jobDetailModel.website != null &&
                widget.jobDetailModel.website != "")
              SpacedRow(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedText(
                    text: "${S(context).website} :  ",
                    textStyle: ThemeTextMedium.k12,
                  ),
                  InkWell(
                    onTap: () {
                      final Uri toLaunch = Uri(
                        scheme: 'https',
                        host: widget.jobDetailModel.website,
                      );
                      launchInWebViewOrVC(toLaunch);
                    },
                    onLongPress: () {
                      copyWebLink(
                          link: widget.jobDetailModel.website ?? "",
                          context: context);
                    },
                    child: SizedText(
                      text: widget.jobModel.companyName,
                      textStyle: ThemeTextSemiBold.k12.copyWith(
                        color: isDark(context)
                            ? ThemeColors.blue400
                            : ThemeColors.blue700,
                        decoration: TextDecoration.underline,
                        decorationColor: isDark(context)
                            ? ThemeColors.blue400
                            : ThemeColors.blue700,
                      ),
                    ),
                  ),
                ],
              ),
          ]),
    );
  }

  //logger("Send Message to this owner of this job : ${widget.jobModel.companyName}");
  Widget _buildCatInfoSec() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
        decoration: BoxDecoration(
            color: isDark(context)
                ? PrsmColorsDark.formContainerBgColor
                : ThemeColors.white,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: ThemeShadows.shadowSm),
        child: SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalSpace: 20,
          children: [
            SizedText(
                text: S(context).jobCategory, textStyle: ThemeTextMedium.k16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                  jobCategories.length,
                  (index) => Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 4.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: isDark(context)
                                ? PrsmColorsDark.canvasColor
                                : ThemeColors.coolgray300),
                        child: SizedText(
                            text: jobCategories[index].capitalize(),
                            textStyle: ThemeTextRegular.k10),
                      )),
            )
          ],
        ));
  }

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
          deadlineInfoHelper(
              title: S(context).deadline,
              desc: calculateRemainingTime(
                  deadline: widget.jobDetailModel.recruitCondition.deadline,
                  context: context)),
          infoHelper(
              title: S(context).gender,
              desc: widget.jobDetailModel.recruitCondition.gender!.isEmpty
                  ? S(context).male
                  : "-"),
          infoHelper(
              title: S(context).age,
              desc: widget.jobDetailModel.recruitCondition.age.toString()),
        ]);
  }

  Widget jobWorkCond() {
    return SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalSpace: 10,
        children: [
          SizedText(
              text: S(context).workCondition, textStyle: ThemeTextBold.k18),
          SizedBox(height: 20.h),
          infoHelper(
              title: S(context).workDays,
              desc:
                  "${widget.jobDetailModel.workCondition.workStartDay}-${widget.jobDetailModel.workCondition.workFinishDay}"),
          infoHelper(
              title: S(context).wages,
              desc: "${widget.jobModel.wageAmount} BDT"),
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
              desc: trLocationName(
                  locationName: widget.jobModel.address.division,
                  context: context)),
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
        const SizedText(text: ":"),
        SizedText(
            text: desc,
            maxLines: 3,
            softWrap: true,
            width: 340.w,
            textStyle: ThemeTextSemiBold.k14)
      ])
    ]);
  }

  Widget deadlineInfoHelper({required String title, required String desc}) {
    int remainingDays = calculateRemainingTimeInDays(
        widget.jobDetailModel.recruitCondition.deadline);

    Color textColor() {
      if (remainingDays == 0) {
        return ThemeColors.red500;
      } else if (remainingDays < 7 && remainingDays > 0) {
        return ThemeColors.red500;
      } else if (remainingDays < 30 && remainingDays > 7) {
        return ThemeColors.amber600;
      } else if (remainingDays > 30) {
        return ThemeColors.emerald500;
      }
      return ThemeColors.black;
    }

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
            textStyle: ThemeTextSemiBold.k14.copyWith(color: textColor()))
      ])
    ]);
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void convertJsonToQuillController(String jsonText) {
    String jsonString = jsonText;
    List<dynamic> jsonList = json.decode(jsonString);
    Delta delta = Delta.fromJson(jsonList);
    Document document = Document.fromJson(delta.toJson());
    setState(() {
      quillText = QuillController(
        document: document,
        selection: const TextSelection.collapsed(offset: 0),
      );
    });
  }
}
