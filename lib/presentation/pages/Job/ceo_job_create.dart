import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../manager/models/Address/address_md.dart';
import '../../../manager/models/Job/ReqModels/job_dtl_md_req.dart';
import '../../../manager/models/Job/ReqModels/job_md_req.dart';
import '../../../manager/models/Job/ReqModels/recruit_con_md_req.dart';
import '../../../manager/models/Job/work_con_md.dart';
import '../../../manager/redux/states/jobs_state.dart';
import '../../template/template.dart';
import '../../utils/common/validators.dart';
import '../../utils/constants.dart';
import '../../widgets/circle_head_widget.dart';
import '../../widgets/modals/calendar_popup.dart';
import '../../widgets/photo_widgets/image_upload.dart';
import 'Popups/job_category_popup.dart';

@RoutePage(name: "CeoJobCreateRouter")
class CeoJobCreatePage extends StatefulWidget {
  const CeoJobCreatePage({Key? key}) : super(key: key);

  @override
  State<CeoJobCreatePage> createState() => _CeoJobCreatePageState();
}

class _CeoJobCreatePageState extends State<CeoJobCreatePage> {
  bool isDark = false;
  final GlobalKey<FormState> createJobFormKey = GlobalKey<FormState>();

  bool isCreateJobLoading = false;

  TextEditingController jobTitleCntr =
      TextEditingController(text: kDebugMode ? "Job Title" : "");
  TextEditingController jobCompanyNameCntr =
      TextEditingController(text: kDebugMode ? "Company Name" : "");
  TextEditingController jobDescriptionCntr = TextEditingController();
  TextEditingController jobEmailCntr =
      TextEditingController(text: kDebugMode ? "test@test.com" : "");
  TextEditingController jobWebsiteCntr = TextEditingController(text: "");
  TextEditingController jobPhoneCntr =
      TextEditingController(text: kDebugMode ? "01700000000" : "");
  TextEditingController jobLocationCntr = TextEditingController();
  TextEditingController jobWagesCntr = TextEditingController(text: "0");
  TextEditingController jobMoreInfoCntr =
      TextEditingController(text: kDebugMode ? "More Info" : "");
  TextEditingController createJobDeadlineCntr = TextEditingController();
  String createJobAddressDistrict = "";
  String createJobAddressCity = "";
  String createJobAddressArea = "";
  List<String> createJobAddressDivisionList = Constants.locationsBd().names();
  String createJobAddressDivisionString = Constants.locationsBd().names().first;
  Division createJobAddressDivisionDivision =
      convertStringToDivision(Constants.locationsBd().names().first);
  String createJobEducation = Constants.jobEducationList.first;
  String createJobPersonnel = Constants.jobPersonnelList.first;
  String createJobGender = "";

  // 3 months
  Timestamp createJobDeadline =
      Timestamp.fromDate(DateTime.now().add(Duration(days: 90)));
  String createJobType = Constants.jobTypeList.first;
  String createJobPaymentType = Constants.jobPaymentTypeList.first;
  String createJobPeriod = Constants.jobPeriodList.first;
  String createJobStartDay = Constants.daysList.first;
  String createJobFinishDay = Constants.daysList.last;
  String createJobAge = Constants.jobAgeList.last;
  DateTime createWorkStartTime = DateTime.now();
  DateTime createWorkFinishTime = DateTime.now();
  String createWorkStartTimeString = "";
  String createWorkFinishTimeString = "";

  bool jobIsCreate = false;
  List<File> imageFileList = [];
  List<String> imageNameList = [];
  List<String> selectedJobCategories = [];

  File? companyLogoFile;
  String? companyLogoName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        createJobDeadlineCntr.text =
            DateFormat("dd MMM yyyy").format(createJobDeadline.toDate());
      });
    });
  }

  @override
  void dispose() {
    onReset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDark = Theme.of(context).brightness == Brightness.dark;

    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Padding(
            padding: EdgeInsets.all(40.w),
            child: SingleChildScrollView(
              child: Form(
                  key: createJobFormKey,
                  child: SpacedColumn(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      verticalSpace: 20,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: SizedText(
                                text: S(context).title,
                                textStyle: ThemeTextSemiBold.k14)),
                        PrsmInputField(
                          controller: jobTitleCntr,
                          maxLines: 5,
                          enableShadow: false,
                          validator: Validator(context).validateField,
                          defaultBorderColor: ThemeColors.coolgray300,
                        ),
                        divider(),
                        _buildCircleHeadForm(context),
                        divider(),
                        PrsmImageUpload(
                          imageNetUrls: [],
                          onImageSelected: (imageFile, image) {
                            logger("Image Selected");
                            logger(imageFile);
                            logger(image);
                            setState(() {
                              imageFileList.clear();
                              imageFileList.addAll(imageFile);
                              logger("Image Selected ${imageFileList.length}");
                              logger("Image Selected ${imageFileList.length}");
                              // imageNameList.add(image);
                            });
                          },
                          onRemoveNetworkImg: (int) {},
                        ),
                        divider(),
                        formHelper(
                            title: S(context).company,
                            widget: SpacedRow(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrsmCompanyLogoUpload(
                                  onImageSelected: (imageFile) {
                                    setState(() {
                                      companyLogoFile = imageFile;
                                    });
                                  },
                                ),
                                SpacedColumn(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 720.w,
                                          child: PrsmInputField(
                                            controller: jobCompanyNameCntr,
                                            enableShadow: false,
                                            validator: Validator(context)
                                                .validateField,
                                            defaultBorderColor:
                                                ThemeColors.coolgray300,
                                          )),
                                      SizedText(
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        text:
                                            "*${S(context).canNotChangeComNameOrLogo}",
                                        textStyle: ThemeTextRegular.k10
                                            .copyWith(
                                                color: ThemeColors.red500),
                                      )
                                    ]),
                              ],
                            )),
                        formHelper(
                            title: S(context).jobDescription,
                            widget: PrsmInputField(
                              controller: jobDescriptionCntr,
                              enableShadow: false,
                              maxLines: 8,
                              defaultBorderColor: ThemeColors.coolgray300,
                            )),
                        divider(),
                        _buildRecruitFormSec(),
                        divider(),
                        _buildAddressFormSec(),
                        divider(),
                        _buildContactFormSec(),
                        divider(),
                        _buildMoreInfoFormSec(),
                        divider(),
                        PrimaryButton(
                            buttonText: S(context).post,
                            buttonSize: ButtonSize.L,
                            onPressed: () async {
                              if (createJobFormKey.currentState!.validate()) {
                                showConfirmJobPostPopup(context, false);
                              } else {
                                logger("Validation Error");
                              }
                            }),
                        SizedBox(height: 60.h)
                      ])),
            ),
          );
        });
  }

  Widget _buildContactFormSec() {
    return SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalSpace: 20,
        children: [
          formHelper(
              title: S(context).email,
              widget: PrsmInputField(
                  controller: jobEmailCntr,
                  validator: Validator(context).validateEmail,
                  defaultBorderColor: ThemeColors.coolgray300,
                  enableShadow: false)),
          formHelper(
              title: S(context).website,
              widget: PrsmInputField(
                  controller: jobWebsiteCntr,
                  validator: Validator(context).validateWebsite,
                  defaultBorderColor: ThemeColors.coolgray300,
                  enableShadow: false)),
          formHelper(
              title: S(context).phone,
              widget: PrsmInputField(
                  controller: jobPhoneCntr,
                  validator: Validator(context).validatePhone,
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  defaultBorderColor: ThemeColors.coolgray300,
                  enableShadow: false)),
        ]);
  }

  Widget _buildAddressFormSec() {
    return SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalSpace: 20,
        children: [
          SizedText(text: S(context).address, textStyle: ThemeTextSemiBold.k18),
          formHelperForDropdowns(
            listValuesLeft: Constants.locationsBd().names(),
            listValuesRight: ["Add cities", ""],
            titleLeft: S(context).division,
            titleRight: S(context).city,
            valueLeft: createJobAddressDivisionString,
            valueRight: "",
            onChangedLeft: (value) => changeDivisionList(value),
            onChangedRight: (value) => changeCityList(value),
          ),
          formHelper(
              title: S(context).location,
              widget: PrsmInputField(
                  controller: jobLocationCntr,
                  defaultBorderColor: ThemeColors.coolgray300,
                  enableShadow: false)),
        ]);
  }

  Widget _buildRecruitFormSec() {
    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalSpace: 20,
      children: [
        SizedText(
            text: S(context).recruitCondition,
            textStyle: ThemeTextSemiBold.k18),
        formHelperForDropdowns(
          listValuesLeft: Constants.jobEducationList,
          listValuesRight: Constants.jobPersonnelList,
          titleLeft: S(context).education,
          titleRight: S(context).personnel,
          valueLeft: createJobEducation,
          valueRight: createJobPersonnel,
          onChangedLeft: (value) => changeEduList(value),
          onChangedRight: (value) => changePersonnelList(value),
        ),
        formHelperForDropdowns(
          listValuesLeft: Constants.jobAgeList,
          listValuesRight: [],
          titleLeft: S(context).age,
          titleRight: S(context).deadline,
          valueLeft: createJobAge,
          valueRight: createJobDeadlineCntr.text,
          onChangedLeft: (value) {},
          onChangedRight: (value) {},
          onTapRight: () {
            showCalendarModal(
                context: context, controller: createJobDeadlineCntr);
            String dateString = createJobDeadlineCntr.text;
            DateTime dateTime = DateFormat('dd MMMM yyyy').parse(dateString);
            int timestamp = dateTime.millisecondsSinceEpoch;
            setState(() {
              createJobDeadline =
                  Timestamp.fromMillisecondsSinceEpoch(timestamp);
            });
          },
        ),
        formHelperForDropdowns(
          listValuesLeft: Constants.jobTypeList,
          listValuesRight: Constants.jobPaymentTypeList,
          titleLeft: S(context).type,
          titleRight: S(context).payment,
          valueLeft: createJobType,
          valueRight: createJobPaymentType,
          onChangedLeft: (value) => changeJobTypeList(value),
          onChangedRight: (value) => changePaymentTypeList(value),
        ),
      ],
    );
  }

  Widget formHelperForDropdowns({
    required ValueChanged onChangedLeft,
    required List listValuesLeft,
    required String titleLeft,
    dynamic valueLeft,
    required ValueChanged onChangedRight,
    required List listValuesRight,
    required String titleRight,
    dynamic valueRight,
    VoidCallback? onTapLeft,
    VoidCallback? onTapRight,
  }) {
    return SizedBox(
      width: double.infinity,
      child: SpacedRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (onTapLeft != null)
              formHelper(
                  title: titleRight,
                  width: (MediaQuery.of(context).size.width / 2) - 50.w,
                  widget: InkWell(
                      onTap: onTapLeft,
                      child: Container(
                          height: 115.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                              color: isDark
                                  ? PrsmColorsDark.formFillColor
                                  : ThemeColors.coolgray200,
                              borderRadius: BorderRadius.circular(18.r)),
                          width:
                              (MediaQuery.of(context).size.width / 2) - 100.w,
                          child: SizedText(
                            width:
                                (MediaQuery.of(context).size.width / 2) - 140.w,
                            text: valueLeft,
                            overflow: TextOverflow.ellipsis,
                            textStyle: ThemeTextRegular.k14.copyWith(
                                color: isDark
                                    ? ThemeColors.white
                                    : ThemeColors.coolgray800),
                          ))))
            else
              formHelper(
                  title: titleLeft,
                  width: (MediaQuery.of(context).size.width / 2) - 50.w,
                  widget: PrsmDropdown(
                      listValues: listValuesLeft,
                      enableShadow: false,
                      enableBorder: true,
                      value: valueLeft,
                      bgColor: isDark
                          ? PrsmColorsDark.formFillColor
                          : ThemeColors.coolgray200,
                      onChanged: onChangedLeft)),
            if (onTapRight != null)
              formHelper(
                  title: titleRight,
                  width: (MediaQuery.of(context).size.width / 2) - 50.w,
                  widget: InkWell(
                      onTap: onTapRight,
                      child: Container(
                          height: 115.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                              color: isDark
                                  ? PrsmColorsDark.formFillColor
                                  : ThemeColors.coolgray200,
                              borderRadius: BorderRadius.circular(18.r)),
                          width:
                              (MediaQuery.of(context).size.width / 2) - 100.w,
                          child: SizedText(
                            width:
                                (MediaQuery.of(context).size.width / 2) - 140.w,
                            text: valueRight,
                            overflow: TextOverflow.ellipsis,
                            textStyle: ThemeTextRegular.k14.copyWith(
                                color: isDark
                                    ? ThemeColors.white
                                    : ThemeColors.coolgray800),
                          ))))
            else
              formHelper(
                  title: titleRight,
                  width: (MediaQuery.of(context).size.width / 2) - 50.w,
                  widget: PrsmDropdown(
                      dropdownSize: DropdownSize.SIZE1,
                      listValues: listValuesRight,
                      enableShadow: false,
                      enableBorder: true,
                      value: valueRight,
                      bgColor: isDark
                          ? PrsmColorsDark.formFillColor
                          : ThemeColors.coolgray200,
                      onChanged: onChangedRight)),
          ]),
    );
  }

  Widget formHelper(
      {required String title, required Widget widget, double? width}) {
    return Container(
        width: width ?? double.infinity,
        padding: EdgeInsets.all(30.w),
        decoration: BoxDecoration(
            color: isDark ? PrsmColorsDark.canvasColor : ThemeColors.white,
            boxShadow: ThemeShadows.shadowSm,
            borderRadius: BorderRadius.circular(12.r)),
        child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalSpace: 16,
            children: [
              SizedText(text: title, textStyle: ThemeTextSemiBold.k14),
              widget
            ]));
  }

  Widget _buildCircleHeadForm(
    BuildContext context,
  ) {
    return SpacedColumn(verticalSpace: 30, children: [
      formTopHelper(
          circleHeadTitle: S(context).wages,
          widget: SizedBox(
              width: (MediaQuery.of(context).size.width - 270.w),
              height: 140.h,
              child: PrsmInputField(
                  controller: jobWagesCntr,
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  defaultBorderColor: ThemeColors.coolgray300,
                  enableShadow: false))),
      formTopHelper(
          circleHeadTitle: S(context).period,
          widget: SizedBox(
              width: (MediaQuery.of(context).size.width - 270.w),
              height: 140.h,
              child: PrsmDropdown(
                  enableBorder: true,
                  onChanged: (value) => changeJobPeriodList(value),
                  listValues: Constants.jobPeriodList,
                  value: createJobPeriod,
                  enableShadow: false))),
      formTopHelper(
          circleHeadIcon: HeroIcons.clock,
          widget: SizedBox(
              width: (MediaQuery.of(context).size.width - 270.w),
              child: SpacedRow(
                  horizontalSpace: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: (MediaQuery.of(context).size.width - 250),
                        height: 140.h,
                        child: PrsmInputField(
                            onTap: () => showTimePickerPopup(context, true),
                            hintText: S(context).startTime,
                            enabled: false,
                            controller: TextEditingController(
                                text: createWorkStartTimeString),
                            defaultBorderColor: ThemeColors.white,
                            enableShadow: false)),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width - 250),
                        height: 140.h,
                        child: PrsmInputField(
                            onTap: () => showTimePickerPopup(context, false),
                            hintText: S(context).endTime,
                            enabled: false,
                            controller: TextEditingController(
                                text: createWorkFinishTimeString),
                            defaultBorderColor: ThemeColors.white,
                            enableShadow: false))
                  ]))),
      formTopHelper(
          circleHeadIcon: HeroIcons.calendar,
          widget: SizedBox(
              width: (MediaQuery.of(context).size.width - 270.w),
              child: SpacedRow(
                  horizontalSpace: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: (MediaQuery.of(context).size.width - 250),
                        height: 140.h,
                        child: PrsmDropdown(
                            enableBorder: true,
                            onChanged: (value) => changeJobStartDayList(value),
                            listValues: Constants.daysList,
                            value: createJobStartDay,
                            enableShadow: false)),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width - 250),
                        height: 140.h,
                        child: PrsmDropdown(
                            enableBorder: true,
                            onChanged: (value) => changeJobFinishDayList(value),
                            listValues: Constants.daysList,
                            value: createJobFinishDay,
                            enableShadow: false))
                  ])))
    ]);
  }

  Widget _buildMoreInfoFormSec() {
    return SpacedColumn(children: [
      formHelper(
          title: S(context).jobCategory,
          widget: SpacedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedJobCategories.isNotEmpty)
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                        selectedJobCategories.length,
                        (index) => Chip(
                              label: Text(selectedJobCategories[index]),
                              onDeleted: () {
                                setState(() {
                                  selectedJobCategories.removeAt(index);
                                });
                              },
                            )),
                  ),
                if (selectedJobCategories.isNotEmpty)
                  const SizedBox(
                    height: 10,
                  ),
                ElevatedButton(
                  child: const Text('Add more Categories'),
                  onPressed: () {
                    openJobCategoriesPopup(
                      context: context,
                      onSaveCat: (value) {
                        setState(() {
                          selectedJobCategories = value;
                        });
                      },
                      selectedJobCategories: selectedJobCategories,
                    );
                  },
                ),
              ])),
      formHelper(
          title: S(context).moreInfo,
          widget: PrsmInputField(
            controller: jobMoreInfoCntr,
            maxLines: 5,
            enableShadow: false,
            validator: Validator(context).validateField,
            defaultBorderColor: ThemeColors.coolgray300,
          ))
    ]);
  }

  Widget formTopHelper(
      {String? circleHeadTitle,
      HeroIcons? circleHeadIcon,
      required Widget widget}) {
    return SpacedRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleHeadWidget(
            circleSize: 160.w,
            iconSize: 80.w,
            title: circleHeadTitle,
            icon: circleHeadIcon),
        widget
      ],
    );
  }

  Widget divider() {
    return const Divider(
      color: ThemeColors.coolgray300,
    );
  }

  showTimePickerPopup(BuildContext context, bool isStartTime) {
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
        hourLabelText: S(context).hour,
        minuteLabelText: S(context).minute,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        }).then((value) {
      if (value != null) {
        DateTime time = convertTimeOfDayToDateTime(value);
        if (isStartTime) {
          createWorkStartTime = time;
          setState(() {
            createWorkStartTimeString = DateFormat('HH:mm').format(time);
          });
        } else {
          createWorkFinishTime = time;
          setState(() {
            createWorkFinishTimeString = DateFormat('HH:mm').format(time);
          });
        }
      }
    });
  }

  Future ceoCreateJob(BuildContext context) async {
    setState(() {
      isCreateJobLoading = true;
    });
    //TODO: Show loading when creating job
    final userProfileData = appStore.state.userState.userProfileData;

    bool success = await appStore.dispatch(GetCreateJobReqAction(
        imageFiles: imageFileList,
        companyLogoImg: companyLogoFile,
        jobModelReq: JobModelReq(
          title: jobTitleCntr.text,
          companyName: jobCompanyNameCntr.text,
          companyLogo: "",
          workStartTime: createWorkStartTimeString,
          workFinishTime: createWorkFinishTimeString,
          postedByUserId: appStore.state.userState.userData.userId,
          address: AddressModel(
            division: createJobAddressDivisionString,
            district: createJobAddressDistrict,
            city: createJobAddressCity,
            area: createJobAddressArea,
          ),
          type: createJobType,
          status: "pending",
          timestamp: Timestamp.now(),
          category: selectedJobCategories,
          tags: [],
          wageAmount: double.parse(jobWagesCntr.text),
        ),
        jobDetailModelReq: JobDetailModelReq(
            phone: jobPhoneCntr.text,
            ownerName:
                "${userProfileData.firstName} ${userProfileData.lastName}",
            website: jobWebsiteCntr.text,
            email: jobEmailCntr.text,
            description: jobDescriptionCntr.text,
            moreDetails: jobMoreInfoCntr.text,
            recruitCondition: RecruitConModelReq(
              education: createJobEducation,
              age: createJobAge,
              deadline: createJobDeadline,
              gender: createJobGender,
              personnel: createJobPersonnel,
            ),
            workCondition: WorkConModel(
              period: createJobPeriod,
              wageType: createJobPaymentType,
              workStartDay: createJobStartDay,
              workFinishDay: createJobFinishDay,
            ),
            images: [],
            createdAt: DateTime.now())));

    if (success) {
      //TODO: Fix pop route issue
      // onReset();
      // wait for 1 second
      // Go to Home page
      isCreateJobLoading = false;
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            jobIsCreate = true;
          });
          if (jobIsCreate) {
            // context.replaceRoute(GeneralWrapperRouter(
            //   children: [Home01Route()],
            // ));
          }
        }
      });
    }
  }

  onReset() {
    setState(() {
      jobTitleCntr.clear();
      jobCompanyNameCntr.clear();
      jobDescriptionCntr.clear();
      jobEmailCntr.clear();
      jobPhoneCntr.clear();
      jobLocationCntr.clear();
      jobMoreInfoCntr.clear();
      jobWagesCntr.text = "0"; /////
      createJobAddressDistrict = "";
      createJobAddressCity = "";
      createJobAddressArea = "";
      createJobAddressDivisionString = Constants.locationsBd().names().first;
      createJobAddressDivisionDivision =
          convertStringToDivision(Constants.locationsBd().names().first);
      createJobEducation = Constants.jobEducationList.first;
      createJobPersonnel = Constants.jobPersonnelList.first;
      createJobGender = "";
      createJobDeadline = Timestamp.now();
      createJobType = Constants.jobTypeList.first;
      createJobPaymentType = Constants.jobPaymentTypeList.first;
      createJobPeriod = Constants.jobPeriodList.first;
      createJobStartDay = Constants.daysList.first;
      createJobFinishDay = Constants.daysList.last;
      createJobAge = Constants.jobAgeList.last;
    });
  }

  void showConfirmJobPostPopup(BuildContext context, bool? updateJob) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S(context).confirmJobPost),
            content: Text(S(context).sureToPostJob),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S(context).cancel)),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ceoCreateJob(context);
                  },
                  child: Text(S(context).confirm)),
            ],
          );
        });
  }

  changeDivisionList(String value) {
    createJobAddressDivisionString = value;
    setState(() {
      createJobAddressDivisionDivision = convertStringToDivision(value);
    });
  }

  changeCityList(String value) {
    setState(() {
      createJobAddressCity = value;
    });
  }

  changeEduList(String value) {
    setState(() {
      createJobEducation = value;
    });
  }

  changePersonnelList(String value) {
    setState(() {
      createJobPersonnel = value;
    });
  }

  changeJobTypeList(String value) {
    setState(() {
      createJobType = value;
    });
  }

  changePaymentTypeList(String value) {
    setState(() {
      createJobPaymentType = value;
    });
  }

  changeJobPeriodList(String value) {
    setState(() {
      createJobPeriod = value;
    });
  }

  changeJobStartDayList(String value) {
    setState(() {
      createJobStartDay = value;
    });
  }

  changeJobFinishDayList(String value) {
    setState(() {
      createJobFinishDay = value;
    });
  }
}
