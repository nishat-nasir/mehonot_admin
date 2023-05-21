import 'package:flutter/foundation.dart';
import 'package:mehonot_admin/manager/redux/sets/app_state.dart';
import 'package:redux/redux.dart';

import '../states/account_state.dart';
import '../states/ads_state.dart';
import '../states/auth_state.dart';
import '../states/init_state.dart';
import '../states/jobs_state.dart';
import '../states/nav_state.dart';
import '../states/user_state.dart';

AppState appReducer(AppState state, dynamic action) {
  var newState = state.copyWith(
    navigationState: _navReducer(state.navigationState, action),
    jobsState: _jobsReducer(state.jobsState, action),
    adsState: _adsReducer(state.adsState, action),
    accountState: _accountReducer(state.accountState, action),
    authState: _authReducer(state.authState, action),
    userState: _userReducer(state.userState, action),
    initState: _initReducer(state.initState, action),
  );

  return newState;
}

/////////////////////////
// TODO: Jobs Reducer ///
/////////////////////////
final _jobsReducer = combineReducers<JobsState>(
    [TypedReducer<JobsState, UpdateJobsStateAction>(_updateJobsState)]);

JobsState _updateJobsState(JobsState state, UpdateJobsStateAction action) {
  return state.copyWith(
    dhakaJobs: action.dhakaJobs ?? state.dhakaJobs,
    chittagongJobs: action.chittagongJobs ?? state.chittagongJobs,
    khulnaJobs: action.khulnaJobs ?? state.khulnaJobs,
    barisalJobs: action.barisalJobs ?? state.barisalJobs,
    sylhetJobs: action.sylhetJobs ?? state.sylhetJobs,
    rajshahiJobs: action.rajshahiJobs ?? state.rajshahiJobs,
    rangpurJobs: action.rangpurJobs ?? state.rangpurJobs,
    mymensinghJobs: action.mymensinghJobs ?? state.mymensinghJobs,
    allRequestedJobs: action.allRequestedJobs ?? state.allRequestedJobs,
    currentLocationJobsList:
        action.currentLocationJobsList ?? state.currentLocationJobsList,
    selectedJobDetailModel:
        action.selectedJobDetailModel ?? state.selectedJobDetailModel,
    searchJobList: action.searchJobList ?? state.searchJobList,
    currentDivision: action.currentDivision ?? state.currentDivision,
  );
}

/////////////////////////
// TODO: Auth Reducer ///
/////////////////////////
final _authReducer = combineReducers<AuthState>(
    [TypedReducer<AuthState, UpdateAuthStateAction>(_updateAuthState)]);

AuthState _updateAuthState(AuthState state, UpdateAuthStateAction action) {
  return state.copyWith();
}

/////////////////////////
// TODO: User Reducer ///
/////////////////////////
final _userReducer = combineReducers<UserState>(
    [TypedReducer<UserState, UpdateUserStateAction>(_updateUserState)]);

UserState _updateUserState(UserState state, UpdateUserStateAction action) {
  return state.copyWith(
    userData: action.userData ?? state.userData,
    userProfileData: action.userProfileData ?? state.userProfileData,
    mySavedJobsJobData: action.mySavedJobsJobData ?? state.mySavedJobsJobData,
  );
}

/////////////////////////
// TODO: Init Reducer ///
/////////////////////////
final _initReducer = combineReducers<InitState>(
    [TypedReducer<InitState, UpdateInitStateAction>(_updateInitState)]);

InitState _updateInitState(InitState state, UpdateInitStateAction action) {
  return state.copyWith(
    countDhkJobs: action.countDhkJobs ?? state.countDhkJobs,
    countCtgJobs: action.countCtgJobs ?? state.countCtgJobs,
    countKhlJobs: action.countKhlJobs ?? state.countKhlJobs,
    countRajJobs: action.countRajJobs ?? state.countRajJobs,
    countBarJobs: action.countBarJobs ?? state.countBarJobs,
    countSylJobs: action.countSylJobs ?? state.countSylJobs,
    countRngJobs: action.countRngJobs ?? state.countRngJobs,
    countMymJobs: action.countMymJobs ?? state.countMymJobs,
    countAllJobs: action.countAllJobs ?? state.countAllJobs,
  );
}

/////////////////////////
// TODO: Ads Reducer ///
/////////////////////////
final _adsReducer = combineReducers<AdsState>(
    [TypedReducer<AdsState, UpdateAdsStateAction>(_updateAdsState)]);

AdsState _updateAdsState(AdsState state, UpdateAdsStateAction action) {
  return state.copyWith(
    homeBanners: action.homeBanners ?? state.homeBanners,
    settingBanner: action.settingBanner ?? state.settingBanner,
    jobAds: action.jobAds ?? state.jobAds,
  );
}

/////////////////////////
// TODO: Account Reducer ///
/////////////////////////
final _accountReducer = combineReducers<AccountState>([
  TypedReducer<AccountState, UpdateAccountStateAction>(_updateAccountState)
]);

AccountState _updateAccountState(
    AccountState state, UpdateAccountStateAction action) {
  return state.copyWith(
    myPostedJobsData: action.myPostedJobsData ?? state.myPostedJobsData,
  );
}

/////////////////////////
// TODO: Navigation Reducer ///
/////////////////////////
final _navReducer = combineReducers<NavigationState>([
  TypedReducer<NavigationState, UpdateNavigationAction>(_updateNavigationState),
]);

NavigationState _updateNavigationState(
    NavigationState state, UpdateNavigationAction action) {
  print(
      '--- NAVIGATE TO ${action.name} (${action.isPage! ? 'PAGE' : 'POPUP'}) by ${action.method!.toUpperCase()} ---');
  var history = List.from(state.history);

  switch (action.method) {
    case 'push':
      if (action.name == '/') {
        history.insert(0, action);
      } else {
        history.add(action);
      }
      break;
    case 'pop':
      if (history.isNotEmpty) {
        history.removeLast();
      }
      break;
    case 'replace':
      if (history.isNotEmpty) {
        history.removeLast();
      }

      history.add(action);
      break;
  }

  if (kDebugMode) {
    print('------------HISTORY-------------');

    for (var i in history.reversed) {
      print('${i.isPage ? 'page' : 'popup'} - ${i.name}');
    }

    print('--------------------------------');
  }

  return state.copyWith(history: history);
}
