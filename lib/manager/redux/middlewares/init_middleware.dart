import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mehonot_admin/manager/firebase/firebase_kit.dart';
import 'package:mehonot_admin/manager/hive_client.dart';
import '../../../presentation/template/template.dart';
import '../../models/Feedback/feedback_md.dart';
import '../../models/sync/sync_reg_terms_md.dart';
import '../../navigation/router.gr.dart';
import '../states/ads_state.dart';
import '../states/auth_state.dart';
import '../states/init_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InitMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetStateInitAction:
        return _getStateInitAction(store.state, action, next);
      case GetInternetConnectionCheckAction:
        return _getInternetConnectionCheckAction(store.state, action, next);
      case GetAllJobsCountAction:
        return _getAllJobsCountAction(store.state, action, next);
      case GetAllFeedbackAction:
        return _getAllFeedbackAction(store.state, action, next);
      case GetTermsAndPoliciesAction:
        return _getTermsAndPoliciesAction(store.state, action, next);
      case GetUpdateTermsAndPoliciesAction:
        return _getUpdateTermsAndPoliciesAction(store.state, action, next);
      default:
        return next(action);
    }
  }
}

_getStateInitAction(
    AppState state, GetStateInitAction action, NextDispatcher next) async {
  logger("GetStateInitAction -- Called");
  logger(
      "GetStateInitAction -- HiveClient.getUserId() ${HiveClient.getUserId()}");
  logger(
      "GetStateInitAction -- HiveClient.getDivision() ${HiveClient.getDivision()}");
  bool userFetched = false;
  if (HiveClient.getUserId() == null ||
      HiveClient.getDivision() == null ||
      HiveClient.getDivision() == "" ||
      HiveClient.getUserId() == "") {
    await Future.delayed(const Duration(seconds: 3));
    appRouter.replaceAll([const Login01Route()]);
  }
  if (HiveClient.getUserId() != null ||
      HiveClient.getDivision() != null ||
      HiveClient.getDivision() != "" ||
      HiveClient.getUserId() != "") {
    await Future.delayed(const Duration(seconds: 3));
    userFetched = await appStore.dispatch(GetExistedUserAction(
      userId: HiveClient.getUserId()!,
      context: action.context,
    ));
    if (userFetched) {
      await appStore.dispatch(GetAllJobsCountAction());
      await appStore.dispatch(GetHomeBannersAction());
      await appStore.dispatch(GetSettingsBannersAction());
      await appStore.dispatch(GetJobAdsIdsAction());
      await appStore.dispatch(GetAllFeedbackAction());
      appRouter.replaceAll([GeneralWrapperRouter()]);
    } else {
      appRouter.replaceAll([const Login01Route()]);
    }
  }
}

Future<bool> _getAllJobsCountAction(
    AppState state, GetAllJobsCountAction action, NextDispatcher next) async {
  logger("GetAllJobsCountAction -- Called");
  try {
    final jobCollDhk = FirebaseKit().dhakaJobsCollection;
    final jobCollCtg = FirebaseKit().chittagongJobsCollection;
    final jobCollKhl = FirebaseKit().khulnaJobsCollection;
    final jobCollRaj = FirebaseKit().rajshahiJobsCollection;
    final jobCollBar = FirebaseKit().barisalJobsCollection;
    final jobCollSyl = FirebaseKit().sylhetJobsCollection;
    final jobCollRng = FirebaseKit().rangpurJobsCollection;
    final jobCollMym = FirebaseKit().mymensinghJobsCollection;
    final jobCollDhkCount = await jobCollDhk.get();
    final jobCollCtgCount = await jobCollCtg.get();
    final jobCollKhlCount = await jobCollKhl.get();
    final jobCollRajCount = await jobCollRaj.get();
    final jobCollBarCount = await jobCollBar.get();
    final jobCollSylCount = await jobCollSyl.get();
    final jobCollRngCount = await jobCollRng.get();
    final jobCollMymCount = await jobCollMym.get();
    final jobCollDhkCountLength = jobCollDhkCount.size;
    final jobCollCtgCountLength = jobCollCtgCount.size;
    final jobCollKhlCountLength = jobCollKhlCount.size;
    final jobCollRajCountLength = jobCollRajCount.size;
    final jobCollBarCountLength = jobCollBarCount.size;
    final jobCollSylCountLength = jobCollSylCount.size;
    final jobCollRngCountLength = jobCollRngCount.size;
    final jobCollMymCountLength = jobCollMymCount.size;
    final totalJobsCount = jobCollDhkCountLength +
        jobCollCtgCountLength +
        jobCollKhlCountLength +
        jobCollRajCountLength +
        jobCollBarCountLength +
        jobCollSylCountLength +
        jobCollRngCountLength +
        jobCollMymCountLength;
    logger("GetAllJobsCountAction -- totalJobsCount: $totalJobsCount");
    await appStore.dispatch(UpdateInitStateAction(
        countDhkJobs: jobCollDhkCountLength,
        countCtgJobs: jobCollCtgCountLength,
        countKhlJobs: jobCollKhlCountLength,
        countRajJobs: jobCollRajCountLength,
        countBarJobs: jobCollBarCountLength,
        countSylJobs: jobCollSylCountLength,
        countRngJobs: jobCollRngCountLength,
        countMymJobs: jobCollMymCountLength,
        countAllJobs: totalJobsCount));
    return true;
  } catch (e) {
    logger("GetAllJobsCountAction -- Error: $e");
    return false;
  }
}

Future<bool> _getAllFeedbackAction(
    AppState state, GetAllFeedbackAction action, NextDispatcher next) async {
  logger("GetAllFeedbackAction -- Called");
  try {
    List<FeedbackMd> feedbackList = [];
    final feedbackColl = FirebaseKit().feedbackCollection;
    await feedbackColl.get().then((value) {
      return value.docs.map((e) {
        FeedbackMd feedback = FeedbackMd(
          id: e.id,
          createdAt: e['createdAt'].toString(),
          userId: e['userId'],
          userProfileId: e['userProfileId'],
          feedback: e['feedback'],
          rating: e['rating'],
        );
        feedbackList.add(feedback);
        logger("GetAllFeedbackAction -- feedback: $feedback");
      }).toList();
    });
    await appStore.dispatch(UpdateInitStateAction(feedbackList: feedbackList));
    return true;
  } catch (e) {
    logger("GetAllFeedbackAction -- Error: $e");
    return false;
  }
}

Future<bool> _getInternetConnectionCheckAction(AppState state,
    GetInternetConnectionCheckAction action, NextDispatcher next) async {
  logger("GetInternetConnectionCheckAction -- Called");
  ConnectivityResult value = await (Connectivity().checkConnectivity());
  if (value == ConnectivityResult.wifi || value == ConnectivityResult.mobile) {
    logger("Internet available");
    return true;
  } else {
    logger("No internet");
    return false;
  }
}

Future<bool?> _getTermsAndPoliciesAction(AppState state,
    GetTermsAndPoliciesAction action, NextDispatcher next) async {
  logger("GetTermsAndPoliciesAction -- called");
  try {
    CollectionReference termsAndPoliciesColl = FirebaseKit().termsAndPolicies;
    SyncRegTermsMd? syncRegTermsMd;
    await termsAndPoliciesColl.get().then((value) {
      value.docs.map((e) {
        syncRegTermsMd = SyncRegTermsMd(
          id: e["id"],
          createdDate: e["createdDate"].toString(),
          version: e["version"],
          halalTerms: e["halalTerms"],
          marketingInfoTerms: e["marketingInfoTerms"],
          personalInfoTerms: e["personalInfoTerms"],
          serviceTerms: e["serviceTerms"],
          softwareTerms: e["softwareTerms"],
        );
      }).toList();
    }).then((value) {
      appStore.dispatch(UpdateInitStateAction(syncRegTermsMd: syncRegTermsMd));
    });
    logger(
        "GetTermsAndPoliciesAction -- syncRegTermsMd: ${syncRegTermsMd?.toJson()}");
    return true;
  } catch (e) {
    logger("GetTermsAndPoliciesAction -- Error: $e");
    return false;
  }
}

Future<bool> _getUpdateTermsAndPoliciesAction(AppState state,
    GetUpdateTermsAndPoliciesAction action, NextDispatcher next) async {
  logger("GetTermsAndPoliciesAction -- ");
  try {
    CollectionReference termsAndPoliciesColl = FirebaseKit().termsAndPolicies;

    await termsAndPoliciesColl.doc(action.syncRegTermsMd.id).update({
      "createdDate": action.syncRegTermsMd.createdDate,
      "version": (int.parse(action.syncRegTermsMd.version) + 1).toString(),
      "halalTerms": action.syncRegTermsMd.halalTerms,
      "marketingInfoTerms": action.syncRegTermsMd.marketingInfoTerms,
      "personalInfoTerms": action.syncRegTermsMd.personalInfoTerms,
      "serviceTerms": action.syncRegTermsMd.serviceTerms,
      "softwareTerms": action.syncRegTermsMd.softwareTerms,
    }).then((value) async {
      SyncRegTermsMd syncRegTermsMd = SyncRegTermsMd(
        id: action.syncRegTermsMd.id,
        createdDate: action.syncRegTermsMd.createdDate,
        version: action.syncRegTermsMd.version,
        halalTerms: action.syncRegTermsMd.halalTerms,
        marketingInfoTerms: action.syncRegTermsMd.marketingInfoTerms,
        personalInfoTerms: action.syncRegTermsMd.personalInfoTerms,
        serviceTerms: action.syncRegTermsMd.serviceTerms,
        softwareTerms: action.syncRegTermsMd.softwareTerms,
      );

      await appStore
          .dispatch(UpdateInitStateAction(syncRegTermsMd: syncRegTermsMd));
    });

    return true;
  } catch (e) {
    logger("GetTermsAndPoliciesAction -- Error: $e");
    return false;
  }
}
