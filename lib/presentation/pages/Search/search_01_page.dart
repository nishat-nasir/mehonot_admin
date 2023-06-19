import 'package:auto_route/auto_route.dart';
import 'package:mehonot_admin/manager/models/Job/job_md.dart';
import 'package:mehonot_admin/presentation/template/template.dart';
import '../../../manager/redux/states/jobs_state.dart';
import '../../utils/constants.dart';
import '../../widgets/appbar/search_appbar.dart';
import '../../widgets/tag.dart';
import '../Job/Popups/job_details_bottom_popup.dart';

@RoutePage()
class Search01Page extends StatefulWidget {
  Search01Page({Key? key}) : super(key: key);

  @override
  State<Search01Page> createState() => _Search01PageState();
}

class _Search01PageState extends State<Search01Page> {
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  List<JobModel> searchResult = [];
  bool isJobSavedOrNot = false;
  bool isSavingOrNot = false;
  List<String> searchCategory = [];
  bool alreadyTappedJob = false;
  bool isJobAppliedOrNot = false;
  bool isApplyingOrNot = false;

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
          return SpacedColumn(children: [
            PrsmSearchAppBar(
                searchController: _searchController,
                onSearch: (_) {
                  _searchJob();
                },
                onRightIconPress: () {
                  _searchJob();
                }),
            categorySuggestions(),
            if (searchResult.isEmpty) SizedBox(height: 400.h),
            Center(
                child: Padding(
              padding: EdgeInsets.all(12.w),
              child: SingleChildScrollView(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : jobContainers()),
            )),
            const SizedBox(),
          ]);
        });
  }

  Widget jobContainers() {
    List<Widget> list = [];
    for (var i = 0; i < searchResult.length; i++) {
      list.add(JobDetailsBottomModalPopup(jobModel: searchResult[i]));
    }
    if (searchResult.isEmpty) {
      list.add(Center(
          child: SizedText(
        text: _searchController.text.isEmpty
            ? S(context).searchJobs
            : S(context).noJobFound,
        textStyle: ThemeTextBold.k20.copyWith(color: ThemeColors.coolgray400),
      )));
    }

    return SpacedColumn(verticalSpace: 18, children: list);
  }

  Widget categorySuggestions() {
    List<Widget> list = [];

    for (var i = 0; i < Constants.jobCategoriesList.length; i++) {
      list.add(PrsmTag(
        tagName: Constants.jobCategoriesList[i],
        onTap: (searchText) {
          if (searchCategory.contains(searchText)) {
            searchCategory.remove(searchText);
          } else {
            searchCategory.add(searchText);
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

  Future _searchJob() async {
    setState(() {
      isLoading = true;
    });

    bool success = await appStore.dispatch(GetJobSearchAction(
      searchText: _searchController.text.toLowerCase(),
      searchCategory:
          searchCategory.map((category) => category.toLowerCase()).toList(),
    ));

    if (success) {
      setState(() {
        isLoading = false;
        searchResult = appStore.state.jobsState.searchJobList;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
