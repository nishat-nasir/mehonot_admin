import 'package:auto_route/auto_route.dart';import 'package:flutter/services.dart';import 'package:flutter_slidable/flutter_slidable.dart';import '../../../manager/models/Address/address_md.dart';import '../../../manager/models/Job/job_dtl_md.dart';import '../../../manager/models/Job/job_md.dart';import '../../../manager/models/User/user_profile_md.dart';import '../../../manager/navigation/router.gr.dart';import '../../../manager/redux/states/account_state.dart';import '../../../manager/redux/states/jobs_state.dart';import '../../../manager/redux/states/user_state.dart';import '../../template/template.dart';import '../../utils/common/validators.dart';import '../../utils/constants.dart';import '../../widgets/bottomsheet/default_bottomsheet.dart';import '../Job/job_details_view.dart';@RoutePage(name: "MyAccountRouter")class Account01Page extends StatefulWidget {  const Account01Page({Key? key}) : super(key: key);  @override  State<Account01Page> createState() => _Account01PageState();}class _Account01PageState extends State<Account01Page> {  List<String> listOfMyJobPostsId = [];  List<JobModel> listOfMyJobPostsData = [];  final TextEditingController _oldPassCntr = TextEditingController();  final TextEditingController _newPassCntr = TextEditingController();  final TextEditingController _confirmPassCntr = TextEditingController();  @override  void initState() {    super.initState();    listOfMyJobPostsId =        appStore.state.userState.userJobRelationData.myJobsIds ?? [];    _fetchAllMyPostedJobs();  }  @override  Widget build(BuildContext context) {    return StoreConnector<AppState, AppState>(        converter: (store) => store.state,        builder: (_, state) {          return Padding(              padding: EdgeInsets.all(24.w),              child: SpacedColumn(                verticalSpace: 40,                children: [_buildEditProfileSec(), _buildMyJobPosts()],              ));        });  }  Widget _buildEditProfileSec() {    return Container(        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),        decoration: BoxDecoration(          color:          isDark(context) ? PrsmColorsDark.canvasColor : ThemeColors.white,          borderRadius: BorderRadius.circular(10.w),        ),        child: SpacedColumn(verticalSpace: 10, children: [          editProfileItem(              title: S(context).changePassword,              value: "**********",              icon: HeroIcons.lockClosed,              onTap: () {                _buildChangePassBottomSheet();              }),          editProfileItem(              title: S(context).changeLoginId,              value: appStore.state.userState.userData.phoneNumber,              icon: HeroIcons.identification,              onTap: () {                context.pushRoute(const AccountChangeIdRouter());              }),          editProfileItem(              title: S(context).changeDivision,              value: appStore.state.userState.userProfileData.address.division,              icon: HeroIcons.mapPin,              onTap: () {                _buildChangeDivisionBottomSheet();              }),          editProfileItem(              title: "${S(context).premium} ${S(context).account}",              value: "",              icon: HeroIcons.checkBadge,              isLast: true,              onTap: () {}),        ]));  }  Widget _buildMyJobPosts() {    return SizedBox(        width: MediaQuery            .of(context)            .size            .width,        child: SpacedColumn(            crossAxisAlignment: CrossAxisAlignment.center,            verticalSpace: 20,            children: [              Align(                  alignment: Alignment.centerLeft,                  child: SizedText(                    text: S(context).myJobPosts,                    textStyle: ThemeTextRegular.k16,                  )),              if (listOfMyJobPostsId.isEmpty)                Center(                    child: SizedText(                      text: S(context).noJobPosts,                    ))              else                SizedBox(                    height: MediaQuery                        .of(context)                        .size                        .height -                        (ThemeSizeStyle.bottomNavHeight.h + 810.h),                    child: SingleChildScrollView(child: jobContainers()))            ]));  }  Widget jobContainers() {    List<Widget> list = [];    for (var i = 0; i < listOfMyJobPostsData.length; i++) {      list.add(Slidable(        key: ValueKey(i),        endActionPane: ActionPane(            extentRatio: 0.25,            motion: const ScrollMotion(),            children: [              SizedBox(width: 25.w),              SlidableAction(                  borderRadius: BorderRadius.circular(32.r),                  onPressed: (BuildContext context) async {                    // bool success = await appStore.dispatch(                    //     GetRemoveFromMyJobsIdsAction(                    //         jobId: listOfMyJobPostsData[i].jobId,                    //         jobDetailsId: listOfMyJobPostsData[i].jobDetailsId,                    //         division: convertStringToDivision(                    //             listOfMyJobPostsData[i].address.division)));                    // if (success) {                    //   setState(() {                    //     if (i < listOfMyJobPostsData.length) {                    //       listOfMyJobPostsData.removeAt(i);                    //     }                    //   });                    // }                  },                  backgroundColor: ThemeColors.red500,                  foregroundColor: Colors.white,                  icon: Icons.delete_outline_rounded,                  autoClose: true,                  padding: EdgeInsets.zero),              SizedBox(width: 25.w)            ]),        child: PrsmJobContainer(            onReqDecline: () async {              bool success = await appStore.dispatch(GetJobDetailsAction(                  jobId: listOfMyJobPostsData[i].jobId,                  jobDetailsId: listOfMyJobPostsData[i].jobDetailsId,                  division: convertStringToDivision(                      listOfMyJobPostsData[i].address.division)));              if (success) {                context.pushRoute(CeoJobEditRouter(                  jobDetailModel:                  appStore.state.jobsState.selectedJobDetailModel,                  jobModel: listOfMyJobPostsData[i],                ));              }            },            onTap: () async {              bool success = await fetchJobDetailsAndShowModal(                  division: convertStringToDivision(                      listOfMyJobPostsData[i].address.division),                  jobId: listOfMyJobPostsData[i].jobId,                  jobDetailsId: listOfMyJobPostsData[i].jobDetailsId);              if (success) {                if (!mounted) return;                await showJobModalDetails(                    context: context, currentJob: listOfMyJobPostsData[i]);              }            },            jobModel: listOfMyJobPostsData[i]),      ));    }    return SpacedColumn(verticalSpace: 18, children: list);  }  Future<bool> fetchJobDetailsAndShowModal({required String jobId,    required String jobDetailsId,    required Division division}) async {    bool success = await appStore.dispatch(GetJobDetailsAction(        division: division, jobId: jobId, jobDetailsId: jobDetailsId));    return success;  }  showJobModalDetails({    required BuildContext context,    required JobModel currentJob,  }) async {    JobDetailModel currentJobDetails =        appStore.state.jobsState.selectedJobDetailModel;    UserProfileModel userProfileModel =        appStore.state.userState.userProfileData;    // if (userProfileModel.savedJobsIds != null &&    //     userProfileModel.savedJobsIds!.isNotEmpty) {    //   setState(() {    //     // isJobSavedOrNot =    //     //     userProfileModel.savedJobsIds!.contains(currentJob.jobId);    //   });    // } else {    //   setState(() {    //     // isJobSavedOrNot = false;    //   });    // }    return await showModalBottomSheet(        enableDrag: false,        isScrollControlled: true,        useRootNavigator: true,        context: context,        isDismissible: true,        shape: const RoundedRectangleBorder(            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),        builder: (context) {          return FractionallySizedBox(              heightFactor: 0.90,              child: SpacedColumn(verticalSpace: 24, children: [                const SizedBox(),                Align(                    alignment: Alignment.centerRight,                    child: InkWell(                        onTap: () {                          Navigator.pop(context);                        },                        child: const Padding(                            padding: EdgeInsets.symmetric(horizontal: 16),                            child: HeroIcon(                              HeroIcons.xMark,                              size: 32,                            )))),                StatefulBuilder(                    builder: (BuildContext ctx, StateSetter stState) {                      return JobDetailsView(                          bottomBtn: SizedBox(                              height: 40,                              width: MediaQuery                                  .of(context)                                  .size                                  .width - 200.w,                              child: PrimaryButton(                                buttonText: S(context).delete,                                buttonType: ButtonType.Ghost,                                linkTypeBtnColor: ThemeColors.red500,                                icon: HeroIcons.trash,                                onPressed: () async {                                  // bool success = await appStore.dispatch(                                  //     GetRemoveFromMyJobsIdsAction(                                  //         jobId: currentJob.jobId,                                  //         jobDetailsId: currentJob.jobDetailsId,                                  //         division: convertStringToDivision(                                  //             currentJob.address.division)));                                  // if (success) {                                  //   Navigator.pop(context);                                  //   setState(() {                                  //     listOfMyJobPostsData.remove(currentJob);                                  //   });                                  // }                                },                              )),                          jobModel: JobModel(                            title: currentJob.title,                            images: currentJob.images,                            companyLogo: currentJob.companyLogo,                            address: AddressModel(                              area: currentJob.address.area,                              division: currentJob.address.division,                              city: currentJob.address.city,                              district: currentJob.address.district,                            ),                            postedByUserId: currentJob.postedByUserId,                            type: currentJob.type,                            workStartTime: currentJob.workStartTime,                            // currentJob.workStartTime,                            workFinishTime: currentJob.workFinishTime,                            //currentJob.workFinishTime,                            companyName: currentJob.companyName,                            jobId: currentJob.jobId,                            jobDetailsId: currentJob.jobDetailsId,                            status: currentJob.status,                            timestamp: currentJob.timestamp,                            wageAmount: currentJob.wageAmount,                          ),                          jobDetailModel: JobDetailModel(                            description: currentJobDetails.description,                            jobId: currentJobDetails.jobId,                            jobDetailsId: currentJobDetails.jobDetailsId,                            phone: currentJobDetails.phone,                            email: currentJobDetails.email,                            website: currentJobDetails.website,                            workCondition: currentJobDetails.workCondition,                            ownerName: currentJobDetails.ownerName,                            recruitCondition: currentJobDetails                                .recruitCondition,                            category: currentJobDetails.category,                          ));                    }),              ]));        });  }  Future _fetchAllMyPostedJobs() async {    bool success = await appStore.dispatch(GetAllMyPostedJobsAction());    if (success) {      setState(() {        listOfMyJobPostsData = appStore.state.accountState.myPostedJobsData;      });    }  }  Widget editProfileItem({    required String title,    required HeroIcons icon,    String? value,    bool isLast = false,    VoidCallback? onTap,  }) {    return SpacedColumn(children: [      Material(          color:          isDark(context) ? PrsmColorsDark.canvasColor : ThemeColors.white,          child: InkWell(              borderRadius: BorderRadius.circular(10.r),              onTap: onTap,              child: Padding(                  padding: EdgeInsets.all(20.w),                  child: SpacedRow(                      mainAxisAlignment: MainAxisAlignment.spaceBetween,                      crossAxisAlignment: CrossAxisAlignment.center,                      horizontalSpace: 20,                      children: [                        SpacedRow(                            crossAxisAlignment: CrossAxisAlignment.center,                            horizontalSpace: 10,                            children: [                              HeroIcon(icon,                                  color: ThemeColors.gray500, size: 54.w),                              SizedText(                                  text: title, textStyle: ThemeTextSemiBold.k14)                            ]),                        SpacedRow(                            crossAxisAlignment: CrossAxisAlignment.center,                            children: [                              SizedText(                                  text: value ?? "",                                  textStyle: ThemeTextLight.k12),                              const Icon(Icons.chevron_right_rounded,                                  color: ThemeColors.gray500)                            ])                      ])))),      if (!isLast) Divider(height: .2.h)    ]);  }  _buildChangePassBottomSheet() async {    DefaultBottomSheet.show(        context: context,        heightFactor: 0.7,        title: "${S(context).changePassword} : ",        child:        StatefulBuilder(builder: (BuildContext ctx, StateSetter stState) {          return SpacedColumn(verticalSpace: 20, children: [            PrsmInputField(              controller: _oldPassCntr,              width: 300.w,              enableShadow: false,              defaultBorderColor: isDark(context)                  ? PrsmColorsLight.primaryColor                  : ThemeColors.coolgray200,              hintText: S(context).oldPassword,              validator: Validator(context).validateField,              isPassword: true,            ),            PrsmInputField(              controller: _newPassCntr,              width: 300.w,              enableShadow: false,              defaultBorderColor: isDark(context)                  ? PrsmColorsLight.primaryColor                  : ThemeColors.coolgray200,              hintText: S(context).newPassword,              validator: Validator(context).validateField,              isPassword: true,            ),            PrsmInputField(              controller: _confirmPassCntr,              width: 300.w,              enableShadow: false,              defaultBorderColor: isDark(context)                  ? PrsmColorsLight.primaryColor                  : ThemeColors.coolgray200,              hintText: S(context).confirmPassword,              validator: Validator(context).validateField,              isPassword: true,            ),            SizedBox(height: 30.h),            PrimaryButton(                buttonText: S(context).save,                buttonSize: ButtonSize.L3,                onPressed: () {}),          ]);        }));  }  _buildChangeDivisionBottomSheet() async {}}