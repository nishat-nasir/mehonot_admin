import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mehonot_admin/manager/models/User/user_md.dart';

import '../../../presentation/template/template.dart';
import '../../../presentation/utils/constants.dart';
import '../../firebase/firebase_kit.dart';
import '../../models/Job/job_md.dart';
import '../../models/User/user_job_relation_md.dart';
import '../../models/User/user_profile_md.dart';
import '../states/account_state.dart';
import '../states/jobs_state.dart';
import '../states/user_state.dart';
import 'jobs_middleware .dart';

class AccountMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetDeleteAccountAction:
        return _getDeleteAccountAction(store.state, action, next);
      case GetMakeAccountPremiumAction:
        return _getMakeAccountPremiumAction(store.state, action, next);
      case GetAllMyPostedJobsAction:
        return _getAllMyPostedJobsAction(store.state, action, next);
      case GetAllMyJobApplicationsAction:
        return _getAllMyJobApplicationsAction(store.state, action, next);
      case GetAddToMyJobsIdsAction:
        return _getAddToMyJobsIdsAction(store.state, action, next);
      case GetRemoveFromMyJobsIdsAction:
        return _getRemoveFromMyJobsIdsAction(store.state, action, next);
      case GetJobApplicationAction:
        return _getJobApplicationAction(store.state, action, next);
      case GetRemoveJobApplicationAction:
        return _getRemoveJobApplicationAction(store.state, action, next);
      default:
        return next(action);
    }
  }
}

_getDeleteAccountAction(
    AppState state, GetDeleteAccountAction action, NextDispatcher next) async {
  try {
    logger("GetDeleteAccountAction -- Called");
  } catch (e) {
    print(e);
  }
}

_getMakeAccountPremiumAction(AppState state, GetMakeAccountPremiumAction action,
    NextDispatcher next) async {
  logger("GetMakeAccountPremiumAction -- Called");
}

Future<bool> _getAllMyPostedJobsAction(AppState state,
    GetAllMyPostedJobsAction action, NextDispatcher next) async {
  try {
    logger("GetAllMyPostedJobsAction -- Called");
    List<String> jobsList = [];
    List<JobModel> myPostedJobs = [];
    List<String> allRequestedJobs = [];

    if (state.userState.userJobRelationData.myJobsIds.isNotEmpty) {
      jobsList = state.userState.userJobRelationData.myJobsIds;
    } else {
      return false;
    }

    for (int i = 0; i < state.jobsState.allRequestedJobs.length; i++) {
      allRequestedJobs.add(state.jobsState.allRequestedJobs[i].jobId);
    }

    for (int i = 0; i < jobsList.length; i++) {
      if (allRequestedJobs.contains(jobsList[i])) {
        myPostedJobs.add(state.jobsState.allRequestedJobs
            .firstWhere((job) => job.jobId == jobsList[i]));
      } else {
        if (jobsList[i].contains('_req')) {
          jobsList[i] = jobsList[i].replaceAll('_req', '');
        }

        Division division =
            convertStringToDivision(jobsList[i].split('_')[0].capitalize());
        JobModel? job = await appStore.dispatch(
            GetJobDataByIdAction(jobId: jobsList[i], jobDivision: division));

        if (job != null) {
          myPostedJobs.add(job);

          if (!job.jobId.contains('_req')) {
            await FirebaseKit()
                .usersProfilesCollection
                .doc(state.userState.userData.userProfileId)
                .update({
              "myJobsIds": FieldValue.arrayRemove(["${job.jobId}_req"]),
            }).then((value) async {
              // Update user's myJobsIds to add the job without _req
              await FirebaseKit()
                  .usersProfilesCollection
                  .doc(state.userState.userData.userProfileId)
                  .update({
                "myJobsIds": FieldValue.arrayUnion([(job.jobId)]),
              });
            });
          }
        }
      }
    }

    next(UpdateAccountStateAction(
      myPostedJobsData: myPostedJobs,
    ));

    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetAllMyPostedJobsAction CATCH ERROR');
    return false;
  }
}

Future<bool> _getAllMyJobApplicationsAction(AppState state,
    GetAllMyJobApplicationsAction action, NextDispatcher next) async {
  try {
    logger("GetAllMyPostedJobsAction -- Called");
    List<String> jobsList = [];
    List<JobModel> myJobApplications = [];

    if (state.userState.userJobRelationData.appliedJobsIds.isNotEmpty) {
      jobsList = state.userState.userJobRelationData.appliedJobsIds;
    } else {
      return false;
    }

    for (int i = 0; i < jobsList.length; i++) {
      Division division =
          convertStringToDivision(jobsList[i].split('_')[0].capitalize());
      JobModel? job = await appStore.dispatch(
          GetJobDataByIdAction(jobId: jobsList[i], jobDivision: division));

      if (job != null) {
        myJobApplications.add(job);

        if (!job.jobId.contains('_req')) {
          await FirebaseKit()
              .usersProfilesCollection
              .doc(state.userState.userData.userProfileId)
              .update({
            "myJobsIds": FieldValue.arrayRemove(["${job.jobId}_req"]),
          }).then((value) async {
            // Update user's myJobsIds to add the job without _req
            await FirebaseKit()
                .usersProfilesCollection
                .doc(state.userState.userData.userProfileId)
                .update({
              "myJobsIds": FieldValue.arrayUnion([(job.jobId)]),
            });
          });
        }
      }
    }

    next(UpdateAccountStateAction(
      myApplicationJobsData: myJobApplications,
    ));

    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetAllMyPostedJobsAction CATCH ERROR');
    return false;
  }
}

Future<bool> _getAddToMyJobsIdsAction(
    AppState state, GetAddToMyJobsIdsAction action, NextDispatcher next) async {
  try {
    logger("GetUpdateMyJobsIdsAction -- Called");
    await FirebaseKit()
        .usersProfilesCollection
        .doc(state.userState.userData.userProfileId)
        .collection(userProfileJobRelationsFbDb)
        .doc(state.userState.userProfileData.userJobRelationId)
        .update({
      "myJobsIds": FieldValue.arrayUnion([action.jobId]),
    }).then((value) {
      appStore.dispatch(UpdateUserStateAction(
          userJobRelationData: UserJobRelationMd(
        userProfileId: state.userState.userProfileData.userProfileId,
        appliedJobsIds: state.userState.userJobRelationData.appliedJobsIds,
        savedJobsIds: state.userState.userJobRelationData.savedJobsIds,
        myJobsIds: state.userState.userJobRelationData.myJobsIds
          ..add(action.jobId),
      )));
    });

    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetUpdateMyJobsIdsAction CATCH ERROR');
    return false;
  }
}

Future<bool> _getRemoveFromMyJobsIdsAction(AppState state,
    GetRemoveFromMyJobsIdsAction action, NextDispatcher next) async {
  try {
    logger("GetRemoveFromMyJobsIdsAction -- Called");
    bool success = false;

    if (action.removingFromMyJobs == true) {
      success = await appStore.dispatch(GetDeleteJobAction(
          jobModel: action.jobModel, jobDetailModel: action.jobDetailModel));
    } else {
      success = true;
    }

    if (success) {
      await FirebaseKit()
          .usersProfilesCollection
          .doc(state.userState.userData.userProfileId)
          .collection(userProfileJobRelationsFbDb)
          .doc(state.userState.userProfileData.userJobRelationId)
          .update({
        "myJobsIds": FieldValue.arrayRemove([action.jobModel.jobId]),
      }).then((value) async {
        appStore.dispatch(UpdateUserStateAction(
          userJobRelationData: UserJobRelationMd(
            userProfileId: state.userState.userProfileData.userProfileId,
            appliedJobsIds: state.userState.userJobRelationData.appliedJobsIds,
            savedJobsIds: state.userState.userJobRelationData.savedJobsIds,
            myJobsIds: state.userState.userJobRelationData.myJobsIds
              ..remove(action.jobModel.jobId),
          ),
        ));
      });
    } else {
      return false;
    }

    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetRemoveFromMyJobsIdsAction CATCH ERROR');
    return false;
  }
}

Future<bool> _getJobApplicationAction(
    AppState state, GetJobApplicationAction action, NextDispatcher next) async {
  try {
    logger("GetJobApplicationAction -- Called");

    CollectionReference jobFromDivisionCollection = getDivisionCollection(
        convertStringToDivision(action.jobModel.address.division));

    await jobFromDivisionCollection
        .doc(action.jobModel.jobId)
        .collection(jobDetailsFbDb)
        .doc(action.jobModel.jobDetailsId)
        .update({
      "appliedBy":
          FieldValue.arrayUnion([state.userState.userData.userProfileId])
    });

    await FirebaseKit()
        .usersProfilesCollection
        .doc(state.userState.userData.userProfileId)
        .collection(userProfileJobRelationsFbDb)
        .doc(state.userState.userProfileData.userJobRelationId)
        .update({
      "appliedJobsIds": FieldValue.arrayUnion([action.jobModel.jobId]),
    }).then((value) async {
      appStore.dispatch(UpdateUserStateAction(
        userJobRelationData: UserJobRelationMd(
          userProfileId: state.userState.userProfileData.userProfileId,
          appliedJobsIds: state.userState.userJobRelationData.appliedJobsIds
            ..add(action.jobModel.jobId),
          savedJobsIds: state.userState.userJobRelationData.savedJobsIds,
          myJobsIds: state.userState.userJobRelationData.myJobsIds,
        ),
      ));
    });

    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetJobApplicationAction CATCH ERROR');
    return false;
  }
}

Future<bool> _getRemoveJobApplicationAction(AppState state,
    GetRemoveJobApplicationAction action, NextDispatcher next) async {
  try {
    logger("GetRemoveJobApplicationAction -- Called");

    CollectionReference jobFromDivisionCollection = getDivisionCollection(
        convertStringToDivision(action.jobModel.address.division));

    await jobFromDivisionCollection
        .doc(action.jobModel.jobId)
        .collection(jobDetailsFbDb)
        .doc(action.jobModel.jobDetailsId)
        .update({
      "appliedBy":
          FieldValue.arrayRemove([state.userState.userData.userProfileId])
    });

    await FirebaseKit()
        .usersProfilesCollection
        .doc(state.userState.userData.userProfileId)
        .collection(userProfileJobRelationsFbDb)
        .doc(state.userState.userProfileData.userJobRelationId)
        .update({
      "appliedJobsIds": FieldValue.arrayRemove([action.jobModel.jobId]),
    }).then((value) async {
      appStore.dispatch(UpdateUserStateAction(
        userJobRelationData: UserJobRelationMd(
          userProfileId: state.userState.userProfileData.userProfileId,
          appliedJobsIds: state.userState.userJobRelationData.appliedJobsIds
            ..remove(action.jobModel.jobId),
          savedJobsIds: state.userState.userJobRelationData.savedJobsIds,
          myJobsIds: state.userState.userJobRelationData.myJobsIds,
        ),
      ));
    });

    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetRemoveJobApplicationAction CATCH ERROR');
    return false;
  }
}
