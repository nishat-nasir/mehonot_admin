import 'package:auto_route/auto_route.dart';
import 'package:mehonot_admin/manager/navigation/router.gr.dart';
import 'package:mehonot_admin/presentation/template/template.dart';
import '../../../manager/hive_client.dart';
import '../../../manager/models/Address/address_md.dart';
import '../../../manager/models/Job/job_dtl_md.dart';
import '../../../manager/models/Job/job_md.dart';
import '../../../manager/models/User/user_profile_md.dart';
import '../../../manager/redux/states/jobs_state.dart';
import '../../../manager/redux/states/user_state.dart';
import '../../bottomsheets/location_bottom_sheet.dart';
import '../../utils/common/helpers.dart';
import '../../utils/constants.dart';
import '../Job/job_details_view.dart';

@RoutePage()
class Home01Page extends StatefulWidget {
  const Home01Page({Key? key}) : super(key: key);

  @override
  State<Home01Page> createState() => _Home01PageState();
}

class _Home01PageState extends State<Home01Page> {
  late String selectedLocation;
  Division division = Division.Dhaka;
  List<JobModel> currentLocJobList = [];

  bool isSavingOrNot = false;
  bool isJobSavedOrNot = false;

  // bool alreadyFetched = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedLocation = HiveClient.getDivision() ??
          appStore.state.userState.userProfileData.address.division;
      division = convertStringToDivision(selectedLocation);
      appStore.dispatch(GetLocationAction(divisionString: selectedLocation));
    });
    fetchJobsForDivision();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (_) async {
          logger("CHECK INIT STAT IN HOME PAGE1");
          // fetchJobsForDivision();
        },
        builder: (_, state) {
          logger("CHECK INIT STAT IN HOME PAGE2");

          return SingleChildScrollView(
              child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: SpacedColumn(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SponsorBannerContainer(),
                            SizedBox(height: 40.h),
                            PrsmLocationButton(
                                onTap: () => onShowLocationBottomSheet(context),
                                text: selectedLocation),
                            SizedBox(height: 30.h),
                            const SponsorContainer(),
                            SizedBox(height: 30.h),
                            jobContainers(context, state)
                          ]))));
        });
  }

  Widget jobContainers(BuildContext context, AppState state) {
    List<Widget> list = [];
    logger(currentLocJobList.length, hint: "currentLocJobList__length");
    for (var i = 0; i < currentLocJobList.length; i++) {
      list.add(PrsmJobContainer(
          jobModel: JobModel(
            title: currentLocJobList[i].title,
            address: AddressModel(
              area: currentLocJobList[i].address.area,
              division: currentLocJobList[i].address.division,
              city: currentLocJobList[i].address.city,
            ),
            type: currentLocJobList[i].type,
            workStartTime: currentLocJobList[i].workStartTime,
            workFinishTime: currentLocJobList[i].workFinishTime,
            jobId: currentLocJobList[i].jobId,
            jobDetailsId: currentLocJobList[i].jobDetailsId,
            companyName: currentLocJobList[i].companyName,
            postedByUserId: currentLocJobList[i].postedByUserId,
          ),
          onTap: () async {
            bool success = await fetchJobDetailsAndShowModal(
                jobId: currentLocJobList[i].jobId,
                jobDetailsId: currentLocJobList[i].jobDetailsId);
            if (success) {
              showJobModalDetails(
                context: context,
                currentJob: currentLocJobList[i],
              );
            }
          },
          onShowFullItem: () {
            context.pushRoute(JobDetailsRouter(jobModel: currentLocJobList[i]));
          }));
    }

    return SpacedColumn(verticalSpace: 18, children: list);
  }

  onShowLocationBottomSheet(BuildContext context) async {
    await showLocationBottomModal(context);
  }

  Future showLocationBottomModal(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.65,
              child: SingleChildScrollView(
                  child: LocationBottomSheet(
                      onTap: (location) {
                        setState(() => selectedLocation = location);
                        division = convertStringToDivision(selectedLocation);
                        appStore.dispatch(GetLocationAction(
                            divisionString: selectedLocation));
                        fetchJobsForDivision();
                        Navigator.pop(context);
                      },
                      selectedLocation: selectedLocation)));
        });
  }

  fetchJobsForDivision() async {
    bool success = await appStore.dispatch(GetJobsAction(division: division));

    if (success) {
      // first empty all jobs
      currentLocJobList.clear();
      // alreadyFetched = true;
      List<JobModel> jobs = appStore.state.jobsState.currentLocationJobsList;
      logger(jobs.length, hint: "jobs____length");
      for (int i = 0; i < jobs.length; i++) {
        setState(() {
          currentLocJobList.add(jobs[i]);
        });
      }
    }
    // if (alreadyFetched) {
    //   setState(() {
    //     currentLocJobList.clear();
    //     List<JobModel> jobs = appStore.state.jobsState.currentLocationJobsList;
    //     for (int i = 0; i < jobs.length; i++) {
    //       setState(() {
    //         currentLocJobList.add(jobs[i]);
    //       });
    //     }
    //   });
    // }
  }

  Future<bool> fetchJobDetailsAndShowModal(
      {required String jobId, required String jobDetailsId}) async {
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

    UserProfileModel userProfileModel =
        appStore.state.userState.userProfileData;
    if (userProfileModel.savedJobsIds != null &&
        userProfileModel.savedJobsIds!.isNotEmpty) {
      setState(() {
        isJobSavedOrNot =
            userProfileModel.savedJobsIds!.contains(currentJob.jobId);
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
                      },
                      jobModel: JobModel(
                        title: currentJob.title,
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
                      ),
                      jobDetailModel: JobDetailModel(
                        description: currentJobDetails.description,
                        jobId: currentJobDetails.jobId,
                        jobDetailsId: currentJobDetails.jobDetailsId,
                        createdAt: "",
                        //currentJobDetails.createdAt,
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
}
