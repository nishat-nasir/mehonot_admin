import 'package:auto_route/auto_route.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mehonot_admin/manager/models/User/user_job_relation_md.dart';
import 'package:mehonot_admin/presentation/template/template.dart';

import '../../../manager/models/Address/address_md.dart';
import '../../../manager/models/Job/job_dtl_md.dart';
import '../../../manager/models/Job/job_md.dart';
import '../../../manager/models/User/user_profile_md.dart';
import '../../../manager/navigation/router.gr.dart';
import '../../../manager/redux/states/jobs_state.dart';
import '../../../manager/redux/states/user_state.dart';
import '../../utils/constants.dart';
import '../Job/job_details_view.dart';

@RoutePage()
class Saved01Page extends StatefulWidget {
  Saved01Page({Key? key}) : super(key: key);

  @override
  State<Saved01Page> createState() => _Saved01PageState();
}

class _Saved01PageState extends State<Saved01Page> {
  List<JobModel> listOfSavedJobsData = [];

  bool isSavingOrNot = false;
  bool isJobSavedOrNot = false;

  @override
  void initState() {
    super.initState();
    // _fetchAllSavedJobs(listOfSavedJobsId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listOfSavedJobsData = appStore.state.userState.mySavedJobsJobData;
    logger(
        'listOfSavedJobsData111: ${appStore.state.userState.mySavedJobsJobData}');
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (_) async {
          setState(() {
            listOfSavedJobsData = appStore.state.userState.mySavedJobsJobData;
          });
        },
        builder: (_, state) {
          return appStore.state.userState.mySavedJobsJobData.isEmpty
              ? Center(
                  child: SizedText(
                  text: S(context).noSavedJob,
                ))
              : SingleChildScrollView(child: jobContainers());
        });
  }

  Widget jobContainers() {
    List<Widget> list = [];
    for (var i = 0; i < listOfSavedJobsData.length; i++) {
      list.add(Slidable(
        key: ValueKey(i),
        endActionPane:
            ActionPane(extentRatio: 0.25, motion: ScrollMotion(), children: [
          SizedBox(width: 25.w),
          SlidableAction(
              borderRadius: BorderRadius.circular(32.r),
              onPressed: (BuildContext context) async {
                bool success = await appStore.dispatch(GetUpdateSavedJobsAction(
                  jobData: listOfSavedJobsData[i],
                ));
                if (success) {
                  setState(() {
                    if (i < listOfSavedJobsData.length) {
                      listOfSavedJobsData.removeAt(i);
                    }
                  });
                }
              },
              backgroundColor: ThemeColors.red500,
              foregroundColor: Colors.white,
              icon: Icons.delete_outline_rounded,
              autoClose: true,
              padding: EdgeInsets.zero),
          SizedBox(width: 25.w)
        ]),
        child: PrsmJobContainer(
            onTap: () async {
              bool success = await fetchJobDetailsAndShowModal(
                  division: convertStringToDivision(
                      listOfSavedJobsData[i].address.division),
                  jobId: listOfSavedJobsData[i].jobId,
                  jobDetailsId: listOfSavedJobsData[i].jobDetailsId);
              if (success) {
                showJobModalDetails(
                    context: context, currentJob: listOfSavedJobsData[i]);
              }
            },
            jobModel: listOfSavedJobsData[i]),
      ));
    }

    return SpacedColumn(verticalSpace: 18, children: list);
  }

  Future<bool> fetchJobDetailsAndShowModal(
      {required String jobId,
      required String jobDetailsId,
      required Division division}) async {
    bool success = await appStore.dispatch(GetJobDetailsAction(
        division: division, jobId: jobId, jobDetailsId: jobDetailsId));
    logger(appStore.state.jobsState.selectedJobDetailModel.toJson(),
        hint: "selectedJobDetailModel__title");
    return success;
  }

  showJobModalDetails({
    required BuildContext context,
    required JobModel currentJob,
  }) async {
    JobDetailModel currentJobDetails =
        appStore.state.jobsState.selectedJobDetailModel;

    UserJobRelationMd userJobRelationMd =
        appStore.state.userState.userJobRelationData;
    if (userJobRelationMd.savedJobsIds.isNotEmpty) {
      setState(() {
        isJobSavedOrNot =
            userJobRelationMd.savedJobsIds.contains(currentJob.jobId);
      });
    } else {
      setState(() {
        isJobSavedOrNot = false;
      });
    }

    return await showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.90,
              child: SpacedColumn(verticalSpace: 24, children: [
                const SizedBox(),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: HeroIcon(
                              HeroIcons.xMark,
                              size: 32,
                            )))),
                StatefulBuilder(
                    builder: (BuildContext ctx, StateSetter stState) {
                  return JobDetailsView(
                      iconList: [
                        HeroIcons.paperAirplane,
                        HeroIcons.arrowTopRightOnSquare,
                        isJobSavedOrNot
                            ? HeroIcons.bookmarkSquare
                            : HeroIcons.bookmark
                      ],
                      onPress1: () {
                        context
                            .pushRoute(JobDetailsRouter(jobModel: currentJob));
                      },
                      onPress2: () {
                        Navigator.pop(context);
                        context
                            .pushRoute(JobDetailsRouter(jobModel: currentJob));
                      },
                      onPress3: () async {
                        setState(() {
                          isSavingOrNot = true;
                        });
                        bool success =
                            await appStore.dispatch(GetUpdateSavedJobsAction(
                          jobData: currentJob,
                        ));
                        if (success) {
                          stState(() {
                            isJobSavedOrNot = !isJobSavedOrNot;
                          });
                        }

                        setState(() {
                          // if (success) {
                          //   isJobSavedOrNot = !isJobSavedOrNot;
                          // }
                          isSavingOrNot = false;
                        });
                        if (!isJobSavedOrNot) {
                          context.popRoute();
                        }
                      },
                      jobModel: JobModel(
                        title: currentJob.title,
                        images: currentJob.images,
                        companyLogo: currentJob.companyLogo,
                        address: AddressModel(
                          area: currentJob.address.area,
                          division: currentJob.address.division,
                          city: currentJob.address.city,
                          district: currentJob.address.district,
                        ),
                        postedByUserId: currentJob.postedByUserId,
                        type: currentJob.type,
                        workStartTime: currentJob.workStartTime,
                        // currentJob.workStartTime,
                        workFinishTime: currentJob.workFinishTime,
                        //currentJob.workFinishTime,
                        companyName: currentJob.companyName,
                        jobId: currentJob.jobId,
                        jobDetailsId: currentJob.jobDetailsId,
                        status: currentJob.status,
                        wageAmount: currentJob.wageAmount,
                        timestamp: currentJob.timestamp,
                      ),
                      jobDetailModel: JobDetailModel(
                        description: currentJobDetails.description,
                        jobId: currentJobDetails.jobId,
                        jobDetailsId: currentJobDetails.jobDetailsId,
                        phone: currentJobDetails.phone,
                        email: currentJobDetails.email,
                        website: currentJobDetails.website,
                        workCondition: currentJobDetails.workCondition,
                        ownerName: currentJobDetails.ownerName,
                        recruitCondition: currentJobDetails.recruitCondition,
                        category: currentJobDetails.category,
                      ));
                }),
              ]));
        });
  }

  Future _fetchAllSavedJobs(List<String> jobListToFetch) async {
    bool success = await appStore.dispatch(GetAllMySavedJobsAction());
    if (success) {
      setState(() {
        listOfSavedJobsData = listOfSavedJobsData;
      });
      logger('listOfSavedJobsData2: $listOfSavedJobsData');
    }
  }
}
