import 'package:auto_route/auto_route.dart';import 'package:mehonot_admin/manager/models/User/user_job_relation_md.dart';import 'package:mehonot_admin/manager/models/User/user_profile_md.dart';import 'package:mehonot_admin/presentation/utils/constants.dart';import '../../../manager/models/Job/job_dtl_md.dart';import '../../../manager/models/Job/job_md.dart';import '../../../manager/redux/states/account_state.dart';import '../../../manager/redux/states/jobs_state.dart';import '../../../manager/redux/states/user_state.dart';import '../../template/template.dart';import 'job_details_view.dart';@RoutePage(name: "JobDetailsRouter")class JobDetailsPage extends StatefulWidget {  final JobModel jobModel;  JobDetailModel? jobDetailModel;  Widget? bottomWidget;  JobDetailsPage({    Key? key,    required this.jobModel,    this.jobDetailModel,    this.bottomWidget,  }) : super(key: key);  @override  State<JobDetailsPage> createState() => _JobDetailsPageState();}class _JobDetailsPageState extends State<JobDetailsPage> {  bool isLoading = true;  late JobDetailModel jobDetailModel;  bool isSavingOrNot = false;  bool isJobSavedOrNot = false;  bool isApplyingOrNot = false;  bool isJobAppliedOrNot = false;  String? errorText;  @override  void initState() {    super.initState();    WidgetsBinding.instance.addPostFrameCallback((_) async {      _callJobDetailsApi();      UserJobRelationMd userJobRelationMd =          appStore.state.userState.userJobRelationData;      if (userJobRelationMd.savedJobsIds.isNotEmpty) {        isJobSavedOrNot =            userJobRelationMd.savedJobsIds.contains(widget.jobModel.jobId);      } else {        isJobSavedOrNot = false;      }      if (userJobRelationMd.appliedJobsIds.isNotEmpty) {        isJobAppliedOrNot =            userJobRelationMd.appliedJobsIds.contains(widget.jobModel.jobId);      } else {        isJobAppliedOrNot = false;      }    });  }  @override  Widget build(BuildContext context) {    return isLoading        ? SizedBox(        height: MediaQuery            .of(context)            .size            .height,        child: Center(            child: SizedBox(                height: 50,                width: 50,                child: CircularProgressIndicator(                  color: Theme                      .of(context)                      .colorScheme                      .primary,                ))))        : errorText != null        ? Center(child: SizedText(text: errorText))        : JobDetailsView(        showStatus: widget.jobModel.postedByUserId ==            appStore.state.userState.userProfileData.userId,        jobModel: widget.jobModel,        jobDetailModel: jobDetailModel,        bottomBtn: widget.bottomWidget,        iconList: const [          HeroIcons.xMark,          HeroIcons.chatBubbleOvalLeftEllipsis,          HeroIcons.check        ],        onPress1: () {          // Add rejection functionality with a comment.        },        onPress2: () {          // Add comment functionality to let the user know          // what is needed to update for the job.        },        onPress3: () async {          _onReqAccept(            jobMd: widget.jobModel,          );        });  }  _callJobDetailsApi() async {    if (widget.jobDetailModel != null) {      return;    }    String jobId = widget.jobModel.jobId;    String jobDetailsId = widget.jobModel.jobDetailsId;    Division jobDivision =    convertStringToDivision(widget.jobModel.address.division);    bool success = await appStore.dispatch(GetReqJobDetailsAction(        division: jobDivision, jobId: jobId, jobDetailsId: jobDetailsId));    logger(appStore.state.jobsState.selectedJobDetailModel.toJson(),        hint: "selectedJobDetailModel__title");    if (success) {      setState(() {        jobDetailModel = appStore.state.jobsState.selectedJobDetailModel;        isLoading = false;        errorText = null;      });    } else {      setState(() {        isLoading = false;        errorText = "Something went wrong";      });    }  }  Future _onReqAccept({required JobModel jobMd}) async {    bool success = await appStore.dispatch(GetAcceptReqJobAction(      jobMd: jobMd,    ));    if (success) {      if (mounted) {        context.back();        showDialog(            context: context,            builder: (context) =>                AlertDialog(                  title: const Text("Job Accepted"),                  content: const Text("Job Accepted Successfully"),                  actions: [                    TextButton(                        onPressed: () {                          Navigator.pop(context);                        },                        child: const Text("Ok"))                  ],                ));      }    } else {      if (mounted) {        showDialog(            context: context,            builder: (context) =>                AlertDialog(                  title: const Text("Job Accepted"),                  content: const Text("Job Accepted Failed"),                  actions: [                    TextButton(                        onPressed: () {                          Navigator.pop(context);                        },                        child: const Text("Ok"))                  ],                ));      }    }  }}