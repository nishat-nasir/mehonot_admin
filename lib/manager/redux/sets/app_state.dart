import 'package:flutter_redux/flutter_redux.dart';
import 'package:mehonot_admin/manager/redux/middlewares/auth_middleware%20.dart';
import 'package:mehonot_admin/manager/redux/middlewares/init_middleware.dart';
import 'package:mehonot_admin/manager/redux/middlewares/jobs_middleware%20.dart';
import 'package:mehonot_admin/manager/redux/sets/reducer.dart';
import 'package:mehonot_admin/manager/redux/states/auth_state.dart';

import '../../../app.dart';
import '../../../presentation/template/template.dart';
import '../middlewares/account_middleware.dart';
import '../middlewares/ads_middleware.dart';
import '../middlewares/navigation_middleware.dart';
import '../middlewares/user_middleware .dart';
import '../states/account_state.dart';
import '../states/ads_state.dart';
import '../states/init_state.dart';
import '../states/jobs_state.dart';
import '../states/nav_state.dart';
import '../states/user_state.dart';

AppState get GETSTATE =>
    StoreProvider.of<AppState>(appRouter.navigatorKey.currentState!.context)
        .state;

final appStore = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [
    NavigationMiddleware(),
    JobsMiddleware(),
    AdsMiddleware(),
    AccountMiddleware(),
    UserMiddleware(),
    AuthMiddleware(),
    InitMiddleware(),
  ],
);

@immutable
class AppState {
  final NavigationState navigationState;
  final JobsState jobsState;
  final AdsState adsState;
  final AccountState accountState;
  final UserState userState;
  final AuthState authState;
  final InitState initState;

  AppState({
    required this.navigationState,
    required this.jobsState,
    required this.adsState,
    required this.accountState,
    required this.userState,
    required this.authState,
    required this.initState,
  });

  factory AppState.initial() {
    return AppState(
      navigationState: NavigationState.initial(),
      jobsState: JobsState.initial(),
      adsState: AdsState.initial(),
      accountState: AccountState.initial(),
      userState: UserState.initial(),
      authState: AuthState.initial(),
      initState: InitState.initial(),
    );
  }

  AppState copyWith({
    NavigationState? navigationState,
    JobsState? jobsState,
    AdsState? adsState,
    AccountState? accountState,
    UserState? userState,
    AuthState? authState,
    InitState? initState,
  }) {
    return AppState(
      navigationState: navigationState ?? this.navigationState,
      jobsState: jobsState ?? this.jobsState,
      adsState: adsState ?? this.adsState,
      accountState: accountState ?? this.accountState,
      userState: userState ?? this.userState,
      authState: authState ?? this.authState,
      initState: initState ?? this.initState,
    );
  }
}
