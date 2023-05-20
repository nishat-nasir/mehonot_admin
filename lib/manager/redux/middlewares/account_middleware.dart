import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mehonot_admin/manager/models/User/user_md.dart';

import '../../../presentation/template/template.dart';
import '../../../presentation/utils/constants.dart';
import '../../firebase/firebase_kit.dart';
import '../../models/Job/job_md.dart';
import '../../models/User/user_profile_md.dart';
import '../states/account_state.dart';
import '../states/jobs_state.dart';
import '../states/user_state.dart';

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
      case GetAddToMyJobsIdsAction:
        return _getAddToMyJobsIdsAction(store.state, action, next);
      case GetRemoveFromMyJobsIdsAction:
        return _getRemoveFromMyJobsIdsAction(store.state, action, next);
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
    if (state.userState.userProfileData.myJobsIds != null &&
        state.userState.userProfileData.myJobsIds!.isNotEmpty) {
      jobsList = state.userState.userProfileData.myJobsIds!;
    }

    for (int i = 0; i < jobsList.length; i++) {
      // Get the Division from action.division and call GetJobDataByIdAction
      Division division =
          convertStringToDivision(jobsList[i].split('_')[0].capitalize());
      JobModel job = await appStore.dispatch(
          GetJobDataByIdAction(jobId: jobsList[i], jobDivision: division));
      myPostedJobs.add(job);
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

Future<bool> _getAddToMyJobsIdsAction(
    AppState state, GetAddToMyJobsIdsAction action, NextDispatcher next) async {
  try {
    logger("GetUpdateMyJobsIdsAction -- Called");
    await FirebaseKit()
        .usersCollection
        .doc(state.userState.userData.userId)
        .collection(userProfileFbDb)
        .doc(state.userState.userData.userProfileId)
        .update({
      "myJobsIds": FieldValue.arrayUnion([action.jobId]),
    }).then((value) {
      appStore.dispatch(UpdateUserStateAction(
          userProfileData: UserProfileModel(
        userId: state.userState.userProfileData.userId,
        userProfileId: state.userState.userProfileData.userProfileId,
        firstName: state.userState.userProfileData.firstName,
        lastName: state.userState.userProfileData.lastName,
        email: state.userState.userProfileData.email,
        contactNumber: state.userState.userProfileData.contactNumber,
        address: state.userState.userProfileData.address,
        profileImage: state.userState.userProfileData.profileImage,
        myJobsIds: state.userState.userProfileData.myJobsIds == null
            ? [action.jobId]
            : state.userState.userProfileData.myJobsIds!
          ..add(action.jobId),
        education: state.userState.userProfileData.education,
        experience: state.userState.userProfileData.experience,
        skill: state.userState.userProfileData.skill,
        birthday: state.userState.userProfileData.birthday,
        bio: state.userState.userProfileData.bio,
        positionTitle: state.userState.userProfileData.positionTitle,
        createdDate: state.userState.userProfileData.createdDate,
        savedJobsIds: state.userState.userProfileData.savedJobsIds,
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
    await FirebaseKit()
        .usersCollection
        .doc(state.userState.userData.userId)
        .collection(userProfileFbDb)
        .doc(state.userState.userData.userProfileId)
        .update({
      "myJobsIds": FieldValue.arrayRemove([action.jobId]),
    }).then((value) {
      appStore.dispatch(UpdateUserStateAction(
          userProfileData: UserProfileModel(
        userId: state.userState.userProfileData.userId,
        userProfileId: state.userState.userProfileData.userProfileId,
        firstName: state.userState.userProfileData.firstName,
        lastName: state.userState.userProfileData.lastName,
        email: state.userState.userProfileData.email,
        contactNumber: state.userState.userProfileData.contactNumber,
        address: state.userState.userProfileData.address,
        profileImage: state.userState.userProfileData.profileImage,
        myJobsIds: state.userState.userProfileData.myJobsIds!
          ..remove(action.jobId),
        education: state.userState.userProfileData.education,
        experience: state.userState.userProfileData.experience,
        skill: state.userState.userProfileData.skill,
        birthday: state.userState.userProfileData.birthday,
        bio: state.userState.userProfileData.bio,
        positionTitle: state.userState.userProfileData.positionTitle,
        createdDate: state.userState.userProfileData.createdDate,
        savedJobsIds: state.userState.userProfileData.savedJobsIds,
      )));
    });

    next(appStore.dispatch(GetDeleteJobAction(
        jobId: action.jobId,
        division: action.division,
        jobDetailsId: action.jobDetailsId)));

    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetRemoveFromMyJobsIdsAction CATCH ERROR');
    return false;
  }
}
