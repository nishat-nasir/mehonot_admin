import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mehonot_admin/manager/models/Job/job_dtl_md.dart';
import '../../../manager/models/Address/address_md.dart';
import '../../../manager/models/Job/job_md.dart';
import '../../../manager/models/Job/recruit_con_md.dart';
import '../../../manager/models/Job/work_con_md.dart';
import '../../../manager/redux/states/jobs_state.dart';
import '../../template/template.dart';
import '../../utils/common/validators.dart';
import '../../utils/constants.dart';
import '../../widgets/circle_head_widget.dart';
import '../../widgets/modals/calendar_popup.dart';
import '../../widgets/photo_widgets/image_upload.dart';
import 'Popups/job_category_popup.dart';

@RoutePage(name: "CeoJobEditRouter")
class CeoJobEditPage extends StatefulWidget {
  final JobModel jobModel;
  final JobDetailModel jobDetailModel;

  const CeoJobEditPage(
      {required this.jobModel, required this.jobDetailModel, Key? key})
      : super(key: key);

  @override
  State<CeoJobEditPage> createState() => _CeoJobEditPageState();
}

class _CeoJobEditPageState extends State<CeoJobEditPage> {
  bool isDark = false;
  final GlobalKey<FormState> editJobFormKey = GlobalKey<FormState>();
  TextEditingController jobTitleCntr = TextEditingController();
  TextEditingController jobCompanyNameCntr = TextEditingController();
  TextEditingController jobDescriptionCntr = TextEditingController();
  TextEditingController jobEmailCntr = TextEditingController();
  TextEditingController jobWebsiteCntr = TextEditingController();
  TextEditingController jobPhoneCntr = TextEditingController();
  TextEditingController jobLocationCntr = TextEditingController();
  TextEditingController jobWageAmountCntr = TextEditingController();
  TextEditingController jobMoreInfoCntr = TextEditingController();
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
  String createWorkStartTime = "";
  String createWorkFinishTime = "";
  List<String> networkImages = [];
  List<String> imageUrlsToDelete = [];
  List<File>? imageFilesToAdd;
  List<String> selectedJobCategories = [];

  bool isFetchingJob = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setAllValues();
    });
  }

  @override
  void dispose() {
    jobTitleCntr.dispose();
    jobCompanyNameCntr.dispose();
    jobDescriptionCntr.dispose();
    jobEmailCntr.dispose();
    jobWebsiteCntr.dispose();
    jobPhoneCntr.dispose();
    jobLocationCntr.dispose();
    jobWageAmountCntr.dispose();
    jobMoreInfoCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDark = Theme.of(context).brightness == Brightness.dark;
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return isFetchingJob
              ? const Center(child: CircularProgressIndicator())
              : Form(
                  key: editJobFormKey,
                  child: Padding(
                      padding: EdgeInsets.all(40.w),
                      child: SingleChildScrollView(
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
                              defaultBorderColor: ThemeColors.coolgray300,
                            ),
                            divider(),
                            _buildCircleHeadForm(context),
                            divider(),
                            PrsmImageUpload(
                                imageNetUrls: networkImages,
                                maxImageCount: 3,
                                onRemoveNetworkImg: (index) {
                                  if (networkImages.isNotEmpty) {
                                    setState(() {
                                      imageUrlsToDelete
                                          .add(networkImages[index]);
                                      networkImages.removeAt(index);
                                    });
                                  }
                                },
                                onImageSelected: (imageFile, image) {
                                  logger("Image Selected");
                                  logger(imageFile);
                                  logger(image);
                                  setState(() {
                                    imageFilesToAdd = imageFile;
                                  });
                                }),
                            divider(),
                            formHelper(
                                title: S(context).companyName,
                                widget: SpacedColumn(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PrsmInputField(
                                          controller: jobCompanyNameCntr,
                                          enableShadow: false,
                                          disableAll: true,
                                          defaultBorderColor:
                                              ThemeColors.coolgray300),
                                      SizedText(
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        text:
                                            "*${S(context).canNotChangeComName}",
                                        textStyle: ThemeTextRegular.k10
                                            .copyWith(
                                                color: ThemeColors.red500),
                                      )
                                    ])),
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
                                buttonText: S(context).updateJob,
                                buttonSize: ButtonSize.L,
                                onPressed: () async {
                                  logger("Update Job Pressed");

                                  if (editJobFormKey.currentState!.validate()) {
                                    showConfirmJobPostPopup(context, true);
                                  } else {
                                    logger(context.intl.validationError);
                                  }
                                }),
                            SizedBox(height: 60.h)
                          ]))));
        });
  }

  Widget _buildContactFormSec() {
    return SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalSpace: 20,
        children: [
          SizedText(text: S(context).address, textStyle: ThemeTextSemiBold.k18),
          formHelper(
              title: S(context).email,
              widget: PrsmInputField(
                  controller: jobEmailCntr,
                  defaultBorderColor: ThemeColors.coolgray300,
                  enableShadow: false)),
          formHelper(
              title: S(context).website,
              widget: PrsmInputField(
                  controller: jobWebsiteCntr,
                  defaultBorderColor: ThemeColors.coolgray300,
                  enableShadow: false)),
          formHelper(
              title: S(context).phone,
              widget: PrsmInputField(
                  controller: jobPhoneCntr,
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
            valueRight: createJobAddressCity,
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
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
            color: isDark ? PrsmColorsDark.canvasColor : ThemeColors.white,
            boxShadow: ThemeShadows.shadowSm,
            borderRadius: BorderRadius.circular(12.r)),
        child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalSpace: 10,
            children: [
              SizedText(text: title, textStyle: ThemeTextSemiBold.k14),
              widget
            ]));
  }

  Widget _buildCircleHeadForm(
    BuildContext context,
  ) {
    return SpacedColumn(verticalSpace: 10, children: [
      formTopHelper(
          circleHeadTitle: S(context).wages,
          widget: SizedBox(
              width: MediaQuery.of(context).size.width - 300.w,
              child: PrsmInputField(
                  controller: jobWageAmountCntr,
                  defaultBorderColor: ThemeColors.coolgray300,
                  enableShadow: false))),
      formTopHelper(
          circleHeadTitle: S(context).period,
          widget: SizedBox(
              width: MediaQuery.of(context).size.width - 300.w,
              height: 140.h,
              child: PrsmDropdown(
                  enableBorder: true,
                  onChanged: (value) => changeJobPeriodList(value),
                  listValues: Constants.jobPeriodList,
                  value: createJobPeriod,
                  enableShadow: false))),
      formTopHelper(
          circleHeadIcon: HeroIcons.clock,
          widget: SpacedRow(horizontalSpace: 10, children: [
            SizedBox(
                width: (MediaQuery.of(context).size.width - 310.w) / 2,
                child: PrsmInputField(
                    onTap: () =>
                        showTimePickerPopup(context, true, createWorkStartTime),
                    hintText: S(context).startTime,
                    enabled: false,
                    controller:
                        TextEditingController(text: createWorkStartTime),
                    defaultBorderColor: ThemeColors.white,
                    enableShadow: false)),
            SizedBox(
                width: (MediaQuery.of(context).size.width - 310.w) / 2,
                child: PrsmInputField(
                    onTap: () => showTimePickerPopup(
                        context, false, createWorkFinishTime),
                    hintText: S(context).endTime,
                    enabled: false,
                    controller:
                        TextEditingController(text: createWorkFinishTime),
                    defaultBorderColor: ThemeColors.white,
                    enableShadow: false))
          ])),
      formTopHelper(
          circleHeadIcon: HeroIcons.calendar,
          widget: SpacedRow(horizontalSpace: 10, children: [
            SizedBox(
                width: (MediaQuery.of(context).size.width - 310.w) / 2,
                height: 140.h,
                child: PrsmDropdown(
                    enableBorder: true,
                    onChanged: (value) => changeJobStartDayList(value),
                    listValues: Constants.daysList,
                    value: createJobStartDay,
                    enableShadow: false)),
            SizedBox(
                width: (MediaQuery.of(context).size.width - 310.w) / 2,
                height: 140.h,
                child: PrsmDropdown(
                    enableBorder: true,
                    onChanged: (value) => changeJobFinishDayList(value),
                    listValues: Constants.daysList,
                    value: createJobFinishDay,
                    enableShadow: false))
          ]))
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
            iconSize: 60.w,
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

  void showConfirmJobPostPopup(BuildContext context, bool? updateJob) {
    //TODO: UpdateJob
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
                    ceoUpdateJob(context);
                  },
                  child: Text(S(context).confirm)),
            ],
          );
        });
  }

  showTimePickerPopup(
      BuildContext context, bool isStartTime, String initialTime) {
    // Convert string "13:00" to TimeOfDay
    TimeOfDay initialTimeOfDay = TimeOfDay(
        hour: int.parse(initialTime.split(":")[0]),
        minute: int.parse(initialTime.split(":")[1]));

    showTimePicker(
        context: context,
        initialTime: initialTimeOfDay,
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
        //Make time of day to string like "13:00"
        String time = "${value.hour}:${value.minute}";

        if (isStartTime) {
          setState(() {
            createWorkStartTime = time;
            logger(createWorkStartTime, hint: "SDfsdfdsfSS");
          });
        } else {
          setState(() {
            createWorkFinishTime = time;
            logger(createWorkFinishTime, hint: "SDfsdfdsfEE");
          });
        }
      }
    });
  }

  Future ceoUpdateJob(BuildContext context) async {
    final userProfileData = appStore.state.userState.userProfileData;

    await appStore.dispatch(GetUpdateJobAction(
        imageFilesToAdd: imageFilesToAdd,
        imageUrlsToAdd: networkImages,
        imageUrlsToDelete: imageUrlsToDelete,
        jobModel: JobModel(
          jobId: widget.jobModel.jobId,
          jobDetailsId: widget.jobDetailModel.jobDetailsId,
          title: jobTitleCntr.text,
          companyName: jobCompanyNameCntr.text,
          workStartTime: createWorkStartTime,
          workFinishTime: createWorkFinishTime,
          companyLogo: widget.jobModel.companyLogo,
          address: AddressModel(
            division: createJobAddressDivisionString,
            district: createJobAddressDistrict,
            city: createJobAddressCity,
            area: createJobAddressArea,
          ),
          postedByUserId: appStore.state.userState.userData.userId,
          tags: [],
          category: selectedJobCategories,
          type: createJobType,
          status: widget.jobModel.status,
          timestamp: widget.jobModel.timestamp,
          wageAmount: double.parse(jobWageAmountCntr.text),
        ),
        jobDetailModel: JobDetailModel(
          jobId: widget.jobModel.jobId,
          jobDetailsId: widget.jobDetailModel.jobDetailsId,
          phone: jobPhoneCntr.text,
          images: networkImages,
          ownerName: "${userProfileData.firstName} ${userProfileData.lastName}",
          website: jobWebsiteCntr.text,
          email: jobEmailCntr.text,
          description: jobDescriptionCntr.text,
          moreDetails: jobMoreInfoCntr.text,
          recruitCondition: RecruitConModel(
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
        )));
    onReset();
    context.back();
  }

  void setAllValues() async {
    setState(() {
      isFetchingJob = true;
    });

    JobModel job = await appStore.dispatch(GetJobDataByIdAction(
        jobId: widget.jobDetailModel.jobId,
        jobDivision:
            convertStringToDivision(widget.jobModel.address.division)));

    setState(() {
      jobTitleCntr.text = job.title;
      jobCompanyNameCntr.text = job.companyName;
      jobDescriptionCntr.text = widget.jobDetailModel.description ?? "";
      jobEmailCntr.text = widget.jobDetailModel.email ?? "";
      jobWebsiteCntr.text = widget.jobDetailModel.website ?? "";
      jobPhoneCntr.text = widget.jobDetailModel.phone;
      jobWageAmountCntr.text = job.wageAmount.toString();
      jobLocationCntr.text = job.address.area ?? "";
      jobWageAmountCntr.text = job.wageAmount.toString();
      jobMoreInfoCntr.text = widget.jobDetailModel.moreDetails ?? "";
      createJobAddressDistrict = job.address.district ?? "";
      createJobAddressCity = job.address.city ?? "";
      createJobAddressArea = job.address.area ?? "";
      createJobAddressDivisionString = job.address.division;
      createJobAddressDivisionDivision =
          convertStringToDivision(job.address.division);
      createJobEducation = widget.jobDetailModel.recruitCondition.education ??
          Constants.jobEducationList.first;
      createJobPersonnel = widget.jobDetailModel.recruitCondition.personnel ??
          Constants.jobPersonnelList.first;
      createJobGender = "Add later";
      createJobDeadline = widget.jobDetailModel.recruitCondition.deadline;
      createJobType = job.type;
      createJobPeriod = widget.jobDetailModel.workCondition.period ?? "";
      createJobPaymentType = widget.jobDetailModel.workCondition.wageType ??
          Constants.jobPaymentTypeList.first;
      createJobStartDay = widget.jobDetailModel.workCondition.workStartDay ??
          Constants.daysList.first;
      createJobFinishDay = widget.jobDetailModel.workCondition.workFinishDay ??
          Constants.daysList.first;
      createWorkStartTime = job.workStartTime;
      createWorkFinishTime = job.workFinishTime;
      networkImages = widget.jobDetailModel.images;
      isFetchingJob = false;
      selectedJobCategories = job.category;
      createJobDeadlineCntr.text = createJobDeadlineCntr.text =
          DateFormat("dd MMM yyyy").format(createJobDeadline.toDate());
    });
  }

  onReset() {
    setState(() {
      jobTitleCntr.clear();
      jobCompanyNameCntr.clear();
      jobDescriptionCntr.clear();
      jobEmailCntr.clear();
      jobWebsiteCntr.clear();
      jobPhoneCntr.clear();
      jobLocationCntr.clear();
      jobMoreInfoCntr.clear();
      jobWageAmountCntr.text = "0"; /////
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
      createWorkStartTime = "";
      createWorkFinishTime = ""; //website
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
