import 'package:auto_route/auto_route.dart';import '../../../../manager/models/Job/job_md.dart';import '../../../../manager/redux/sets/app_state.dart';import '../../../../manager/redux/states/ads_state.dart';import '../../../template/template.dart';import '../../../utils/constants.dart';Future<String> getTheBtnText({required job}) async {  await appStore.dispatch(GetJobAdsIdsAction());  List<String> jobIdList = [];  Division jobDiv = convertStringToDivision(job.address.division);  switch (jobDiv) {    case Division.Dhaka:      jobIdList = appStore.state.adsState.allJobAdsIds.dhakaJobAds ?? [];      break;    case Division.Barisal:      jobIdList = appStore.state.adsState.allJobAdsIds.barisalJobAds ?? [];      break;    case Division.Chittagong:      jobIdList = appStore.state.adsState.allJobAdsIds.chittagongJobAds ?? [];      break;    case Division.Khulna:      jobIdList = appStore.state.adsState.allJobAdsIds.khulnaJobAds ?? [];      break;    case Division.Mymensingh:      jobIdList = appStore.state.adsState.allJobAdsIds.mymensinghJobAds ?? [];      break;    case Division.Rajshahi:      jobIdList = appStore.state.adsState.allJobAdsIds.rajshahiJobAds ?? [];      break;    case Division.Rangpur:      jobIdList = appStore.state.adsState.allJobAdsIds.rangpurJobAds ?? [];      break;    case Division.Sylhet:      jobIdList = appStore.state.adsState.allJobAdsIds.sylhetJobAds ?? [];      break;  }  if (jobIdList.contains(job.jobId)) {    return "Remove Job Ad";  } else {    return "Create Job Ad";  }}Future createOrRmvJobAdFunc(    {required JobModel job, required BuildContext context}) async {  List<String> jobIdList = [];  Division jobDiv = convertStringToDivision(job.address.division);  switch (jobDiv) {    case Division.Dhaka:      jobIdList = appStore.state.adsState.allJobAdsIds.dhakaJobAds ?? [];      break;    case Division.Barisal:      jobIdList = appStore.state.adsState.allJobAdsIds.barisalJobAds ?? [];      break;    case Division.Chittagong:      jobIdList = appStore.state.adsState.allJobAdsIds.chittagongJobAds ?? [];      break;    case Division.Khulna:      jobIdList = appStore.state.adsState.allJobAdsIds.khulnaJobAds ?? [];      break;    case Division.Mymensingh:      jobIdList = appStore.state.adsState.allJobAdsIds.mymensinghJobAds ?? [];      break;    case Division.Rajshahi:      jobIdList = appStore.state.adsState.allJobAdsIds.rajshahiJobAds ?? [];      break;    case Division.Rangpur:      jobIdList = appStore.state.adsState.allJobAdsIds.rangpurJobAds ?? [];      break;    case Division.Sylhet:      jobIdList = appStore.state.adsState.allJobAdsIds.sylhetJobAds ?? [];      break;  }  if (jobIdList.contains(job.jobId)) {    bool success = await appStore        .dispatch(GetRemoveJobAdsAction(jobId: job.jobId, division: jobDiv));    if (success) {      ScaffoldMessenger.of(context).showSnackBar(SnackBar(        backgroundColor: ThemeColors.indigo300,        duration: const Duration(seconds: 1),        content: SizedText(          text: "Job Ad removed successfully",          textStyle: ThemeTextRegular.k12.copyWith(            color: ThemeColors.indigo900,            fontWeight: FontWeight.w400,          ),        ),      ));      context.back();    } else {      ScaffoldMessenger.of(context).showSnackBar(SnackBar(        backgroundColor: ThemeColors.indigo300,        duration: const Duration(seconds: 1),        content: SizedText(          text: "Job Ad removal failed",          textStyle: ThemeTextRegular.k12.copyWith(            color: ThemeColors.indigo900,            fontWeight: FontWeight.w400,          ),        ),      ));    }  } else {    bool success = await appStore        .dispatch(GetCreateJobAdsAction(jobId: job.jobId, division: jobDiv));    if (success) {      ScaffoldMessenger.of(context).showSnackBar(SnackBar(        backgroundColor: ThemeColors.indigo300,        duration: const Duration(seconds: 1),        content: SizedText(          text: "Job Ad created successfully",          textStyle: ThemeTextRegular.k12.copyWith(            color: ThemeColors.indigo900,            fontWeight: FontWeight.w400,          ),        ),      ));      context.back();    } else {      ScaffoldMessenger.of(context).showSnackBar(SnackBar(        backgroundColor: ThemeColors.indigo300,        duration: const Duration(seconds: 1),        content: SizedText(          text: "Job Ad creation failed",          textStyle: ThemeTextRegular.k12.copyWith(            color: ThemeColors.indigo900,            fontWeight: FontWeight.w400,          ),        ),      ));    }  }}