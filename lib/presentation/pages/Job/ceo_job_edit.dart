import 'dart:io';import 'package:auto_route/auto_route.dart';import 'package:mehonot_admin/manager/models/Job/job_dtl_md.dart';import '../../../manager/models/Address/address_md.dart';import '../../../manager/models/Job/ReqModels/job_dtl_md_req.dart';import '../../../manager/models/Job/ReqModels/job_md_req.dart';import '../../../manager/models/Job/ReqModels/recruit_con_md_req.dart';import '../../../manager/models/Job/job_md.dart';import '../../../manager/models/Job/recruit_con_md.dart';import '../../../manager/models/Job/work_con_md.dart';import '../../../manager/redux/states/jobs_state.dart';import '../../template/template.dart';import '../../utils/constants.dart';import '../../widgets/circle_head_widget.dart';import '../../widgets/image_upload.dart';@RoutePage(name: "CeoJobEditRouter")class CeoJobEditPage extends StatefulWidget {  final JobModel jobModel;  final JobDetailModel jobDetailModel;  const CeoJobEditPage(      {required this.jobModel, required this.jobDetailModel, Key? key})      : super(key: key);  @override  State<CeoJobEditPage> createState() => _CeoJobEditPageState();}class _CeoJobEditPageState extends State<CeoJobEditPage> {  bool isDark = false;  final GlobalKey<FormState> editJobFormKey = GlobalKey<FormState>();  TextEditingController jobTitleCntr = TextEditingController();  TextEditingController jobCompanyNameCntr = TextEditingController();  TextEditingController jobDescriptionCntr = TextEditingController();  TextEditingController jobEmailCntr = TextEditingController();  TextEditingController jobPhoneCntr = TextEditingController();  TextEditingController jobLocationCntr = TextEditingController();  TextEditingController jobWagesCntr = TextEditingController(text: "0");  TextEditingController jobMoreInfoCntr = TextEditingController();  String createJobAddressDistrict = "";  String createJobAddressCity = "";  String createJobAddressArea = "";  List<String> createJobAddressDivisionList = Constants.locationsBd().names();  String createJobAddressDivisionString = Constants      .locationsBd()      .names()      .first;  Division createJobAddressDivisionDivision =  convertStringToDivision(Constants      .locationsBd()      .names()      .first);  String createJobEducation = Constants.jobEducationList.first;  String createJobPersonnel = Constants.jobPersonnelList.first;  String createJobGender = "";  DateTime createJobDeadline = DateTime.now();  String createJobType = Constants.jobTypeList.first;  String createJobPaymentType = Constants.jobPaymentTypeList.first;  String createJobPeriod = Constants.jobPeriodList.first;  String createJobStartDay = Constants.daysList.first;  String createJobFinishDay = Constants.daysList.last;  int createJobAge = 0;  String createWorkStartTime = "";  String createWorkFinishTime = "";  bool jobIsCreate = false;  List<File> imageFileList = [];  List<String> imageNameList = [];  @override  void initState() {    super.initState();    WidgetsBinding.instance.addPostFrameCallback((_) {      setAllValues();    });  }  @override  void dispose() {    jobTitleCntr.dispose();    jobCompanyNameCntr.dispose();    jobDescriptionCntr.dispose();    jobEmailCntr.dispose();    jobPhoneCntr.dispose();    jobLocationCntr.dispose();    jobWagesCntr.dispose();    jobMoreInfoCntr.dispose();    super.dispose();  }  @override  Widget build(BuildContext context) {    isDark = Theme        .of(context)        .brightness == Brightness.dark;    return Form(        key: editJobFormKey,        child: Padding(            padding: EdgeInsets.all(40.w),            child: SingleChildScrollView(                child: SpacedColumn(                    crossAxisAlignment: CrossAxisAlignment.center,                    verticalSpace: 20,                    children: [                      Align(                          alignment: Alignment.centerLeft,                          child: SizedText(                              text: S(context).title,                              textStyle: ThemeTextSemiBold.k14)),                      PrsmInputField(                        controller: jobTitleCntr,                        maxLines: 5,                        enableShadow: false,                        defaultBorderColor: ThemeColors.coolgray300,                      ),                      divider(),                      _buildCircleHeadForm(context),                      divider(),                      PrsmImageUpload(onImageSelected: (imageFile, image) {                        logger("Image Selected");                        logger(imageFile);                        logger(image);                        setState(() {                          imageFileList.clear();                          imageFileList.addAll(imageFile);                          logger("Image Selected ${imageFileList.length}");                          logger("Image Selected ${imageFileList.length}");                          // imageNameList.add(image);                        });                      }, onRemoveNetworkImg: (int) {}, imageNetUrls: [],),                      divider(),                      formHelper(                          title: S(context).companyName,                          widget: PrsmInputField(                            controller: jobCompanyNameCntr,                            enableShadow: false,                            defaultBorderColor: ThemeColors.coolgray300,                          )),                      formHelper(                          title: S(context).jobDescription,                          widget: PrsmInputField(                            controller: jobDescriptionCntr,                            enableShadow: false,                            maxLines: 8,                            defaultBorderColor: ThemeColors.coolgray300,                          )),                      divider(),                      _buildRecruitFormSec(),                      divider(),                      _buildAddressFormSec(),                      divider(),                      _buildContactFormSec(),                      divider(),                      PrimaryButton(                          buttonText: S(context).updateJob,                          buttonSize: ButtonSize.L,                          onPressed: () async {                            logger("Update Job Pressed");                            if (editJobFormKey.currentState!.validate()) {                              showConfirmJobPostPopup(context, true);                            } else {                              logger(context.intl.validationError);                            }                          })                    ]))));  }  Widget _buildContactFormSec() {    return SpacedColumn(        crossAxisAlignment: CrossAxisAlignment.start,        verticalSpace: 20,        children: [          SizedText(text: S(context).address, textStyle: ThemeTextSemiBold.k18),          formHelper(              title: S(context).email,              widget: PrsmInputField(                  controller: jobEmailCntr,                  defaultBorderColor: ThemeColors.coolgray300,                  enableShadow: false)),          formHelper(              title: S(context).phone,              widget: PrsmInputField(                  controller: jobPhoneCntr,                  defaultBorderColor: ThemeColors.coolgray300,                  enableShadow: false)),        ]);  }  Widget _buildAddressFormSec() {    return SpacedColumn(        crossAxisAlignment: CrossAxisAlignment.start,        verticalSpace: 20,        children: [          SizedText(text: S(context).address, textStyle: ThemeTextSemiBold.k18),          formHelperForDropdowns(            listValuesLeft: Constants.locationsBd().names(),            listValuesRight: ["Add cities", ""],            titleLeft: S(context).division,            titleRight: S(context).city,            valueLeft: createJobAddressDivisionString,            valueRight: createJobAddressCity,            onChangedLeft: (value) => changeDivisionList(value),            onChangedRight: (value) => changeCityList(value),          ),          formHelper(              title: S(context).location,              widget: PrsmInputField(                  controller: jobLocationCntr,                  defaultBorderColor: ThemeColors.coolgray300,                  enableShadow: false)),        ]);  }  Widget _buildRecruitFormSec() {    return SpacedColumn(      crossAxisAlignment: CrossAxisAlignment.start,      verticalSpace: 20,      children: [        SizedText(            text: S(context).recruitCondition,            textStyle: ThemeTextSemiBold.k18),        formHelperForDropdowns(          listValuesLeft: Constants.jobEducationList,          listValuesRight: Constants.jobPersonnelList,          titleLeft: S(context).education,          titleRight: S(context).personnel,          valueLeft: createJobEducation,          valueRight: createJobPersonnel,          onChangedLeft: (value) => changeEduList(value),          onChangedRight: (value) => changePersonnelList(value),        ),        formHelperForDropdowns(          listValuesLeft: [],          listValuesRight: [],          titleLeft: S(context).gender,          titleRight: S(context).deadline,          valueLeft: createJobGender,          valueRight: createJobDeadline,          onChangedLeft: (value) {},          onChangedRight: (value) {},        ),        formHelperForDropdowns(          listValuesLeft: Constants.jobTypeList,          listValuesRight: Constants.jobPaymentTypeList,          titleLeft: S(context).type,          titleRight: S(context).payment,          valueLeft: createJobType,          valueRight: createJobPaymentType,          onChangedLeft: (value) => changeJobTypeList(value),          onChangedRight: (value) => changePaymentTypeList(value),        ),      ],    );  }  Widget formHelperForDropdowns({    required ValueChanged onChangedLeft,    required List listValuesLeft,    required String titleLeft,    dynamic valueLeft,    required ValueChanged onChangedRight,    required List listValuesRight,    required String titleRight,    dynamic valueRight,  }) {    return SizedBox(      width: double.infinity,      child: SpacedRow(          mainAxisAlignment: MainAxisAlignment.spaceBetween,          children: [            formHelper(                title: titleLeft,                width: (MediaQuery                    .of(context)                    .size                    .width - 100.w) / 2,                widget: PrsmDropdown(                    listValues: listValuesLeft,                    enableShadow: false,                    enableBorder: true,                    value: valueLeft,                    bgColor: isDark                        ? MehonotColorsDark.formFillColor                        : ThemeColors.coolgray200,                    onChanged: onChangedLeft)),            formHelper(                title: titleRight,                width: (MediaQuery                    .of(context)                    .size                    .width - 100.w) / 2,                widget: PrsmDropdown(                    listValues: listValuesRight,                    enableShadow: false,                    enableBorder: true,                    value: valueRight,                    bgColor: isDark                        ? MehonotColorsDark.formFillColor                        : ThemeColors.coolgray200,                    onChanged: onChangedRight)),          ]),    );  }  Widget formHelper(      {required String title, required Widget widget, double? width}) {    return Container(        width: width ?? double.infinity,        padding: EdgeInsets.all(20.w),        decoration: BoxDecoration(            color: isDark ? MehonotColorsDark.canvasColor : ThemeColors.white,            boxShadow: ThemeShadows.shadowSm,            borderRadius: BorderRadius.circular(12.r)),        child: SpacedColumn(            crossAxisAlignment: CrossAxisAlignment.start,            verticalSpace: 10,            children: [              SizedText(text: title, textStyle: ThemeTextSemiBold.k14),              widget            ]));  }  Widget _buildCircleHeadForm(BuildContext context,) {    return SpacedColumn(verticalSpace: 10, children: [      formTopHelper(          circleHeadTitle: S(context).wages,          widget: SizedBox(              width: MediaQuery                  .of(context)                  .size                  .width - 300.w,              child: PrsmInputField(                  controller: jobWagesCntr,                  defaultBorderColor: ThemeColors.coolgray300,                  enableShadow: false))),      formTopHelper(          circleHeadTitle: S(context).period,          widget: SizedBox(              width: MediaQuery                  .of(context)                  .size                  .width - 300.w,              height: 140.h,              child: PrsmDropdown(                  enableBorder: true,                  onChanged: (value) => changeJobPeriodList(value),                  listValues: Constants.jobPeriodList,                  value: createJobPeriod,                  enableShadow: false))),      formTopHelper(          circleHeadIcon: HeroIcons.clock,          widget: SpacedRow(horizontalSpace: 10, children: [            SizedBox(                width: (MediaQuery                    .of(context)                    .size                    .width - 310.w) / 2,                child: PrsmInputField(                    onTap: () =>                        showTimePickerPopup(context, true, createWorkStartTime),                    hintText: S(context).startTime,                    enabled: false,                    controller:                    TextEditingController(text: createWorkStartTime),                    defaultBorderColor: ThemeColors.white,                    enableShadow: false)),            SizedBox(                width: (MediaQuery                    .of(context)                    .size                    .width - 310.w) / 2,                child: PrsmInputField(                    onTap: () =>                        showTimePickerPopup(                            context, false, createWorkFinishTime),                    hintText: S(context).endTime,                    enabled: false,                    controller:                    TextEditingController(text: createWorkFinishTime),                    defaultBorderColor: ThemeColors.white,                    enableShadow: false))          ])),      formTopHelper(          circleHeadIcon: HeroIcons.calendar,          widget: SpacedRow(horizontalSpace: 10, children: [            SizedBox(                width: (MediaQuery                    .of(context)                    .size                    .width - 310.w) / 2,                height: 140.h,                child: PrsmDropdown(                    enableBorder: true,                    onChanged: (value) => changeJobStartDayList(value),                    listValues: Constants.daysList,                    value: createJobStartDay,                    enableShadow: false)),            SizedBox(                width: (MediaQuery                    .of(context)                    .size                    .width - 310.w) / 2,                height: 140.h,                child: PrsmDropdown(                    enableBorder: true,                    onChanged: (value) => changeJobFinishDayList(value),                    listValues: Constants.daysList,                    value: createJobFinishDay,                    enableShadow: false))          ]))    ]);  }  Widget formTopHelper({String? circleHeadTitle,    HeroIcons? circleHeadIcon,    required Widget widget}) {    return SpacedRow(      mainAxisAlignment: MainAxisAlignment.spaceBetween,      crossAxisAlignment: CrossAxisAlignment.center,      children: [        CircleHeadWidget(            circleSize: 160.w,            iconSize: 60.w,            title: circleHeadTitle,            icon: circleHeadIcon),        widget      ],    );  }  Widget divider() {    return const Divider(      color: ThemeColors.coolgray300,    );  }  void showConfirmJobPostPopup(BuildContext context, bool? updateJob) {    //TODO: UpdateJob    showDialog(        context: context,        builder: (BuildContext context) {          return AlertDialog(            title: Text(S(context).confirmJobPost),            content: Text(S(context).sureToPostJob),            actions: [              TextButton(                  onPressed: () {                    Navigator.pop(context);                  },                  child: Text(S(context).cancel)),              TextButton(                  onPressed: () {                    Navigator.pop(context);                    ceoCreateJob(context);                  },                  child: Text(S(context).confirm)),            ],          );        });  }  showTimePickerPopup(BuildContext context, bool isStartTime,      String initialTime) {    // Convert string "13:00" to TimeOfDay    TimeOfDay initialTimeOfDay = TimeOfDay(        hour: int.parse(initialTime.split(":")[0]),        minute: int.parse(initialTime.split(":")[1]));    showTimePicker(        context: context,        initialTime: initialTimeOfDay,        initialEntryMode: TimePickerEntryMode.dial,        hourLabelText: S(context).hour,        minuteLabelText: S(context).minute,        builder: (BuildContext context, Widget? child) {          return MediaQuery(            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),            child: child!,          );        }).then((value) {      if (value != null) {        //Make time of day to string like "13:00"        String time = "${value.hour}:${value.minute}";        if (isStartTime) {          setState(() {            createWorkStartTime = time;          });        } else {          setState(() {            createWorkFinishTime = time;          });        }      }    });  }  Future ceoCreateJob(BuildContext context) async {    await appStore.dispatch(GetUpdateJobAction(        jobModel: JobModel(          jobId: widget.jobModel.jobId,          jobDetailsId: widget.jobDetailModel.jobDetailsId,          title: jobTitleCntr.text,          companyName: jobCompanyNameCntr.text,          workStartTime: "1:00",          workFinishTime: "12:00",          address: AddressModel(            division: createJobAddressDivisionString,            district: createJobAddressDistrict,            city: createJobAddressCity,            area: createJobAddressArea,          ),          postedByUserId: appStore.state.userState.userData.userId,          images: widget.jobModel.images,          companyLogo: widget.jobModel.companyLogo,          type: createJobType,          status: widget.jobModel.status,          wageAmount: double.parse(jobWagesCntr.text),          timestamp: widget.jobModel.timestamp,        ),        jobDetailModel: JobDetailModel(          jobId: widget.jobModel.jobId,          jobDetailsId: widget.jobDetailModel.jobDetailsId,          phone: jobPhoneCntr.text,          category: "",          ownerName: "",          website: "",          email: jobEmailCntr.text,          description: jobDescriptionCntr.text,          moreDetails: jobMoreInfoCntr.text,          recruitCondition: RecruitConModel(            education: createJobEducation,            age: createJobAge,            deadline: createJobDeadline.toString(),            gender: createJobGender,            personnel: createJobPersonnel,          ),          workCondition: WorkConModel(            period: createJobPeriod,            wageType: createJobPaymentType,            workStartDay: createJobStartDay,            workFinishDay: createJobFinishDay,          ),        )));    onReset();    context.navigateBack();  }  void setAllValues() {    setState(() {      jobTitleCntr.text = widget.jobModel.title;      jobCompanyNameCntr.text = widget.jobModel.companyName;      jobDescriptionCntr.text = widget.jobDetailModel.description ?? "";      jobEmailCntr.text = widget.jobDetailModel.email ?? "";      jobPhoneCntr.text = widget.jobDetailModel.phone;      jobLocationCntr.text = widget.jobModel.address.area ?? "";      jobWagesCntr.text =          widget.jobModel.wageAmount.toString();      jobMoreInfoCntr.text = widget.jobDetailModel.moreDetails ?? "";      createJobAddressDistrict = widget.jobModel.address.district ?? "";      createJobAddressCity = widget.jobModel.address.city ?? "";      createJobAddressArea = widget.jobModel.address.area ?? "";      createJobAddressDivisionString = widget.jobModel.address.division;      createJobAddressDivisionDivision =          convertStringToDivision(widget.jobModel.address.division);      createJobEducation = widget.jobDetailModel.recruitCondition.education ??          Constants.jobEducationList.first;      createJobPersonnel = widget.jobDetailModel.recruitCondition.personnel ??          Constants.jobPersonnelList.first;      createJobGender = "Add later";      createJobDeadline = convertStringToDateTime(          widget.jobDetailModel.recruitCondition.deadline);      createJobType = widget.jobModel.type;      createJobPeriod = widget.jobDetailModel.workCondition.period ?? "";      createJobPaymentType = widget.jobDetailModel.workCondition.wageType ??          Constants.jobPaymentTypeList.first;      createJobStartDay = widget.jobDetailModel.workCondition.workStartDay ??          Constants.daysList.first;      createJobFinishDay = widget.jobDetailModel.workCondition.workFinishDay ??          Constants.daysList.first;      createWorkStartTime = widget.jobModel.workStartTime;      createWorkFinishTime = widget.jobModel.workFinishTime;    });  }  onReset() {    setState(() {      jobTitleCntr.clear();      jobCompanyNameCntr.clear();      jobDescriptionCntr.clear();      jobEmailCntr.clear();      jobPhoneCntr.clear();      jobLocationCntr.clear();      jobMoreInfoCntr.clear();      jobWagesCntr.text = "0"; /////      createJobAddressDistrict = "";      createJobAddressCity = "";      createJobAddressArea = "";      createJobAddressDivisionString = Constants          .locationsBd()          .names()          .first;      createJobAddressDivisionDivision =          convertStringToDivision(Constants              .locationsBd()              .names()              .first);      createJobEducation = Constants.jobEducationList.first;      createJobPersonnel = Constants.jobPersonnelList.first;      createJobGender = "";      createJobDeadline = DateTime.now();      createJobType = Constants.jobTypeList.first;      createJobPaymentType = Constants.jobPaymentTypeList.first;      createJobPeriod = Constants.jobPeriodList.first;      createJobStartDay = Constants.daysList.first;      createJobFinishDay = Constants.daysList.last;      createJobAge = 0;      createWorkStartTime = "";      createWorkFinishTime = ""; //website    });  }  changeDivisionList(String value) {    createJobAddressDivisionString = value;    setState(() {      createJobAddressDivisionDivision = convertStringToDivision(value);    });  }  changeCityList(String value) {    setState(() {      createJobAddressCity = value;    });  }  changeEduList(String value) {    setState(() {      createJobEducation = value;    });  }  changePersonnelList(String value) {    setState(() {      createJobPersonnel = value;    });  }  changeJobTypeList(String value) {    setState(() {      createJobType = value;    });  }  changePaymentTypeList(String value) {    setState(() {      createJobPaymentType = value;    });  }  changeJobPeriodList(String value) {    setState(() {      createJobPeriod = value;    });  }  changeJobStartDayList(String value) {    setState(() {      createJobStartDay = value;    });  }  changeJobFinishDayList(String value) {    setState(() {      createJobFinishDay = value;    });  }}