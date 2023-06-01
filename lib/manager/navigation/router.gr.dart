// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i30;
import 'package:flutter/rendering.dart' as _i34;
import 'package:mehonot_admin/manager/models/Ads/banner_ads/banner_md.dart'
    as _i35;
import 'package:mehonot_admin/manager/models/Job/job_dtl_md.dart' as _i33;
import 'package:mehonot_admin/manager/models/Job/job_md.dart' as _i32;
import 'package:mehonot_admin/manager/navigation/router.dart' as _i1;
import 'package:mehonot_admin/presentation/pages/Account/account_01_page.dart'
    as _i2;
import 'package:mehonot_admin/presentation/pages/Account/account_02_change_id_page.dart'
    as _i3;
import 'package:mehonot_admin/presentation/pages/Ads/Banner/banner_create_page.dart'
    as _i23;
import 'package:mehonot_admin/presentation/pages/Ads/Banner/banner_details_page.dart'
    as _i24;
import 'package:mehonot_admin/presentation/pages/Ads/Banner/banner_edit_page.dart'
    as _i25;
import 'package:mehonot_admin/presentation/pages/Ads/Banner/banner_list_page.dart'
    as _i26;
import 'package:mehonot_admin/presentation/pages/Ads/Banner/banner_set_list_page.dart'
    as _i27;
import 'package:mehonot_admin/presentation/pages/Ads/JobAds/job_ads_create_page.dart'
    as _i28;
import 'package:mehonot_admin/presentation/pages/Ads/JobAds/job_ads_list_page.dart'
    as _i29;
import 'package:mehonot_admin/presentation/pages/Auth/login_01_page.dart'
    as _i4;
import 'package:mehonot_admin/presentation/pages/Auth/reg_01_page.dart' as _i5;
import 'package:mehonot_admin/presentation/pages/Auth/reg_done_01_page.dart'
    as _i6;
import 'package:mehonot_admin/presentation/pages/Dashboard/dashboard_page.dart'
    as _i7;
import 'package:mehonot_admin/presentation/pages/Feedback/feedback_list_page.dart'
    as _i8;
import 'package:mehonot_admin/presentation/pages/home_wrapper.dart' as _i9;
import 'package:mehonot_admin/presentation/pages/intro_01_page.dart' as _i10;
import 'package:mehonot_admin/presentation/pages/Job/ceo_job_create.dart'
    as _i11;
import 'package:mehonot_admin/presentation/pages/Job/ceo_job_edit.dart' as _i12;
import 'package:mehonot_admin/presentation/pages/Job/job_details_page.dart'
    as _i13;
import 'package:mehonot_admin/presentation/pages/Job/job_requests_page.dart'
    as _i14;
import 'package:mehonot_admin/presentation/pages/Menu/menu_01_page.dart'
    as _i15;
import 'package:mehonot_admin/presentation/pages/Profile/profile_01_page.dart'
    as _i16;
import 'package:mehonot_admin/presentation/pages/Profile/profile_edit_01_page.dart'
    as _i17;
import 'package:mehonot_admin/presentation/pages/Saved/saved_01_page.dart'
    as _i18;
import 'package:mehonot_admin/presentation/pages/Search/search_01_page.dart'
    as _i19;
import 'package:mehonot_admin/presentation/pages/Setting/settings_01_page.dart'
    as _i20;
import 'package:mehonot_admin/presentation/pages/Setting/settings_be_ceo_page.dart'
    as _i21;
import 'package:mehonot_admin/presentation/pages/splash_page.dart' as _i22;
import 'package:mehonot_admin/presentation/template/template.dart' as _i31;

abstract class $AppRouter extends _i30.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i30.PageFactory> pagesMap = {
    AuthRouter.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AuthRouterPage(),
      );
    },
    HomePageRouter.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HomePageRouterPage(),
      );
    },
    JobReqRouter.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.JobReqRouterPage(),
      );
    },
    BannerRouter.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BannerRouterPage(),
      );
    },
    JobAdsRouter.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.JobAdsRouterPage(),
      );
    },
    FeedbackRouter.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.FeedbackRouterPage(),
      );
    },
    MyAccountRouter.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.Account01Page(),
      );
    },
    AccountChangeIdRouter.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.Account02ChangeIdPage(),
      );
    },
    Login01Route.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.Login01Page(),
      );
    },
    Registration01Route.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.Registration01Page(),
      );
    },
    RegDone01Route.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RegDone01Page(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.DashboardPage(),
      );
    },
    FeedbackListRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.FeedbackListPage(),
      );
    },
    GeneralWrapperRouter.name: (routeData) {
      final args = routeData.argsAs<GeneralWrapperRouterArgs>(
          orElse: () => const GeneralWrapperRouterArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.GeneralWrapper(key: args.key),
      );
    },
    Intro01Route.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.Intro01Page(),
      );
    },
    CeoJobCreateRouter.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.CeoJobCreatePage(),
      );
    },
    CeoJobEditRouter.name: (routeData) {
      final args = routeData.argsAs<CeoJobEditRouterArgs>();
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.CeoJobEditPage(
          jobModel: args.jobModel,
          jobDetailModel: args.jobDetailModel,
          key: args.key,
        ),
      );
    },
    JobDetailsRouter.name: (routeData) {
      final args = routeData.argsAs<JobDetailsRouterArgs>();
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.JobDetailsPage(
          key: args.key,
          jobModel: args.jobModel,
          jobDetailModel: args.jobDetailModel,
          bottomWidget: args.bottomWidget,
        ),
      );
    },
    JobRequestsRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.JobRequestsPage(),
      );
    },
    Menu01Route.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.Menu01Page(),
      );
    },
    Profile01Route.name: (routeData) {
      final args = routeData.argsAs<Profile01RouteArgs>(
          orElse: () => const Profile01RouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.Profile01Page(key: args.key),
      );
    },
    ProfileEdit01Route.name: (routeData) {
      final args = routeData.argsAs<ProfileEdit01RouteArgs>(
          orElse: () => const ProfileEdit01RouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.ProfileEdit01Page(key: args.key),
      );
    },
    Saved01Route.name: (routeData) {
      final args = routeData.argsAs<Saved01RouteArgs>(
          orElse: () => const Saved01RouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.Saved01Page(key: args.key),
      );
    },
    Search01Route.name: (routeData) {
      final args = routeData.argsAs<Search01RouteArgs>(
          orElse: () => const Search01RouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.Search01Page(key: args.key),
      );
    },
    Settings01Route.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.Settings01Page(),
      );
    },
    BecomeCeoRouter.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.SettingsBeCeoPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.SplashPage(),
      );
    },
    BannerCreateRoute.name: (routeData) {
      final args = routeData.argsAs<BannerCreateRouteArgs>();
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.BannerCreatePage(
          key: args.key,
          bannerType: args.bannerType,
        ),
      );
    },
    BannerDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<BannerDetailsRouteArgs>();
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.BannerDetailsPage(
          key: args.key,
          banner: args.banner,
        ),
      );
    },
    BannerEditRoute.name: (routeData) {
      final args = routeData.argsAs<BannerEditRouteArgs>();
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.BannerEditPage(
          key: args.key,
          bannerMd: args.bannerMd,
        ),
      );
    },
    BannerHomeListRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.BannerHomeListPage(),
      );
    },
    BannerSetListRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.BannerSetListPage(),
      );
    },
    JobAdCreateRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.JobAdCreatePage(),
      );
    },
    JobAdsListRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.JobAdsListPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthRouterPage]
class AuthRouter extends _i30.PageRouteInfo<void> {
  const AuthRouter({List<_i30.PageRouteInfo>? children})
      : super(
          AuthRouter.name,
          initialChildren: children,
        );

  static const String name = 'AuthRouter';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i1.HomePageRouterPage]
class HomePageRouter extends _i30.PageRouteInfo<void> {
  const HomePageRouter({List<_i30.PageRouteInfo>? children})
      : super(
          HomePageRouter.name,
          initialChildren: children,
        );

  static const String name = 'HomePageRouter';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i1.JobReqRouterPage]
class JobReqRouter extends _i30.PageRouteInfo<void> {
  const JobReqRouter({List<_i30.PageRouteInfo>? children})
      : super(
          JobReqRouter.name,
          initialChildren: children,
        );

  static const String name = 'JobReqRouter';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i1.BannerRouterPage]
class BannerRouter extends _i30.PageRouteInfo<void> {
  const BannerRouter({List<_i30.PageRouteInfo>? children})
      : super(
          BannerRouter.name,
          initialChildren: children,
        );

  static const String name = 'BannerRouter';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i1.JobAdsRouterPage]
class JobAdsRouter extends _i30.PageRouteInfo<void> {
  const JobAdsRouter({List<_i30.PageRouteInfo>? children})
      : super(
          JobAdsRouter.name,
          initialChildren: children,
        );

  static const String name = 'JobAdsRouter';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i1.FeedbackRouterPage]
class FeedbackRouter extends _i30.PageRouteInfo<void> {
  const FeedbackRouter({List<_i30.PageRouteInfo>? children})
      : super(
          FeedbackRouter.name,
          initialChildren: children,
        );

  static const String name = 'FeedbackRouter';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i2.Account01Page]
class MyAccountRouter extends _i30.PageRouteInfo<void> {
  const MyAccountRouter({List<_i30.PageRouteInfo>? children})
      : super(
          MyAccountRouter.name,
          initialChildren: children,
        );

  static const String name = 'MyAccountRouter';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i3.Account02ChangeIdPage]
class AccountChangeIdRouter extends _i30.PageRouteInfo<void> {
  const AccountChangeIdRouter({List<_i30.PageRouteInfo>? children})
      : super(
          AccountChangeIdRouter.name,
          initialChildren: children,
        );

  static const String name = 'AccountChangeIdRouter';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i4.Login01Page]
class Login01Route extends _i30.PageRouteInfo<void> {
  const Login01Route({List<_i30.PageRouteInfo>? children})
      : super(
          Login01Route.name,
          initialChildren: children,
        );

  static const String name = 'Login01Route';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i5.Registration01Page]
class Registration01Route extends _i30.PageRouteInfo<void> {
  const Registration01Route({List<_i30.PageRouteInfo>? children})
      : super(
          Registration01Route.name,
          initialChildren: children,
        );

  static const String name = 'Registration01Route';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RegDone01Page]
class RegDone01Route extends _i30.PageRouteInfo<void> {
  const RegDone01Route({List<_i30.PageRouteInfo>? children})
      : super(
          RegDone01Route.name,
          initialChildren: children,
        );

  static const String name = 'RegDone01Route';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i7.DashboardPage]
class DashboardRoute extends _i30.PageRouteInfo<void> {
  const DashboardRoute({List<_i30.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i8.FeedbackListPage]
class FeedbackListRoute extends _i30.PageRouteInfo<void> {
  const FeedbackListRoute({List<_i30.PageRouteInfo>? children})
      : super(
          FeedbackListRoute.name,
          initialChildren: children,
        );

  static const String name = 'FeedbackListRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i9.GeneralWrapper]
class GeneralWrapperRouter
    extends _i30.PageRouteInfo<GeneralWrapperRouterArgs> {
  GeneralWrapperRouter({
    _i31.Key? key,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          GeneralWrapperRouter.name,
          args: GeneralWrapperRouterArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'GeneralWrapperRouter';

  static const _i30.PageInfo<GeneralWrapperRouterArgs> page =
      _i30.PageInfo<GeneralWrapperRouterArgs>(name);
}

class GeneralWrapperRouterArgs {
  const GeneralWrapperRouterArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'GeneralWrapperRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.Intro01Page]
class Intro01Route extends _i30.PageRouteInfo<void> {
  const Intro01Route({List<_i30.PageRouteInfo>? children})
      : super(
          Intro01Route.name,
          initialChildren: children,
        );

  static const String name = 'Intro01Route';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i11.CeoJobCreatePage]
class CeoJobCreateRouter extends _i30.PageRouteInfo<void> {
  const CeoJobCreateRouter({List<_i30.PageRouteInfo>? children})
      : super(
          CeoJobCreateRouter.name,
          initialChildren: children,
        );

  static const String name = 'CeoJobCreateRouter';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i12.CeoJobEditPage]
class CeoJobEditRouter extends _i30.PageRouteInfo<CeoJobEditRouterArgs> {
  CeoJobEditRouter({
    required _i32.JobModel jobModel,
    required _i33.JobDetailModel jobDetailModel,
    _i31.Key? key,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          CeoJobEditRouter.name,
          args: CeoJobEditRouterArgs(
            jobModel: jobModel,
            jobDetailModel: jobDetailModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CeoJobEditRouter';

  static const _i30.PageInfo<CeoJobEditRouterArgs> page =
      _i30.PageInfo<CeoJobEditRouterArgs>(name);
}

class CeoJobEditRouterArgs {
  const CeoJobEditRouterArgs({
    required this.jobModel,
    required this.jobDetailModel,
    this.key,
  });

  final _i32.JobModel jobModel;

  final _i33.JobDetailModel jobDetailModel;

  final _i31.Key? key;

  @override
  String toString() {
    return 'CeoJobEditRouterArgs{jobModel: $jobModel, jobDetailModel: $jobDetailModel, key: $key}';
  }
}

/// generated route for
/// [_i13.JobDetailsPage]
class JobDetailsRouter extends _i30.PageRouteInfo<JobDetailsRouterArgs> {
  JobDetailsRouter({
    _i31.Key? key,
    required _i32.JobModel jobModel,
    _i33.JobDetailModel? jobDetailModel,
    _i31.Widget? bottomWidget,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          JobDetailsRouter.name,
          args: JobDetailsRouterArgs(
            key: key,
            jobModel: jobModel,
            jobDetailModel: jobDetailModel,
            bottomWidget: bottomWidget,
          ),
          initialChildren: children,
        );

  static const String name = 'JobDetailsRouter';

  static const _i30.PageInfo<JobDetailsRouterArgs> page =
      _i30.PageInfo<JobDetailsRouterArgs>(name);
}

class JobDetailsRouterArgs {
  const JobDetailsRouterArgs({
    this.key,
    required this.jobModel,
    this.jobDetailModel,
    this.bottomWidget,
  });

  final _i31.Key? key;

  final _i32.JobModel jobModel;

  final _i33.JobDetailModel? jobDetailModel;

  final _i31.Widget? bottomWidget;

  @override
  String toString() {
    return 'JobDetailsRouterArgs{key: $key, jobModel: $jobModel, jobDetailModel: $jobDetailModel, bottomWidget: $bottomWidget}';
  }
}

/// generated route for
/// [_i14.JobRequestsPage]
class JobRequestsRoute extends _i30.PageRouteInfo<void> {
  const JobRequestsRoute({List<_i30.PageRouteInfo>? children})
      : super(
          JobRequestsRoute.name,
          initialChildren: children,
        );

  static const String name = 'JobRequestsRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i15.Menu01Page]
class Menu01Route extends _i30.PageRouteInfo<void> {
  const Menu01Route({List<_i30.PageRouteInfo>? children})
      : super(
          Menu01Route.name,
          initialChildren: children,
        );

  static const String name = 'Menu01Route';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i16.Profile01Page]
class Profile01Route extends _i30.PageRouteInfo<Profile01RouteArgs> {
  Profile01Route({
    _i34.Key? key,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          Profile01Route.name,
          args: Profile01RouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Profile01Route';

  static const _i30.PageInfo<Profile01RouteArgs> page =
      _i30.PageInfo<Profile01RouteArgs>(name);
}

class Profile01RouteArgs {
  const Profile01RouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'Profile01RouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.ProfileEdit01Page]
class ProfileEdit01Route extends _i30.PageRouteInfo<ProfileEdit01RouteArgs> {
  ProfileEdit01Route({
    _i31.Key? key,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          ProfileEdit01Route.name,
          args: ProfileEdit01RouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileEdit01Route';

  static const _i30.PageInfo<ProfileEdit01RouteArgs> page =
      _i30.PageInfo<ProfileEdit01RouteArgs>(name);
}

class ProfileEdit01RouteArgs {
  const ProfileEdit01RouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'ProfileEdit01RouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i18.Saved01Page]
class Saved01Route extends _i30.PageRouteInfo<Saved01RouteArgs> {
  Saved01Route({
    _i31.Key? key,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          Saved01Route.name,
          args: Saved01RouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Saved01Route';

  static const _i30.PageInfo<Saved01RouteArgs> page =
      _i30.PageInfo<Saved01RouteArgs>(name);
}

class Saved01RouteArgs {
  const Saved01RouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'Saved01RouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i19.Search01Page]
class Search01Route extends _i30.PageRouteInfo<Search01RouteArgs> {
  Search01Route({
    _i31.Key? key,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          Search01Route.name,
          args: Search01RouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Search01Route';

  static const _i30.PageInfo<Search01RouteArgs> page =
      _i30.PageInfo<Search01RouteArgs>(name);
}

class Search01RouteArgs {
  const Search01RouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'Search01RouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i20.Settings01Page]
class Settings01Route extends _i30.PageRouteInfo<void> {
  const Settings01Route({List<_i30.PageRouteInfo>? children})
      : super(
          Settings01Route.name,
          initialChildren: children,
        );

  static const String name = 'Settings01Route';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i21.SettingsBeCeoPage]
class BecomeCeoRouter extends _i30.PageRouteInfo<void> {
  const BecomeCeoRouter({List<_i30.PageRouteInfo>? children})
      : super(
          BecomeCeoRouter.name,
          initialChildren: children,
        );

  static const String name = 'BecomeCeoRouter';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i22.SplashPage]
class SplashRoute extends _i30.PageRouteInfo<void> {
  const SplashRoute({List<_i30.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i23.BannerCreatePage]
class BannerCreateRoute extends _i30.PageRouteInfo<BannerCreateRouteArgs> {
  BannerCreateRoute({
    _i31.Key? key,
    required String bannerType,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          BannerCreateRoute.name,
          args: BannerCreateRouteArgs(
            key: key,
            bannerType: bannerType,
          ),
          initialChildren: children,
        );

  static const String name = 'BannerCreateRoute';

  static const _i30.PageInfo<BannerCreateRouteArgs> page =
      _i30.PageInfo<BannerCreateRouteArgs>(name);
}

class BannerCreateRouteArgs {
  const BannerCreateRouteArgs({
    this.key,
    required this.bannerType,
  });

  final _i31.Key? key;

  final String bannerType;

  @override
  String toString() {
    return 'BannerCreateRouteArgs{key: $key, bannerType: $bannerType}';
  }
}

/// generated route for
/// [_i24.BannerDetailsPage]
class BannerDetailsRoute extends _i30.PageRouteInfo<BannerDetailsRouteArgs> {
  BannerDetailsRoute({
    _i31.Key? key,
    required _i35.BannerModel banner,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          BannerDetailsRoute.name,
          args: BannerDetailsRouteArgs(
            key: key,
            banner: banner,
          ),
          initialChildren: children,
        );

  static const String name = 'BannerDetailsRoute';

  static const _i30.PageInfo<BannerDetailsRouteArgs> page =
      _i30.PageInfo<BannerDetailsRouteArgs>(name);
}

class BannerDetailsRouteArgs {
  const BannerDetailsRouteArgs({
    this.key,
    required this.banner,
  });

  final _i31.Key? key;

  final _i35.BannerModel banner;

  @override
  String toString() {
    return 'BannerDetailsRouteArgs{key: $key, banner: $banner}';
  }
}

/// generated route for
/// [_i25.BannerEditPage]
class BannerEditRoute extends _i30.PageRouteInfo<BannerEditRouteArgs> {
  BannerEditRoute({
    _i31.Key? key,
    required _i35.BannerModel bannerMd,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          BannerEditRoute.name,
          args: BannerEditRouteArgs(
            key: key,
            bannerMd: bannerMd,
          ),
          initialChildren: children,
        );

  static const String name = 'BannerEditRoute';

  static const _i30.PageInfo<BannerEditRouteArgs> page =
      _i30.PageInfo<BannerEditRouteArgs>(name);
}

class BannerEditRouteArgs {
  const BannerEditRouteArgs({
    this.key,
    required this.bannerMd,
  });

  final _i31.Key? key;

  final _i35.BannerModel bannerMd;

  @override
  String toString() {
    return 'BannerEditRouteArgs{key: $key, bannerMd: $bannerMd}';
  }
}

/// generated route for
/// [_i26.BannerHomeListPage]
class BannerHomeListRoute extends _i30.PageRouteInfo<void> {
  const BannerHomeListRoute({List<_i30.PageRouteInfo>? children})
      : super(
          BannerHomeListRoute.name,
          initialChildren: children,
        );

  static const String name = 'BannerHomeListRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i27.BannerSetListPage]
class BannerSetListRoute extends _i30.PageRouteInfo<void> {
  const BannerSetListRoute({List<_i30.PageRouteInfo>? children})
      : super(
          BannerSetListRoute.name,
          initialChildren: children,
        );

  static const String name = 'BannerSetListRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i28.JobAdCreatePage]
class JobAdCreateRoute extends _i30.PageRouteInfo<void> {
  const JobAdCreateRoute({List<_i30.PageRouteInfo>? children})
      : super(
          JobAdCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'JobAdCreateRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i29.JobAdsListPage]
class JobAdsListRoute extends _i30.PageRouteInfo<void> {
  const JobAdsListRoute({List<_i30.PageRouteInfo>? children})
      : super(
          JobAdsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'JobAdsListRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}
