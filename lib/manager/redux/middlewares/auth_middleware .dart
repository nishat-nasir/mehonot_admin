import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:mehonot_admin/manager/hive_client.dart';
import '../../../presentation/template/template.dart';
import '../../../presentation/utils/constants.dart';
import '../../firebase/firebase_kit.dart';
import '../../models/User/user_md.dart';
import '../../models/User/user_profile_md.dart';
import '../states/auth_state.dart';
import '../states/jobs_state.dart';
import '../states/user_state.dart';

class AuthMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetLoginAction:
        return _getLoginAction(store.state, action, next);
      case GetExistedUserAction:
        return _getExistedUserAction(store.state, action, next);
      case GetRegisterAction:
        return _getRegisterAction(store.state, action, next);
      case GetLogoutAction:
        return _getLogoutAction(store.state, action, next);
      case GetCheckPhoneNumExistsAction:
        return _getCheckPhoneNumExistsAction(store.state, action, next);
      case GetChangePassAction:
        return _getChangePassAction(store.state, action, next);
      case GetChangeLoginIdAction:
        return _getChangeLoginIdAction(store.state, action, next);
      default:
        return next(action);
    }
  }
}

Future<bool> _getLoginAction(
    AppState state, GetLoginAction action, NextDispatcher next) async {
  try {
    logger("GetLoginAction -- Called");

    String encPass = encryptToken(action.password);
    // showLoading();
    bool matched = false;

    QuerySnapshot querySnapshot = await FirebaseKit()
        .usersCollection
        .where('phoneNumber', isEqualTo: action.phoneNumber)
        .where('password', isEqualTo: encPass)
        .get();

    List snapshotList = querySnapshot.docs;
    if (snapshotList.isNotEmpty) {
      UserModel userData = UserModel(
        userId: snapshotList.first["userId"],
        userProfileId: snapshotList.first["userProfileId"],
        isAdmin: snapshotList.first["isAdmin"],
        password: snapshotList.first["password"],
        phoneNumber: snapshotList.first["phoneNumber"],
      );

      UserProfileModel? userProf = await appStore.dispatch(GetUserProfileAction(
        userProfileId: userData.userProfileId,
      ));

      if (userProf != null) {
        next(UpdateUserStateAction(userData: userData));
        HiveClient.setUserId(userData.userId);
        HiveClient.setDivision(userProf.address.division);
        matched = true;
      } else {
        matched = false;
      }

      return matched;
    } else {
      return matched;
    }
  } catch (e) {
    logger(e.toString(), hint: 'GET LOGIN CATCH ERROR');
    return false;
  }
}

Future<bool> _getExistedUserAction(
    AppState state, GetExistedUserAction action, NextDispatcher next) async {
  try {
    logger("GetExistedUserAction -- Called");

    // showLoading();
    bool matched = false;

    QuerySnapshot querySnapshot = await FirebaseKit()
        .usersCollection
        .where('userId', isEqualTo: action.userId)
        .get();

    List snapshotList = querySnapshot.docs;
    if (snapshotList.isNotEmpty) {
      UserModel userData = UserModel(
        userId: snapshotList.first["userId"],
        userProfileId: snapshotList.first["userProfileId"],
        isAdmin: snapshotList.first["isAdmin"],
        password: snapshotList.first["password"],
        phoneNumber: snapshotList.first["phoneNumber"],
      );

      UserProfileModel? userProf = await appStore.dispatch(GetUserProfileAction(
        userProfileId: userData.userProfileId,
      ));

      if (userProf != null) {
        HiveClient.setUserId(userData.userId);
        HiveClient.setDivision(userProf.address.division);
        next(UpdateUserStateAction(userData: userData));
        logger("FROM INIT EXISTED: ${userProf.toJson()}");
        await appStore.dispatch(GetAllMySavedJobsAction());
        appStore.dispatch(
            GetLocationAction(divisionString: userProf.address.division));

        matched = true;
      } else {
        matched = false;
      }

      return matched;
    } else {
      return matched;
    }
  } catch (e) {
    logger(e.toString(), hint: 'GET LOGIN CATCH ERROR');
    return false;
  }
}

Future<bool> _getRegisterAction(
    AppState state, GetRegisterAction action, NextDispatcher next) async {
  try {
    logger("GetRegisterAction -- Called");

    String userUid = generateUserUuid();
    String userProfileUid = generateUserProfileUuid();
    String userProfileJobRelationUid = generateUserProfileJobRelationUuid();

    CollectionReference allUsersCollection = FirebaseKit().usersCollection;
    CollectionReference allUsersProfilesCollection =
        FirebaseKit().usersProfilesCollection;
    logger('USER Creating');

    await allUsersCollection.doc(userUid).set({
      'userId': userUid,
      'userProfileId': userProfileUid,
      'password': encryptToken(action.userModelReq.password),
      'phoneNumber': action.userModelReq.phoneNumber,
      'isAdmin': false,
    });
    logger('USER Created');

    await allUsersProfilesCollection.doc(userProfileUid).set({
      'userId': userUid,
      'userProfileId': userProfileUid,
      'userJobRelationId': userProfileJobRelationUid,
      'firstName': action.userProfileModelReq.firstName,
      'lastName': action.userProfileModelReq.lastName,
      'createdDate': action.userProfileModelReq.createdDate,
      'email': action.userProfileModelReq.email,
      'contactNumber': action.userProfileModelReq.contactNumber,
      'address': action.userProfileModelReq.address.toJson(),
      'profileImage': action.userProfileModelReq.profileImage,
      'education': action.userProfileModelReq.education,
      'experience': action.userProfileModelReq.experience,
      'skill': action.userProfileModelReq.skill,
      'isVerifiedOwner': false,
      'isVerifiedExplorer': false,
      'birthday': action.userProfileModelReq.birthday,
      'positionTitle': action.userProfileModelReq.positionTitle,
      'bio': action.userProfileModelReq.bio,
    });

    // Create sub collection name is userProfileJobRelationsFbDb
    await allUsersProfilesCollection
        .doc(userProfileUid)
        .collection(userProfileJobRelationsFbDb)
        .doc(userProfileJobRelationUid)
        .set({
      'userProfileId': userProfileUid,
      'myJobsIds': action.userJobRelationMd.myJobsIds,
      'savedJobsIds': action.userJobRelationMd.savedJobsIds,
      'appliedJobsIds': action.userJobRelationMd.appliedJobsIds,
    });

    HiveClient.setDivision(action.userProfileModelReq.address.division);

    return true;
  } catch (e) {
    closeLoading();
    logger(e.toString(), hint: 'GET Create USER CATCH ERROR');
    return false;
  }
}

_getLogoutAction(AppState state, GetLogoutAction action, NextDispatcher next) {
  logger("GetLogoutAction -- Called");
  HiveClient.setDivision("");
  HiveClient.setUserId("");
}

Future<bool> _getCheckPhoneNumExistsAction(AppState state,
    GetCheckPhoneNumExistsAction action, NextDispatcher next) async {
  QuerySnapshot querySnapshot = await FirebaseKit()
      .usersCollection
      .where('phoneNumber', isEqualTo: action.phoneNumber)
      .get();
  logger("GetCheckPhoneNumExistsAction -- Called-- ${querySnapshot.docs}");
  List snapshotList = querySnapshot.docs;
  bool isExist = snapshotList.isNotEmpty;
  return isExist;
}

Future<String> _getChangePassAction(
    AppState state, GetChangePassAction action, NextDispatcher next) async {
  try {
    logger("GetChangePassAction -- Called");

    String oldPassword = encryptToken(action.oldPassword);

    QuerySnapshot querySnapshot = await FirebaseKit()
        .usersCollection
        .where('userId', isEqualTo: state.userState.userData.userId)
        .where('password', isEqualTo: oldPassword)
        .get();

    List snapshotList = querySnapshot.docs;

    if (snapshotList.isEmpty) {
      return "Old password is incorrect";
    }

    String newPassword = encryptToken(action.newPassword);

    await FirebaseKit()
        .usersCollection
        .doc(state.userState.userData.userId)
        .update({
      "password": action.newPassword,
    }).then((value) {
      appStore.dispatch(UpdateUserStateAction(
          userData: UserModel(
        userId: state.userState.userData.userId,
        userProfileId: state.userState.userData.userProfileId,
        password: state.userState.userData.password,
        phoneNumber: newPassword,
        isAdmin: state.userState.userData.isAdmin,
      )));
    });

    return "Password changed successfully";
  } catch (e) {
    logger(e.toString(), hint: 'GetChangePassAction CATCH ERROR');
    return "Something went wrong";
  }
}

_getChangeLoginIdAction(
    AppState state, GetChangeLoginIdAction action, NextDispatcher next) async {
  try {
    logger("GetChangeLoginIdAction -- Called");
    await FirebaseKit()
        .usersCollection
        .doc(state.userState.userData.userId)
        .update({
      "phoneNumber": action.newLoginId,
    }).then((value) {
      appStore.dispatch(UpdateUserStateAction(
          userData: UserModel(
        userId: state.userState.userData.userId,
        userProfileId: state.userState.userData.userProfileId,
        password: state.userState.userData.password,
        phoneNumber: action.newLoginId,
        isAdmin: state.userState.userData.isAdmin,
      )));
    });

    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetChangeLoginIdAction CATCH ERROR');
    return false;
  }
}
