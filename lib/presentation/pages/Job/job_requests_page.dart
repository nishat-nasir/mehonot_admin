import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:mehonot_admin/manager/models/Address/address_md.dart';
import 'package:mehonot_admin/manager/models/Job/job_dtl_md.dart';
import 'package:mehonot_admin/manager/models/Job/job_md.dart';
import 'package:mehonot_admin/presentation/utils/constants.dart';
import '../../../manager/navigation/router.gr.dart';
import '../../../manager/redux/states/ads_state.dart';
import '../../../manager/redux/states/jobs_state.dart';
import '../../template/template.dart';
import '../../widgets/status_refresh/StatusAndRefreshWidget.dart';

@RoutePage()
class JobRequestsPage extends StatefulWidget {
  const JobRequestsPage({Key? key}) : super(key: key);

  @override
  State<JobRequestsPage> createState() => _JobRequestsPageState();
}

class _JobRequestsPageState extends State<JobRequestsPage> {
  JobModel? currentJob;
  JobDetailModel? currentJobDetail;
  final TextEditingController _reasonController = TextEditingController();
  List<JobModel> allReqJobs = [];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Padding(
              padding: EdgeInsets.all(20.w),
              child: SingleChildScrollView(
                  child: SpacedColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    StatusAndRefreshWidget(
                      onTapRefresh: () async {
                        await appStore.dispatch(GetReqJobsAction());
                        setState(() {});
                      },
                      statusAndDetails:
                          "Job req : ${state.jobsState.allRequestedJobs.length}",
                    ),
                    _buildJobRequestList(state)
                  ])));
        });
  }

  Widget _buildJobRequestList(AppState state) {
    List<Widget> list = [];
    allReqJobs = state.jobsState.allRequestedJobs;
    if (allReqJobs.isEmpty) {
      return Container();
    }
    for (int i = 0; i < allReqJobs.length; i++) {
      if (allReqJobs[i].status.name != JobStatus.test.name) {
        JobModel job = allReqJobs[i];

        list.add(PrsmJobContainer(
          jobModel: job,
          showStatus: true,
          onReqAccept: () {
            _onReqAccept(jobMd: job);
          },
          onReqDecline: () {
            popupForRejectJob(job: job);
          },
          onTap: () {
            context.pushRoute(JobDetailsRouter(
              jobModel: job,
            ));
          },
        ));
      }
    }
    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.center,
      verticalSpace: 20,
      children: list,
    );
  }

  Future _onReqAccept({required JobModel jobMd}) async {
    bool success = await appStore.dispatch(GetAcceptReqJobAction(
      jobMd: jobMd,
    ));
    if (success) {
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Job Accepted"),
                  content: const Text("Job Accepted Successfully"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Ok"))
                  ],
                ));
      }
    } else {
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Job Accepted"),
                  content: const Text("Job Accepted Failed"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Ok"))
                  ],
                ));
      }
    }
  }

  Future onMoveToJobAds() async {
    if (currentJob == null) return;
    await appStore.dispatch(GetCreateJobAdsAction(
      jobId: currentJob!.jobId,
      division: convertStringToDivision(currentJob!.address.division),
      context: context,
    ));
  }

  popupForRejectJob({required JobModel job}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: SpacedRow(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Reject/Modification",
                      style: ThemeTextMedium.k16
                          .copyWith(color: ThemeColors.red700)),
                  InkWell(
                    child: Icon(Icons.close,
                        color: ThemeColors.lime600, size: 100.h),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ]),
            content: SizedBox(
              height: 800.h,
              child: SpacedColumn(children: [
                PrsmInputField(
                  hintText: "Reason / Feedback / Comment",
                  controller: _reasonController,
                  maxLines: 11,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a reason";
                    }
                    return null;
                  },
                ),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    sureToDoPopup(
                        desc: "reject the job",
                        bgColor: ThemeColors.red300,
                        onYes: () async {
                          bool success = await appStore.dispatch(
                              GetRejectOrSupplementReqJobAction(
                                  jobMd: job,
                                  isRejction: true,
                                  rejectReason: _reasonController.text));
                          if (success && context.mounted) {
                            Navigator.pop(context);
                          }
                        });
                  },
                  child: Text("Reject",
                      style: ThemeTextMedium.k14
                          .copyWith(color: ThemeColors.red500))),
              TextButton(
                  onPressed: () {
                    sureToDoPopup(
                        desc: "ask for modification",
                        onYes: () async {
                          await appStore.dispatch(
                              GetRejectOrSupplementReqJobAction(
                                  jobMd: job,
                                  isNeedsupplement: true,
                                  suppplementDesc: _reasonController.text));
                        },
                        bgColor: ThemeColors.yellow300);
                  },
                  child: Text("Modification",
                      style: ThemeTextBold.k16
                          .copyWith(color: ThemeColors.orange600)))
            ],
          );
        });
  }

  sureToDoPopup(
      {VoidCallback? onYes,
      VoidCallback? onNo,
      String? desc = "",
      Color? bgColor}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: bgColor,
            title: const Text("Are you sure?"),
            content: Text("Are you sure you want to $desc?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (onNo != null) onNo();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (onYes != null) onYes();
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }
}
