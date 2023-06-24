import 'package:auto_route/auto_route.dart';
import 'package:mehonot_admin/manager/models/Job/job_md.dart';
import 'package:mehonot_admin/manager/navigation/router.gr.dart';
import 'package:mehonot_admin/manager/redux/states/jobs_state.dart';
import '../../../template/template.dart';
import '../../../utils/constants.dart';
import '../../../widgets/tag.dart';
import 'ads_helper_functions.dart';

@RoutePage(name: "JobAdCreateRoute")
class JobAdCreatePage extends StatefulWidget {
  const JobAdCreatePage({Key? key}) : super(key: key);

  @override
  State<JobAdCreatePage> createState() => _JobAdCreatePageState();
}

class _JobAdCreatePageState extends State<JobAdCreatePage> {
  Division selectedDivision = Division.Dhaka;
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  bool isLoadingMore = false;
  List<JobModel> currentLocJobList = [];
  String screenText = "";
  bool showSeeMoreBtn = false;
  List<String> searchCategory = [];

  @override
  Widget build(BuildContext context) {
    logger('JobAdCreatePage ${currentLocJobList.length}', hint: '----------');
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return SizedBox(
              height: MediaQuery.of(context).size.height - 300,
              child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: SingleChildScrollView(
                      child: SpacedColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        _buildTopSec(state),
                        categorySuggestions(),
                        _buildJobList(),
                        if (showSeeMoreBtn) _buildSeeMoreButton(),
                      ]))));
        });
  }

  Widget _buildTopSec(AppState state) {
    return SpacedRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 400.w,
              child: PrsmDropdown(
                  listValues:
                      Constants.jobDivisionList.map((e) => e.name).toList(),
                  value: selectedDivision.name,
                  onChanged: (value) {
                    setState(() {
                      selectedDivision = Constants.jobDivisionList
                          .firstWhere((element) => element.name == value);
                    });
                  })),
          SizedBox(
              width: 600.w,
              height: 120.h,
              child: PrsmInputField(
                  leftIcon: HeroIcons.magnifyingGlass,
                  controller: _searchController,
                  onFieldSubmitted: (value) {
                    _searchJob();
                  }))
        ]);
  }

  Widget _buildJobList() {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : currentLocJobList.isEmpty
            ? SizedBox(
                height: 800.h,
                child: Center(
                    child: SizedText(
                  width: 500.w,
                  height: 200.h,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  text: screenText,
                  textStyle: ThemeTextRegular.k14,
                )))
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: currentLocJobList.length,
                itemBuilder: (context, index) {
                  return SpacedColumn(children: [
                    PrsmJobContainer(
                      jobModel: currentLocJobList.elementAt(index),
                      onTap: () async {
                        context.pushRoute(JobDetailsRouter(
                            bottomWidget: PrimaryButton(
                              onPressed: () async {
                                await createOrRmvJobAdFunc(
                                    context: context,
                                    job: currentLocJobList.elementAt(index));
                              },
                              buttonText: await getTheBtnText(
                                  job: currentLocJobList.elementAt(index)),
                              buttonType: ButtonType.Ghost,
                            ),
                            jobModel: currentLocJobList.elementAt(index)));
                      },
                    ),
                    SizedBox(height: 20.h),
                  ]);
                },
              );
  }

  Widget _buildSeeMoreButton() {
    return isLoadingMore
        ? const Center(child: CircularProgressIndicator())
        : Center(
            child: PrimaryButton(
              buttonText: "See More",
              buttonType: ButtonType.Link,
              buttonSize: ButtonSize.L,
              onPressed: () {
                fetchMoreData();
              },
            ),
          );
  }

  Widget categorySuggestions() {
    List<Widget> list = [];

    for (var i = 0; i < Constants.jobCategoriesList.length; i++) {
      list.add(PrsmTag(
        tagName: Constants.jobCategoriesList[i],
        onTap: (searchText) {
          String searchTxt = Constants.jobCategoriesList[i];

          if (searchCategory.contains(searchTxt)) {
            searchCategory.remove(searchTxt);
          } else {
            searchCategory.add(searchTxt);
          }

          if (searchCategory.isNotEmpty) {
            _searchJob();
          }
        },
      ));
    }

    return Padding(
      padding:
          EdgeInsets.only(left: 32.w, right: 32.w, top: 24.h, bottom: 18.h),
      child: SizedBox(
          width: double.infinity,
          child: Wrap(spacing: 12.w, runSpacing: 15.h, children: list)),
    );
  }

  Future<void> _searchJob() async {
    setState(() {
      isLoading = true;
      currentLocJobList.clear();
    });

    if (_searchController.text.isEmpty && searchCategory.isEmpty) {
      logger("GET ALL JOBS IN SEARCH FOR ADS");
      await appStore.dispatch(GetJobsAction(
        division: selectedDivision,
      ));
      List<JobModel> jobs = appStore.state.jobsState.currentLocationJobsList;
      for (int i = 0; i < jobs.length; i++) {
        setState(() {
          isLoading = false;
          currentLocJobList.add(jobs[i]);
        });
      }
      setState(() {
        showSeeMoreBtn = true;
      });
    } else {
      bool success = await appStore.dispatch(GetJobSearchAction(
        searchText: _searchController.text.toLowerCase(),
        searchCategory:
            searchCategory.map((category) => category.toLowerCase()).toList(),
      ));
      if (success) {
        List<JobModel> jobs = appStore.state.jobsState.searchJobList;
        for (int i = 0; i < jobs.length; i++) {
          setState(() {
            isLoading = false;
            currentLocJobList.add(jobs[i]);
          });
        }
      }
    }

    await Future.delayed(const Duration(seconds: 7), () {
      if (context.mounted) {
        setState(() {
          isLoading = false;
          screenText = "No Jobs Found";
        });
      }
    });
  }

  Future<void> fetchMoreData() async {
    setState(() {
      isLoadingMore = true;
    });
    await Future.delayed(const Duration(seconds: 3), () async {
      bool success = await appStore.dispatch(GetJobsAction(
          division: selectedDivision,
          lastDocumentId:
              appStore.state.jobsState.currentLocationJobsList.last.jobId));
      if (success) {
        List<JobModel> jobs = appStore.state.jobsState.currentLocationJobsList;
        for (int i = 0; i < jobs.length; i++) {
          setState(() {
            currentLocJobList.add(jobs[i]);
          });
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: ThemeColors.indigo300,
            duration: const Duration(seconds: 1),
            content: SizedText(
              text: "No more jobs found",
              textStyle: ThemeTextRegular.k12.copyWith(
                color: ThemeColors.indigo900,
                fontWeight: FontWeight.w400,
              ),
            ),
          ));
        }
      }
    });
    setState(() {
      isLoadingMore = false;
    });
  }
}
