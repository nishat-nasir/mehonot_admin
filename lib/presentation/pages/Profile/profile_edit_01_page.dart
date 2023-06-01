import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mehonot_admin/manager/models/User/user_profile_md.dart';
import 'package:mehonot_admin/presentation/template/template.dart';

import '../../../manager/models/Address/address_md.dart';
import '../../../manager/models/User/user_md.dart';
import '../../../manager/models/resume/education_md.dart';
import '../../../manager/models/resume/experience_md.dart';
import '../../../manager/models/resume/skill_md.dart';
import '../../../manager/redux/states/user_state.dart';
import '../../utils/common/validators.dart';
import '../../utils/constants.dart';
import '../../widgets/appbar/default_appbar.dart';
import '../../widgets/bottomsheet/default_bottomsheet.dart';

@RoutePage()
class ProfileEdit01Page extends StatefulWidget {
  ProfileEdit01Page({Key? key}) : super(key: key);

  @override
  State<ProfileEdit01Page> createState() => _ProfileEdit01PageState();
}

class _ProfileEdit01PageState extends State<ProfileEdit01Page> {
  bool isDark = false;
  late UserModel userData;
  late UserProfileModel userProfileData;
  late Division selectedDivision;

  final TextEditingController firstNameCntr = TextEditingController();
  final TextEditingController lastNameCntr = TextEditingController();
  final TextEditingController emailCntr = TextEditingController();
  final TextEditingController contactNumberCntr = TextEditingController();
  final TextEditingController birthdayCntr = TextEditingController();
  final TextEditingController positionTitleCntr = TextEditingController();
  final TextEditingController bioCntr = TextEditingController();
  final TextEditingController areaCntr = TextEditingController();
  final TextEditingController cityCntr = TextEditingController();
  final TextEditingController districtCntr = TextEditingController();

  final TextEditingController skillCntr = TextEditingController();
  List<SkillModel> userSkillList = [];
  double sliderValue = 0;

  final TextEditingController eduInsNameCntr = TextEditingController();
  final TextEditingController eduFieldOfStudyCntr = TextEditingController();
  final TextEditingController eduDegreeCntr = TextEditingController();
  final TextEditingController eduLocationCntr = TextEditingController();
  final TextEditingController eduStartDateCntr = TextEditingController();
  final TextEditingController eduEndDateCntr = TextEditingController();
  List<EducationModel> userEducationList = [];

  final TextEditingController expCompanyNameCntr = TextEditingController();
  final TextEditingController expPositionTitleCntr = TextEditingController();
  final TextEditingController expLocationCntr = TextEditingController();
  final TextEditingController expStartDateCntr = TextEditingController();
  final TextEditingController expEndDateCntr = TextEditingController();
  final TextEditingController expDescriptionCntr = TextEditingController();
  List<ExperienceModel> userExperienceList = [];

  bool isNoBio = true;

  @override
  void initState() {
    super.initState();
    userData = appStore.state.userState.userData;
    userProfileData = appStore.state.userState.userProfileData;
    selectedDivision = convertStringToDivision(
        appStore.state.userState.userProfileData.address.division);
    userSkillList.addAll(appStore.state.userState.userProfileData.skill ?? []);
    userEducationList
        .addAll(appStore.state.userState.userProfileData.education ?? []);
    userExperienceList
        .addAll(appStore.state.userState.userProfileData.experience ?? []);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setAllValues();
    });
  }

  @override
  void dispose() {
    firstNameCntr.dispose();
    lastNameCntr.dispose();
    emailCntr.dispose();
    contactNumberCntr.dispose();
    birthdayCntr.dispose();
    positionTitleCntr.dispose();
    bioCntr.dispose();
    areaCntr.dispose();
    cityCntr.dispose();
    districtCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDark = Theme.of(context).brightness == Brightness.dark;
    return SpacedColumn(children: [
      Padding(
          padding: EdgeInsets.all(24.w),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 280.h,
            child: SingleChildScrollView(
                child: SpacedColumn(
              verticalSpace: 30,
              children: [
                _buildEditProfileSec(),
                _buildBioSec(),
                _buildEditSkillSec(context),
                _buildEditEduSec(context),
                _buildEditExpSec(context),
                const SizedBox()
              ],
            )),
          ))
    ]);
  }

  Widget _buildEditProfileSec() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
        decoration: BoxDecoration(
          color: isDark ? MehonotColorsDark.canvasColor : ThemeColors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: SpacedColumn(verticalSpace: 10, children: [
          editProfileItem(
              title: S(context).firstName,
              value: firstNameCntr.text,
              icon: HeroIcons.userCircle,
              onTap: () {
                generalModal(
                    title: S(context).firstName,
                    controller: firstNameCntr,
                    onSave: () {
                      setValue(firstNameCntr);
                    });
              }),
          editProfileItem(
              title: S(context).lastName,
              value: lastNameCntr.text,
              icon: HeroIcons.userCircle,
              onTap: () {
                generalModal(
                    title: S(context).lastName,
                    controller: lastNameCntr,
                    onSave: () {
                      setValue(lastNameCntr);
                    });
              }),
          editProfileItem(
              title: S(context).position,
              value: positionTitleCntr.text,
              icon: HeroIcons.checkBadge,
              onTap: () {
                generalModal(
                    title: S(context).position,
                    controller: positionTitleCntr,
                    onSave: () {
                      setValue(positionTitleCntr);
                    });
              }),
          editProfileItem(
              title: S(context).location,
              value: "${districtCntr.text} ${cityCntr.text} ${areaCntr.text}",
              icon: HeroIcons.mapPin,
              onTap: () {
                DefaultBottomSheet.show(
                    context: context,
                    title: S(context).location,
                    child: SpacedColumn(
                        verticalSpace: 10,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedText(
                              text: S(context).district,
                              textStyle: ThemeTextRegular.k10),
                          PrsmInputField(controller: districtCntr),
                          SizedText(
                              text: S(context).city,
                              textStyle: ThemeTextRegular.k10),
                          PrsmInputField(controller: cityCntr),
                          SizedText(
                              text: S(context).area,
                              textStyle: ThemeTextRegular.k10),
                          PrsmInputField(controller: areaCntr),
                        ]),
                    onSave: () {
                      setValue(districtCntr);
                      setValue(cityCntr);
                      setValue(areaCntr);
                    });
              }),
          editProfileItem(
              title: S(context).birth,
              value: birthdayCntr.text,
              icon: HeroIcons.calendar,
              onTap: () {
                showCalendarModal(controller: birthdayCntr);
              }),
          editProfileItem(
              title: S(context).phone,
              value: contactNumberCntr.text,
              icon: HeroIcons.phoneArrowUpRight,
              isLast: true,
              onTap: () {
                generalModal(
                    title: S(context).phone,
                    controller: contactNumberCntr,
                    formatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    validator: Validator(context).validatePhone,
                    onSave: () {
                      setValue(contactNumberCntr);
                    });
              }),
        ]));
  }

  Widget _buildBioSec() {
    return Container(
      padding: EdgeInsets.all(30.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? MehonotColorsDark.canvasColor : ThemeColors.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedText(text: S(context).bio, textStyle: ThemeTextSemiBold.k18),
          Divider(height: 1.h),
          SizedBox(height: 20.h),
          if (isNoBio)
            Align(
                alignment: Alignment.center,
                child: PrsmSecondaryButton(
                    onTap: () {
                      setState(() {
                        isNoBio = false;
                      });
                    },
                    text: '',
                    icon: HeroIcons.plus))
          else
            PrsmInputField(
              controller: bioCntr,
              maxLines: 5,
              hintText: S(context).bio,
            ),
        ],
      ),
    );
  }

  Widget _buildEditSkillSec(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(30.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? MehonotColorsDark.canvasColor : ThemeColors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedText(
                  text: S(context).skills, textStyle: ThemeTextSemiBold.k18),
              Divider(height: 1.h),
              SizedBox(height: 20.h),
              _buildChipSec(),
              SizedBox(height: 30.h),
              if (userSkillList.length <= 10)
                Align(
                    alignment: Alignment.center,
                    child: PrsmSecondaryButton(
                        onTap: () {
                          addSkillBottomSheet(context);
                        },
                        text: '',
                        icon: HeroIcons.plus))
            ]));
  }

  Widget _buildEditEduSec(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(30.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? MehonotColorsDark.canvasColor : ThemeColors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: SizedText(
                      text: S(context).education,
                      textAlign: TextAlign.start,
                      textStyle: ThemeTextSemiBold.k18)),
              Divider(height: 1.h),
              _buildEduSec(),
              SizedBox(height: 30.h),
              if (userEducationList.length < 3)
                PrsmSecondaryButton(
                    onTap: () {
                      addEducationBottomSheet(context);
                    },
                    text: '',
                    icon: HeroIcons.plus)
            ]));
  }

  Widget _buildEditExpSec(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(30.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? MehonotColorsDark.canvasColor : ThemeColors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: SizedText(
                      text: S(context).experience,
                      textAlign: TextAlign.start,
                      textStyle: ThemeTextSemiBold.k18)),
              Divider(height: 1.h),
              _buildExpSec(),
              SizedBox(height: 30.h),
              if (userExperienceList.length < 3)
                PrsmSecondaryButton(
                    onTap: () {
                      addExperienceBottomSheet(context);
                    },
                    text: '',
                    icon: HeroIcons.plus)
            ]));
  }

  //////////////////////////////////
  //////// Widget helper ///////////
  //////////////////////////////////

  Widget editProfileItem({
    required String title,
    required HeroIcons icon,
    String? value,
    bool isLast = false,
    VoidCallback? onTap,
  }) {
    return SpacedColumn(children: [
      Material(
          color: isDark ? MehonotColorsDark.canvasColor : ThemeColors.white,
          child: InkWell(
              borderRadius: BorderRadius.circular(10.r),
              onTap: onTap,
              child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: SpacedRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      horizontalSpace: 20,
                      children: [
                        SpacedRow(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            horizontalSpace: 10,
                            children: [
                              HeroIcon(icon,
                                  color: ThemeColors.gray500, size: 54.w),
                              SizedText(
                                  text: title, textStyle: ThemeTextSemiBold.k14)
                            ]),
                        SpacedRow(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedText(
                                  text: value ?? "",
                                  textStyle: ThemeTextLight.k12),
                              const Icon(Icons.chevron_right_rounded,
                                  color: ThemeColors.gray500)
                            ])
                      ])))),
      if (!isLast) Divider(height: 1.h)
    ]);
  }

  Widget _buildChipSec() {
    List<SkillModel> userSkills = userSkillList;
    if (userSkills == null || userSkills.isEmpty) {
      return Container();
    }

    return Wrap(spacing: 8.w, children: [
      for (int i = 0; i < userSkills.length; i++)
        ChipItem(
            text: userSkills[i].skillName,
            percentage: userSkills[i].skillLevel,
            onTap: () {},
            onDeleted: () {
              setState(() {
                userSkills.removeAt(i);
              });
            })
    ]);
  }

  Widget _buildEduSec() {
    List<EducationModel>? singleEdu = userEducationList;
    if (singleEdu == null || singleEdu.isEmpty) {
      return Container();
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
            showDivider: singleEdu.length - 1 == i ? false : true,
            onDeleteEduItem: () {
              setState(() {
                singleEdu.removeAt(i);
              });
            },
          ),
      ],
    );
  }

  Widget _buildExpSec() {
    List<ExperienceModel>? singleExp = userExperienceList;
    if (singleExp == null || singleExp.isEmpty) {
      return Container();
    }
    return SpacedColumn(
      verticalSpace: 18,
      children: [
        for (int i = 0; i < singleExp.length; i++)
          ExperienceItem(
            companyName: singleExp[i].companyName,
            location: singleExp[i].location,
            positionName: singleExp[i].positionName,
            description: singleExp[i].description,
            startDate: singleExp[i].startDate,
            endDate: singleExp[i].endDate ?? "present",
            showDivider: singleExp.length - 1 == i ? false : true,
            onDeleteExpItem: () {
              setState(() {
                singleExp.removeAt(i);
              });
            },
          ),
      ],
    );
  }

  ////////////////////////////////////////////////
  ///////////////// MODALS ///////////////////////
  ////////////////////////////////////////////////

  Future generalModal(
      {required String title,
      required TextEditingController controller,
      VoidCallback? onTapTextField,
      List<TextInputFormatter>? formatter,
      String? Function(String?)? validator,
      required VoidCallback onSave}) async {
    return DefaultBottomSheet.show(
      context: context,
      heightFactor: 0.4,
      title: "$title : ",
      onSave: onSave,
      child: PrsmInputField(
        controller: controller,
        onTap: onTapTextField,
        formatter: formatter,
        validator: validator,
      ),
    );
  }

  addSkillBottomSheet(BuildContext context) {
    DefaultBottomSheet.show(
        context: context,
        title: S(context).addSkills,
        child: SpacedColumn(
            verticalSpace: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrsmInputField(
                  controller: skillCntr,
                  formatter: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                    LengthLimitingTextInputFormatter(10)
                  ],
                  hintText: S(context).skills),
              StatefulBuilder(builder: (BuildContext ctx, StateSetter stState) {
                return SpacedColumn(children: [
                  Slider(
                    value: sliderValue,
                    label: sliderValue.round().toString(),
                    max: 100,
                    min: 0,
                    activeColor: ThemeColors.indigo600,
                    inactiveColor: ThemeColors.indigo200,
                    divisions: 10,
                    onChanged: (double value) {
                      stState(() {
                        sliderValue = value;
                      });
                    },
                  ),
                  PrsmSecondaryButton(
                    onTap: () {
                      if (skillCntr.text.isEmpty) return;
                      setState(() {
                        userSkillList.add(SkillModel(
                            skillName: skillCntr.text,
                            skillLevel: sliderValue));
                        sliderValue = 0;
                        skillCntr.clear();
                      });
                      Navigator.pop(ctx);
                    },
                    text: S(context).save,
                  )
                ]);
              })
            ]));
  }

  addEducationBottomSheet(BuildContext context) async {
    double widthForDualTextField =
        (MediaQuery.of(context).size.width / 2) - 60.w;

    DefaultBottomSheet.show(
        context: context,
        heightFactor: 0.8,
        title: "${S(context).education} : ",
        child:
            StatefulBuilder(builder: (BuildContext ctx, StateSetter stState) {
          return SpacedColumn(verticalSpace: 20, children: [
            PrsmInputField(
                hintText: S(context).instituteName, controller: eduInsNameCntr),
            PrsmInputField(
                hintText: S(context).fieldOfStudy,
                controller: eduFieldOfStudyCntr),
            SpacedRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: widthForDualTextField,
                      child: PrsmInputField(
                          hintText: S(context).degree,
                          controller: eduDegreeCntr)),
                  SizedBox(
                      width: widthForDualTextField,
                      child: PrsmInputField(
                          hintText: S(context).location,
                          controller: eduLocationCntr)),
                ]),
            SpacedRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: widthForDualTextField,
                      child: PrsmInputField(
                          hintText: S(context).startDate,
                          controller: eduStartDateCntr,
                          leftIcon: HeroIcons.calendar,
                          disableAll: true,
                          onTap: () {
                            showCalendarModal(controller: eduStartDateCntr);
                          })),
                  SizedBox(
                      width: widthForDualTextField,
                      child: PrsmInputField(
                          hintText: S(context).endDate,
                          leftIcon: HeroIcons.calendar,
                          controller: eduEndDateCntr,
                          disableAll: true,
                          onTap: () {
                            showCalendarModal(controller: eduEndDateCntr);
                          })),
                ]),
            SizedBox(height: 20.h),
            PrsmSecondaryButton(
                width: MediaQuery.of(context).size.width / 2,
                onTap: () {
                  if (eduInsNameCntr.text.isNotEmpty &&
                      eduFieldOfStudyCntr.text.isNotEmpty &&
                      eduDegreeCntr.text.isNotEmpty &&
                      eduLocationCntr.text.isNotEmpty &&
                      eduStartDateCntr.text.isNotEmpty) {
                    setState(() {
                      userEducationList.add(EducationModel(
                          instituteName: eduInsNameCntr.text,
                          subjectName: eduFieldOfStudyCntr.text,
                          degreeName: eduDegreeCntr.text,
                          location: eduLocationCntr.text,
                          startDate: eduStartDateCntr.text,
                          endDate: eduEndDateCntr.text));
                      eduInsNameCntr.clear();
                      eduFieldOfStudyCntr.clear();
                      eduDegreeCntr.clear();
                      eduLocationCntr.clear();
                      eduStartDateCntr.clear();
                      eduEndDateCntr.clear();
                    });
                    Navigator.pop(ctx);
                  }
                },
                text: S(context).save),
          ]);
        }));
  }

  addExperienceBottomSheet(BuildContext context) async {
    double widthForDualTextField =
        (MediaQuery.of(context).size.width / 2) - 60.w;

    return DefaultBottomSheet.show(
        context: context,
        heightFactor: 0.8,
        title: "${S(context).experience} : ",
        child:
            StatefulBuilder(builder: (BuildContext ctx, StateSetter stState) {
          return SpacedColumn(verticalSpace: 20, children: [
            PrsmInputField(
                controller: expCompanyNameCntr,
                hintText: S(context).companyName),
            SpacedRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: widthForDualTextField,
                      child: PrsmInputField(
                          controller: expPositionTitleCntr,
                          hintText: S(context).positionName)),
                  SizedBox(
                      width: widthForDualTextField,
                      child: PrsmInputField(
                          controller: expLocationCntr,
                          hintText: S(context).location)),
                ]),
            SpacedRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: widthForDualTextField,
                      child: PrsmInputField(
                          controller: expStartDateCntr,
                          disableAll: true,
                          onTap: () {
                            showCalendarModal(controller: expStartDateCntr);
                          },
                          hintText: S(context).startDate)),
                  SizedBox(
                      width: widthForDualTextField,
                      child: PrsmInputField(
                          controller: expEndDateCntr,
                          disableAll: true,
                          onTap: () {
                            showCalendarModal(controller: expEndDateCntr);
                          },
                          hintText: S(context).endDate)),
                ]),
            PrsmInputField(
                controller: expDescriptionCntr,
                hintText:
                    "${S(context).details} (${S(context).responsibilities}, ${S(context).etc}.)",
                maxLines: 9),
            SizedBox(height: 20.h),
            PrsmSecondaryButton(
                width: MediaQuery.of(context).size.width / 2,
                text: S(context).save,
                onTap: () {
                  if (expCompanyNameCntr.text.isNotEmpty &&
                      expPositionTitleCntr.text.isNotEmpty &&
                      expLocationCntr.text.isNotEmpty &&
                      expStartDateCntr.text.isNotEmpty &&
                      expEndDateCntr.text.isNotEmpty &&
                      expDescriptionCntr.text.isNotEmpty) {
                    setState(() {
                      userExperienceList.add(ExperienceModel(
                          companyName: expCompanyNameCntr.text,
                          positionName: expPositionTitleCntr.text,
                          location: expLocationCntr.text,
                          startDate: expStartDateCntr.text,
                          endDate: expEndDateCntr.text,
                          description: expDescriptionCntr.text));
                      expCompanyNameCntr.clear();
                      expPositionTitleCntr.clear();
                      expLocationCntr.clear();
                      expStartDateCntr.clear();
                      expEndDateCntr.clear();
                      expDescriptionCntr.clear();
                    });
                    Navigator.pop(ctx);
                  }
                }),
          ]);
        }));
  }

  /////////////////////////////////////////
  /////////////// Functions ///////////////
  /////////////////////////////////////////
  void setAllValues() {
    setState(() {
      firstNameCntr.text = userProfileData.firstName;
      lastNameCntr.text = userProfileData.lastName ?? "";
      emailCntr.text = userProfileData.email;
      contactNumberCntr.text = userProfileData.contactNumber == ""
          ? userData.phoneNumber
          : userProfileData.contactNumber;
      birthdayCntr.text = userProfileData.birthday;
      positionTitleCntr.text = userProfileData.positionTitle;
      bioCntr.text = userProfileData.bio;
      areaCntr.text = userProfileData.address.area ?? "";
      cityCntr.text = userProfileData.address.city ?? "";
      districtCntr.text = userProfileData.address.district ?? "";
      isNoBio = bioCntr.text.isEmpty;
    });
  }

  setValue(TextEditingController controller) {
    setState(() {
      controller.text = controller.text;
    });
    context.popRoute();
  }

  Future showCalendarModal({required TextEditingController controller}) {
    return showDatePicker(
            builder: (BuildContext context, Widget? child) {
              return SizedBox(
                  width: 200.w,
                  height: 200.h,
                  child: Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                        onPrimary: ThemeColors.white,
                        surface: ThemeColors.white,
                        onSurface: ThemeColors.black,
                      ),
                      dialogBackgroundColor: ThemeColors.white,
                    ),
                    child: child!,
                  ));
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        setState(() {
          controller.text = DateFormat('dd MMMM yyyy').format(value);
        });
      }
    });
  }

  void saveProfile() async {
    UserProfileModel profileToUpdate = UserProfileModel(
      userProfileId: userProfileData.userProfileId,
      userId: userProfileData.userId,
      firstName: firstNameCntr.text,
      lastName: lastNameCntr.text,
      email: emailCntr.text,
      contactNumber: contactNumberCntr.text,
      birthday: birthdayCntr.text,
      positionTitle: positionTitleCntr.text,
      bio: bioCntr.text,
      profileImage: "",
      address: AddressModel(
          division: selectedDivision.name,
          area: areaCntr.text,
          city: cityCntr.text,
          district: districtCntr.text),
      createdDate: userProfileData.createdDate,
      education: userEducationList,
      experience: userExperienceList,
      isVerifiedExplorer: userProfileData.isVerifiedExplorer,
      isVerifiedOwner: userProfileData.isVerifiedOwner,
      skill: userSkillList,
      userJobRelationId: userProfileData.userJobRelationId,
    );

    bool success = await appStore
        .dispatch(GetUpdateProfileAction(userProfileData: profileToUpdate));
    if (success) {
      appStore
          .dispatch(UpdateUserStateAction(userProfileData: profileToUpdate));
      if (!mounted) return;
      context.navigateBack();
      showDialog(
          context: context, builder: (context) => SizedText(text: "success!!"));
    } else {
      if (!mounted) return;
      showDialog(
          context: context, builder: (context) => SizedText(text: "fail!!"));
    }
  }
}
