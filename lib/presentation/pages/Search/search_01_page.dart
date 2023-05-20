import 'package:auto_route/auto_route.dart';
import 'package:mehonot_admin/manager/models/Job/job_md.dart';
import 'package:mehonot_admin/presentation/template/template.dart';

import '../../../manager/models/Address/address_md.dart';
import '../../../manager/models/Job/job_dtl_md.dart';
import '../../../manager/models/User/user_profile_md.dart';
import '../../../manager/navigation/router.gr.dart';
import '../../../manager/redux/states/jobs_state.dart';
import '../../../manager/redux/states/user_state.dart';
import '../../widgets/appbar/search_appbar.dart';
import '../../widgets/tag.dart';
import '../Job/job_details_view.dart';

@RoutePage()
class Search01Page extends StatefulWidget {
  Search01Page({Key? key}) : super(key: key);

  @override
  State<Search01Page> createState() => _Search01PageState();
}

class _Search01PageState extends State<Search01Page> {
  List<String> categoryList = [
    "Full Time",
    "Part Time",
    "Freelance",
    "Internship",
    "Temporary",
    "Contract",
    "Commission",
    "Volunteer",
    "Other"
  ];

  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  List<JobModel> searchResult = [];
  bool isJobSavedOrNot = false;
  bool isSavingOrNot = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return SpacedColumn(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrsmSearchAppBar(
                    searchController: _searchController,
                    onRightIconPress: () {
                      logger(appStore.state.jobsState.currentDivision);
                      _searchJob();
                    }),
                categorySuggestions(),
                SizedBox(
                    height: (MediaQuery.of(context).size.height -
                        (ThemeSizeStyle.appBarHeight.h +
                            ThemeSizeStyle.bottomNavHeight.h +
                            200.h)),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: SingleChildScrollView(
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : jobContainers()),
                    ))
              ]);
        });
  }

  Widget jobContainers() {
    List<Widget> list = [];
    for (var i = 0; i < searchResult.length; i++) {
      list.add(PrsmJobContainer(
        onTap: () async {
          bool success = await fetchJobDetailsAndShowModal(
              jobId: searchResult[i].jobId,
              jobDetailsId: searchResult[i].jobDetailsId);
          if (success) {
            showJobModalDetails(
              context: context,
              currentJob: searchResult[i],
            );
          }
        },
        jobModel: searchResult[i],
      ));
    }
    return SpacedColumn(verticalSpace: 18, children: list);
  }

  Widget categorySuggestions() {
    List<Widget> list = [];

    for (var i = 0; i < categoryList.length; i++) {
      list.add(PrsmTag(tagName: categoryList[i]));
    }

    return Padding(
      padding:
          EdgeInsets.only(left: 32.w, right: 32.w, top: 24.h, bottom: 18.h),
      child: SizedBox(
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SpacedRow(horizontalSpace: 12, children: list)),
          )),
    );
  }

  Future _searchJob() async {
    setState(() {
      isLoading = true;
    });

    bool success = await appStore.dispatch(GetJobSearchAction(
      searchText: _searchController.text,
    ));
    if (success) {
      setState(() {
        isLoading = false;
        searchResult = appStore.state.jobsState.searchJobList;
      });
    }
  }

  Future<bool> fetchJobDetailsAndShowModal(
      {required String jobId, required String jobDetailsId}) async {
    bool success = await appStore.dispatch(GetJobDetailsAction(
        division: appStore.state.jobsState.currentDivision,
        jobId: jobId,
        jobDetailsId: jobDetailsId));

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
