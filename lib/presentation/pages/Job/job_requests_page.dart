import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:mehonot_admin/manager/models/Address/address_md.dart';
import 'package:mehonot_admin/manager/models/Job/job_dtl_md.dart';
import 'package:mehonot_admin/manager/models/Job/job_md.dart';
import '../../../manager/navigation/router.gr.dart';
import '../../../manager/redux/states/ads_state.dart';
import '../../../manager/redux/states/jobs_state.dart';
import '../../template/template.dart';

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
                      children: [_buildJobRequestList(state)])));
        });
  }

  Widget _buildJobRequestList(AppState state) {
    List<Widget> list = [];
    List<JobModel> allReqJobs = state.jobsState.allRequestedJobs;
    list.add(Align(
        alignment: Alignment.topLeft,
        child: SizedText(
            text: "Job req : ${state.jobsState.allRequestedJobs.length - 1}",
            textStyle: ThemeTextRegular.k12)));
    for (int i = 0; i < allReqJobs.length; i++) {
      if (!allReqJobs[i].status.contains("test")) {
        list.add(PrsmJobContainer(
          jobModel: JobModel(
            jobId: allReqJobs[i].jobId,
            jobDetailsId: allReqJobs[i].jobDetailsId,
            postedByUserId: allReqJobs[i].postedByUserId,
            address: AddressModel(
              division: allReqJobs[i].address.division,
              area: allReqJobs[i].address.area,
              district: allReqJobs[i].address.district,
              city: allReqJobs[i].address.city,
            ),
            title: allReqJobs[i].title,
            companyName: allReqJobs[i].companyName,
            type: allReqJobs[i].type,
            tags: allReqJobs[i].tags,
            category: allReqJobs[i].category,
            companyLogo: allReqJobs[i].companyLogo,
            workFinishTime: allReqJobs[i].workFinishTime,
            workStartTime: allReqJobs[i].workStartTime,
            status: allReqJobs[i].status,
            timestamp: allReqJobs[i].timestamp,
            wageAmount: allReqJobs[i].wageAmount,
          ),
          onReqAccept: () {
            _onReqAccept(
                jobMd: JobModel(
              jobId: allReqJobs[i].jobId,
              jobDetailsId: allReqJobs[i].jobDetailsId,
              postedByUserId: allReqJobs[i].postedByUserId,
              category: allReqJobs[i].category,
              tags: allReqJobs[i].tags,
              companyLogo: allReqJobs[i].companyLogo,
              address: AddressModel(
                division: allReqJobs[i].address.division,
                area: allReqJobs[i].address.area,
                district: allReqJobs[i].address.district,
                city: allReqJobs[i].address.city,
              ),
              title: allReqJobs[i].title,
              companyName: allReqJobs[i].companyName,
              type: allReqJobs[i].type,
              workFinishTime: allReqJobs[i].workFinishTime,
              workStartTime: allReqJobs[i].workStartTime,
              status: allReqJobs[i].status,
              wageAmount: allReqJobs[i].wageAmount,
              timestamp: allReqJobs[i].timestamp,
            ));
          },
          onReqDecline: () {
            popupForRejectJob();
          },
          onTap: () {
            context.pushRoute(JobDetailsRouter(
              bottomWidget: PrimaryButton(
                buttonText: "Move to Job ADS",
                onPressed: onMoveToJobAds,
              ),
              jobModel: JobModel(
                jobId: allReqJobs[i].jobId,
                jobDetailsId: allReqJobs[i].jobDetailsId,
                postedByUserId: allReqJobs[i].postedByUserId,
                address: AddressModel(
                  division: allReqJobs[i].address.division,
                  area: allReqJobs[i].address.area,
                  district: allReqJobs[i].address.district,
                  city: allReqJobs[i].address.city,
                ),
                title: allReqJobs[i].title,
                companyName: allReqJobs[i].companyName,
                type: allReqJobs[i].type,
                workFinishTime: allReqJobs[i].workStartTime,
                workStartTime: allReqJobs[i].workStartTime,
                status: allReqJobs[i].status,
                timestamp: allReqJobs[i].timestamp,
                wageAmount: allReqJobs[i].wageAmount,
                tags: allReqJobs[i].tags,
                category: allReqJobs[i].tags,
                companyLogo: allReqJobs[i].companyLogo,
              ),
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
    ));
  }

  popupForRejectJob() {
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
                        desc: "reject the job", bgColor: ThemeColors.red300);
                  },
                  child: Text("Reject",
                      style: ThemeTextMedium.k14
                          .copyWith(color: ThemeColors.red500))),
              TextButton(
                  onPressed: () {
                    sureToDoPopup(
                        desc: "ask for modification",
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
