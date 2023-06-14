import 'package:auto_route/auto_route.dart';
import 'package:flutter/rendering.dart';
import 'package:mehonot_admin/manager/models/resume/education_md.dart';
import 'package:mehonot_admin/manager/models/resume/experience_md.dart';
import 'package:mehonot_admin/presentation/template/template.dart';
import 'package:mehonot_admin/presentation/utils/constants.dart';

import '../../../manager/models/User/user_md.dart';
import '../../../manager/models/User/user_profile_md.dart';
import '../../../manager/models/resume/skill_md.dart';

@RoutePage()
class Profile01Page extends StatefulWidget {
  Profile01Page({Key? key}) : super(key: key);

  @override
  State<Profile01Page> createState() => _Profile01PageState();
}

class _Profile01PageState extends State<Profile01Page> {
  bool isDark = false;

  late UserModel userData;
  late UserProfileModel userProfileData;

  final ScrollController _eduScrollController = ScrollController();
  final ScrollController _expScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _eduScrollController.dispose();
    _expScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    setState(() {
      userData = appStore.state.userState.userData;
      userProfileData = appStore.state.userState.userProfileData;
    });
    return Padding(
        padding: EdgeInsets.all(30.w),
        child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width - 60.w,
            child: SingleChildScrollView(
                child: SpacedColumn(verticalSpace: 30, children: [
                  _buildProfileCardSec(),
                  _buildSkillsSec(),
                  _buildEduSec(),
                  _buildExpSec(),
                ]))));
  }

  Widget _buildProfileCardSec() {
    return Container(
        decoration: BoxDecoration(
          color: isDark ? PrsmColorsDark.canvasColor : ThemeColors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 60.w),
        child: SpacedColumn(verticalSpace: 52.h, children: [
          profileHeader(),
          SizedBox(height: 20.h),
          SizedText(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 60.w,
              height: 160.h,
              textAlign: TextAlign.start,
              text: userProfileData.bio.isEmpty
                  ? S(context).noBio
                  : userProfileData.bio,
              softWrap: true,
              textStyle: ThemeTextRegular.k12),
          const SizedBox(),
          profileHeaderInfo()
        ]));
  }

  Widget _buildSkillsSec() {
    return Container(
        padding: EdgeInsets.all(60.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? PrsmColorsDark.canvasColor : ThemeColors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedText(
                  text: S(context).skills, textStyle: ThemeTextSemiBold.k18),
              _buildChipSec()
            ]));
  }

  Widget _buildEduSec() {
    return Container(
        decoration: BoxDecoration(
          color: isDark ? PrsmColorsDark.canvasColor : ThemeColors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        padding: EdgeInsets.all(60.w),
        width: double.infinity,
        child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalSpace: 40,
            children: [
              SizedText(
                  text: S(context).education, textStyle: ThemeTextSemiBold.k18),
              Container(
                  constraints: BoxConstraints(maxHeight: _eduHeightCal()),
                  child: Scrollbar(
                      controller: _eduScrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                          controller: _eduScrollController,
                          child: eduHelper())))
            ]));
  }

  Widget _buildExpSec() {
    return Container(
        decoration: BoxDecoration(
          color: isDark ? PrsmColorsDark.canvasColor : ThemeColors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        padding: EdgeInsets.all(60.w),
        width: double.infinity,
        child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalSpace: 40,
            children: [
              SizedText(
                  text: S(context).experience,
                  textStyle: ThemeTextSemiBold.k18),
              Container(
                  constraints: BoxConstraints(maxHeight: _expHeightCal()),
                  child: Scrollbar(
                      controller: _expScrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                          controller: _expScrollController,
                          child: expHelper())))
            ]));
  }

  Widget profileHeaderInfo() {
    return SpacedRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          profileHeaderInfoItem(
              title: S(context).location,
              value:
              "${userProfileData.address.district} ${userProfileData.address
                  .division}",
              icon: HeroIcons.mapPin),
          profileHeaderInfoItem(
              title: S(context).birth,
              value: userProfileData.birthday ?? "",
              icon: HeroIcons.cake),
          profileHeaderInfoItem(
              title: S(context).phone,
              value: userProfileData.contactNumber == ""
                  ? userData.phoneNumber
                  : userProfileData.contactNumber,
              icon: HeroIcons.phoneArrowUpRight)
        ]);
  }

  Widget profileHeaderInfoItem({
    required String title,
    required String value,
    required HeroIcons icon,
  }) {
    return SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpacedRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              horizontalSpace: 20.w,
              children: [
                HeroIcon(
                  icon,
                  size: 42.h,
                  color: isDark
                      ? ThemeColors.coolgray200
                      : PrsmColorsDark.canvasColor,
                ),
                SizedText(text: title, textStyle: ThemeTextRegular.k10)
              ]),
          SizedText(text: value, textStyle: ThemeTextSemiBold.k10)
        ]);
  }

  Widget profileHeader() {
    return SpacedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SpacedRow(crossAxisAlignment: CrossAxisAlignment.center, children: [
            CircleAvatar(
              backgroundColor: ThemeColors.indigo400,
              child: Icon(Icons.person, size: 32.h),
            ),
            SizedBox(width: 24.w),
            SpacedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedText(
                      text:
                      "${userProfileData.firstName} ${userProfileData
                          .lastName}",
                      textStyle: ThemeTextSemiBold.k14),
                  SizedText(
                      text: userProfileData.positionTitle,
                      textStyle: ThemeTextRegular.k12),
                ])
          ])
        ]);
  }

  Widget _buildChipSec() {
    List<SkillModel>? userSkillList = userProfileData.skill;
    if (userSkillList == null || userSkillList.isEmpty) {
      return SizedText(
          text: S(context).noSkill,
          softWrap: true,
          textStyle: ThemeTextRegular.k12);
    }

    return Wrap(spacing: 10.w, children: [
      for (int i = 0; i < userSkillList.length; i++)
        ChipItem(
          text: userSkillList[i].skillName,
          percentage: userSkillList[i].skillLevel,
        )
    ]);
  }

  Widget eduHelper() {
    List<EducationModel>? singleEdu = userProfileData.education;
    if (singleEdu == null || singleEdu.isEmpty) {
      return SizedText(
          text: S(context).noEducation,
          softWrap: true,
          textStyle: ThemeTextRegular.k12);
    }
    return SpacedColumn(
      verticalSpace: 18,
      children: [
        for (int i = 0; i < singleEdu.length; i++)
          EducationItem(
              subjectName: singleEdu[i].subjectName,
              location: singleEdu[i].location,
              instituteName: singleEdu[i].instituteName,
              startDate: singleEdu[i].startDate,
              endDate: singleEdu[i].endDate ?? "present",
              degreeName: singleEdu[i].degreeName,
              showDivider: singleEdu.length - 1 == i ? false : true),
      ],
    );
  }

  Widget expHelper() {
    List<ExperienceModel>? singleExp = userProfileData.experience;
    if (singleExp == null || singleExp.isEmpty) {
      return SizedText(
          text: S(context).noEducation,
          softWrap: true,
          textStyle: ThemeTextRegular.k12);
    }
    return SpacedColumn(verticalSpace: 18, children: [
      for (int i = 0; i < singleExp.length; i++)
        ExperienceItem(
          companyName: singleExp[i].companyName,
          location: singleExp[i].location,
          positionName: singleExp[i].positionName,
          description: singleExp[i].description,
          showDivider: singleExp.length - 1 == i ? false : true,
          startDate: singleExp[i].startDate,
          endDate: singleExp[i].endDate ?? "present",
        ),
    ]);
  }

  double _expHeightCal() {
    if (userProfileData.experience == null ||
        userProfileData.experience!.isEmpty) {
      return 100.h;
    }
    return userProfileData.experience!.length * 300.h;
  }

  double _eduHeightCal() {
    if (userProfileData.experience == null ||
        userProfileData.experience!.isEmpty) {
      return 100.h;
    }
    return userProfileData.experience!.length * 300.h;
  }
}
