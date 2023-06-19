import 'package:auto_route/auto_route.dart';
import '../../../../manager/models/Address/address_md.dart';
import '../../../../manager/models/Job/job_dtl_md.dart';
import '../../../../manager/models/Job/job_md.dart';
import '../../../../manager/models/User/user_job_relation_md.dart';
import '../../../../manager/navigation/router.gr.dart';
import '../../../../manager/redux/states/account_state.dart';
import '../../../../manager/redux/states/jobs_state.dart';
import '../../../../manager/redux/states/user_state.dart';
import '../../../template/template.dart';
import '../../../utils/common/helper_function.dart';
import '../../../utils/constants.dart';
import '../job_details_view.dart';

class JobDetailsBottomModalPopup extends StatefulWidget {
  final JobModel jobModel;
  final bool? showFromMyPostedJobsList;
  final bool? showFromMyAppliedJobsList;
  final Widget? bottomBtnWidget;
  final Function(JobDetailModel)? onTapJobContainer;

  const JobDetailsBottomModalPopup(
      {required this.jobModel,
      this.showFromMyPostedJobsList,
      this.showFromMyAppliedJobsList,
      this.bottomBtnWidget,
      this.onTapJobContainer,
      super.key});

  @override
  State<JobDetailsBottomModalPopup> createState() =>
      _JobDetailsBottomModalPopupState();
}

class _JobDetailsBottomModalPopupState
    extends State<JobDetailsBottomModalPopup> {
  final double _opacity = 0.0;
  bool isSavingOrNot = false;
  bool isJobSavedOrNot = false;
  bool isApplyingOrNot = false;
  bool isJobAppliedOrNot = false;
  bool alreadyTappedJob = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          0.0,
          _opacity * 100.0,
          0.0,
        ),
        child: Padding(
            padding: EdgeInsets.only(bottom: 24.h), child: showJobContainer()));
  }

  Widget showJobContainer() {
    JobModel job = widget.jobModel;
    if (widget.showFromMyPostedJobsList == true) {
      return PrsmJobContainer(
          showStatus: true,
          onShowFullItem: () {
            context.pushRoute(JobDetailsRouter(
                jobModel: job, bottomWidget: widget.bottomBtnWidget));
          },
          onEditItem: () async {
            bool success = false;
            JobDetailModel? jobDtlMd;

            if (job.status != JobStatus.published.name) {
              logger("GetReqJobDetailsAction________");
              success = await appStore.dispatch(GetReqJobDetailsAction(
                jobId: job.jobId,
                jobDetailsId: job.jobDetailsId,
              ));
            } else {
              logger("GetReqJobDetailsAction________1");
              jobDtlMd = await appStore.dispatch(GetJobDetailsAction(
                jobId: job.jobId,
                jobDetailsId: job.jobDetailsId,
                division: convertStringToDivision(job.address.division),
              ));
            }
            if (success == true || jobDtlMd != null) {
              if (context.mounted) {
                context.pushRoute(CeoJobEditRouter(
                  jobDetailModel:
                      appStore.state.jobsState.selectedJobDetailModel,
                  jobModel: job,
                ));
              }
            }
          },
          onTap: () async {
            bool? success;
            JobDetailModel? jobDetailModel;
            if (job.status != JobStatus.published.name) {
              success = await appStore.dispatch(GetReqJobDetailsAction(
                jobId: job.jobId,
                jobDetailsId: job.jobDetailsId,
              ));
            } else {
              jobDetailModel = await appStore.dispatch(GetJobDetailsAction(
                jobId: job.jobId,
                jobDetailsId: job.jobDetailsId,
                division: convertStringToDivision(job.address.division),
              ));
            }
            if (jobDetailModel != null || success == true) {
              if (!mounted) return;
              await showJobModalDetails(context: context, currentJob: job);
            }
          },
          jobModel: job);
    }
    if (widget.showFromMyAppliedJobsList == true) {
      List<JobModel> listOfMyJobApplicationData =
          appStore.state.accountState.myApplicationJobsData;
      return PrsmJobContainer(
          onShowFullItem: () {
            context.pushRoute(JobDetailsRouter(
                jobModel: job,
                bottomWidget: SizedBox(
                    width: MediaQuery.of(context).size.width - 200.w,
                    child: SpacedColumn(verticalSpace: 20, children: [
                      PrimaryButton(
                          buttonText: "",
                          icon: HeroIcons.phoneArrowUpRight,
                          onPressed: () {}),
                      PrimaryButton(
                          buttonText: S(context).withdrawApplication,
                          buttonType: ButtonType.Ghost,
                          linkTypeBtnColor: ThemeColors.red500,
                          icon: HeroIcons.xCircle,
                          onPressed: () async {
                            bool success = await appStore.dispatch(
                                GetRemoveJobApplicationAction(jobModel: job));
                            if (success) {
                              // setState(() {
                              //   if (int i=0;i < listOfMyJobApplicationData.length;i++) {
                              //     listOfMyJobApplicationData.removeAt(i);
                              //   }
                              // });

                              setState(() {
                                listOfMyJobApplicationData.removeWhere(
                                    (element) => element.jobId == job.jobId);
                              });

                              if (context.mounted) {
                                context.popRoute();
                              }
                            }
                          })
                    ]))));
          },
          onTap: () async {
            bool success = false;
            JobDetailModel? jobDetailModel;
            if (job.status != JobStatus.published.name) {
              success = await appStore.dispatch(GetReqJobDetailsAction(
                jobId: job.jobId,
                jobDetailsId: job.jobDetailsId,
              ));
            } else {
              jobDetailModel = await appStore.dispatch(GetJobDetailsAction(
                jobId: job.jobId,
                jobDetailsId: job.jobDetailsId,
                division: convertStringToDivision(job.address.division),
              ));
            }
            if (success || jobDetailModel != null) {
              if (!mounted) return;
              await showJobModalDetails(context: context, currentJob: job);
            }
          },
          jobModel: job);
    }
    return PrsmJobContainer(
      jobModel: JobModel(
        title: job.title,
        category: job.category,
        tags: job.tags,
        address: AddressModel(
          area: job.address.area,
          division: job.address.division,
          city: job.address.city,
        ),
        type: job.type,
        workStartTime: job.workStartTime,
        workFinishTime: job.workFinishTime,
        jobId: job.jobId,
        jobDetailsId: job.jobDetailsId,
        companyName: job.companyName,
        postedByUserId: job.postedByUserId,
        status: job.status,
        timestamp: job.timestamp,
        wageAmount: job.wageAmount,
      ),
      onTap: () async {
        if (alreadyTappedJob) return;
        bool success = await fetchJobDetailsAndShowModal(
          jobId: job.jobId,
          jobDetailsId: job.jobDetailsId,
          division: convertStringToDivision(job.address.division),
        );
        if (success && context.mounted) {
          showJobModalDetails(
            context: context,
            currentJob: job,
          );
        }
      },
      onShowFullItem: () {
        context.pushRoute(JobDetailsRouter(jobModel: job));
      },
    );
  }

  showJobModalDetails({
    required BuildContext context,
    required JobModel currentJob,
  }) async {
    // checkConnectivity(context: context);
    JobDetailModel currentJobDetails =
        appStore.state.jobsState.selectedJobDetailModel;
    UserJobRelationMd userJobRelationMd =
        appStore.state.userState.userJobRelationData;
    if (userJobRelationMd.savedJobsIds.isNotEmpty) {
      setState(() {
        isJobSavedOrNot =
            userJobRelationMd.savedJobsIds.contains(currentJob.jobId);
        isJobAppliedOrNot =
            userJobRelationMd.appliedJobsIds.contains(currentJob.jobId);
      });
    } else {
      setState(() {
        isJobSavedOrNot = false;
        isJobAppliedOrNot = false;
      });
    }
    return await showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        isDismissible: false,
        backgroundColor: isDark(context)
            ? PrsmColorsDark.canvasColor
            : PrsmColorsLight.canvasColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.92,
              child: SpacedColumn(verticalSpace: 24, children: [
                const SizedBox(),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            alreadyTappedJob = false;
                          });
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
                      bottomBtn: widget.bottomBtnWidget,
                      iconList: !showDefaultIcons()
                          ? null
                          : [
                              currentJob.postedByUserId ==
                                      appStore.state.userState.userData.userId
                                  ? HeroIcons.users
                                  : isJobAppliedOrNot
                                      ? HeroIcons.checkCircle
                                      : HeroIcons.paperAirplane,
                              HeroIcons.arrowTopRightOnSquare,
                              isJobSavedOrNot
                                  ? HeroIcons.bookmarkSquare
                                  : HeroIcons.bookmark
                            ],
                      onPress1: !showDefaultIcons()
                          ? null
                          : () async {
                              setState(() {
                                alreadyTappedJob = false;
                              });
                              if (currentJob.postedByUserId ==
                                  appStore.state.userState.userData.userId) {
                                Navigator.pop(context);
                                // context.pushRoute(ApplicantsRouter(children: [
                                //   AccountJobApplicantsRouter(
                                //     jobApplicantsIds:
                                //         currentJobDetails.appliedBy ?? [],
                                //   )
                                // ]));
                              } else if (isJobAppliedOrNot) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(S(context).alreadyApplied),
                                        content: Text(S(context)
                                            .alreadyAppliedDescription),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(S(context).okay)),
                                        ],
                                      );
                                    });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(S(context).areYouSure),
                                        content: Text(
                                            S(context).areYouSureToApplyJob),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(S(context).cancel)),
                                          TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                setState(() {
                                                  isApplyingOrNot = true;
                                                });
                                                bool success =
                                                    await appStore.dispatch(
                                                        GetJobApplicationAction(
                                                  jobModel: currentJob,
                                                ));
                                                if (success) {
                                                  stState(() {
                                                    isJobAppliedOrNot =
                                                        !isJobAppliedOrNot;
                                                    isApplyingOrNot = false;
                                                  });
                                                }
                                              },
                                              child: const Text("Apply"))
                                        ],
                                      );
                                    });
                              }
                            },
                      onPress2: !showDefaultIcons()
                          ? null
                          : () {
                              setState(() {
                                alreadyTappedJob = false;
                              });
                              Navigator.pop(context);
                              context.pushRoute(
                                  JobDetailsRouter(jobModel: currentJob));
                            },
                      onPress3: !showDefaultIcons()
                          ? null
                          : () async {
                              setState(() {
                                isSavingOrNot = true;
                                alreadyTappedJob = false;
                              });
                              bool success = await appStore
                                  .dispatch(GetUpdateSavedJobsAction(
                                jobData: currentJob,
                              ));
                              if (success) {
                                stState(() {
                                  isJobSavedOrNot = !isJobSavedOrNot;
                                  isSavingOrNot = false;
                                });
                              }
                            },
                      jobModel: JobModel(
                        title: currentJob.title,
                        tags: currentJob.tags,
                        category: currentJob.category,
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
                        timestamp: currentJob.timestamp,
                        wageAmount: currentJob.wageAmount,
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
                        images: currentJobDetails.images,
                        moreDetails: currentJobDetails.moreDetails,
                      ));
                }),
              ]));
        });
  }

  bool showDefaultIcons() {
    if (widget.showFromMyPostedJobsList == true) {
      return false;
    }
    if (widget.showFromMyAppliedJobsList == true) {
      return false;
    }
    return true;
  }

  Future<bool> fetchJobDetailsAndShowModal(
      {required String jobId,
      required String jobDetailsId,
      required Division division}) async {
    JobDetailModel? jobDetailModel = await appStore.dispatch(
        GetJobDetailsAction(
            division: division, jobId: jobId, jobDetailsId: jobDetailsId));
    if (jobDetailModel != null) {
      widget.onTapJobContainer?.call(jobDetailModel);
      return true;
    }
    return false;
  }
}
