// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i33;
import 'package:flutter/foundation.dart' as _i34;
import 'package:flutter/rendering.dart' as _i40;
import 'package:flutter_quill/flutter_quill.dart' as _i37;
import 'package:mehonot_admin/manager/models/Ads/banner_ads/banner_md.dart'
    as _i36;
import 'package:mehonot_admin/manager/models/Job/job_dtl_md.dart' as _i39;
import 'package:mehonot_admin/manager/models/Job/job_md.dart' as _i38;
import 'package:mehonot_admin/manager/navigation/router.dart' as _i1;
import 'package:mehonot_admin/presentation/pages/Account/account_01_page.dart'
    as _i2;
import 'package:mehonot_admin/presentation/pages/Account/account_02_change_id_page.dart'
    as _i3;
import 'package:mehonot_admin/presentation/pages/Ads/Banner/banner_create_page.dart'
    as _i4;
import 'package:mehonot_admin/presentation/pages/Ads/Banner/banner_details_page.dart'
    as _i5;
import 'package:mehonot_admin/presentation/pages/Ads/Banner/banner_edit_page.dart'
    as _i6;
import 'package:mehonot_admin/presentation/pages/Ads/Banner/banner_list_page.dart'
    as _i7;
import 'package:mehonot_admin/presentation/pages/Ads/Banner/banner_set_list_page.dart'
    as _i8;
import 'package:mehonot_admin/presentation/pages/Ads/Banner/quill_test.dart'
    as _i9;
import 'package:mehonot_admin/presentation/pages/Ads/JobAds/job_ads_create_page.dart'
    as _i10;
import 'package:mehonot_admin/presentation/pages/Ads/JobAds/job_ads_list_page.dart'
    as _i11;
import 'package:mehonot_admin/presentation/pages/Auth/login_01_page.dart'
    as _i12;
import 'package:mehonot_admin/presentation/pages/Auth/reg_01_page.dart' as _i13;
import 'package:mehonot_admin/presentation/pages/Auth/reg_done_01_page.dart'
    as _i14;
import 'package:mehonot_admin/presentation/pages/Dashboard/dashboard_page.dart'
    as _i15;
import 'package:mehonot_admin/presentation/pages/Feedback/feedback_list_page.dart'
    as _i16;
import 'package:mehonot_admin/presentation/pages/home_wrapper.dart' as _i17;
import 'package:mehonot_admin/presentation/pages/intro_01_page.dart' as _i18;
import 'package:mehonot_admin/presentation/pages/Job/ceo_job_create.dart'
    as _i19;
import 'package:mehonot_admin/presentation/pages/Job/ceo_job_edit.dart' as _i20;
import 'package:mehonot_admin/presentation/pages/Job/job_details_page.dart'
    as _i21;
import 'package:mehonot_admin/presentation/pages/Job/job_requests_page.dart'
    as _i22;
import 'package:mehonot_admin/presentation/pages/Menu/menu_01_page.dart'
    as _i23;
import 'package:mehonot_admin/presentation/pages/Policies/policies_list_page.dart'
    as _i31;
import 'package:mehonot_admin/presentation/pages/Profile/profile_01_page.dart'
    as _i24;
import 'package:mehonot_admin/presentation/pages/Profile/profile_edit_01_page.dart'
    as _i25;
import 'package:mehonot_admin/presentation/pages/Saved/saved_01_page.dart'
    as _i26;
import 'package:mehonot_admin/presentation/pages/Search/search_01_page.dart'
    as _i27;
import 'package:mehonot_admin/presentation/pages/Setting/settings_01_page.dart'
    as _i28;
import 'package:mehonot_admin/presentation/pages/Setting/settings_be_ceo_page.dart'
    as _i29;
import 'package:mehonot_admin/presentation/pages/splash_page.dart' as _i30;
import 'package:mehonot_admin/presentation/template/template.dart' as _i35;
import 'package:mehonot_admin/presentation/widgets/quill/quill_editor_page.dart'
    as _i32;

abstract class $AppRouter extends _i33.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i33.PageFactory> pagesMap = {
    AuthRouter.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthRouterPage(),
      );
    },
    HomePageRouter.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePageRouterPage(),
      );
    },
    JobReqRouter.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.JobReqRouterPage(),
      );
    },
    BannerRouter.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BannerRouterPage(),
      );
    },
    JobAdsRouter.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.JobAdsRouterPage(),
      );
    },
    FeedbackRouter.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.FeedbackRouterPage(),
      );
    },
    PoliciesRouter.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PoliciesRouterPage(),
      );
    },
    QuillRouter.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.QuillTestRouterPage(),
      );
    },
    MyAccountRouter.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.Account01Page(),
      );
    },
    AccountChangeIdRouter.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.Account02ChangeIdPage(),
      );
    },
    BannerCreateRoute.name: (routeData) {
      final args = routeData.argsAs<BannerCreateRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.BannerCreatePage(
          key: args.key,
          bannerType: args.bannerType,
          onBannerCreate: args.onBannerCreate,
        ),
      );
    },
    BannerDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<BannerDetailsRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.BannerDetailsPage(
          key: args.key,
          banner: args.banner,
        ),
      );
    },
    BannerEditRoute.name: (routeData) {
      final args = routeData.argsAs<BannerEditRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.BannerEditPage(
          key: args.key,
          bannerMd: args.bannerMd,
          onBannerEdit: args.onBannerEdit,
        ),
      );
    },
    BannerHomeListRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.BannerHomeListPage(),
      );
    },
    BannerSetListRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.BannerSetListPage(),
      );
    },
    QuillTestRoute.name: (routeData) {
      final args = routeData.argsAs<QuillTestRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.QuillTest(
          key: args.key,
          onDone: args.onDone,
          controller: args.controller,
        ),
      );
    },
    JobAdCreateRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.JobAdCreatePage(),
      );
    },
    JobAdsListRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.JobAdsListPage(),
      );
    },
    Login01Route.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.Login01Page(),
      );
    },
    Registration01Route.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.Registration01Page(),
      );
    },
    RegDone01Route.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.RegDone01Page(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.DashboardPage(),
      );
    },
    FeedbackListRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.FeedbackListPage(),
      );
    },
    GeneralWrapperRouter.name: (routeData) {
      final args = routeData.argsAs<GeneralWrapperRouterArgs>(
          orElse: () => const GeneralWrapperRouterArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.GeneralWrapper(key: args.key),
      );
    },
    Intro01Route.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.Intro01Page(),
      );
    },
    CeoJobCreateRouter.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.CeoJobCreatePage(),
      );
    },
    CeoJobEditRouter.name: (routeData) {
      final args = routeData.argsAs<CeoJobEditRouterArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.CeoJobEditPage(
          jobModel: args.jobModel,
          jobDetailModel: args.jobDetailModel,
          key: args.key,
        ),
      );
    },
    JobDetailsRouter.name: (routeData) {
      final args = routeData.argsAs<JobDetailsRouterArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.JobDetailsPage(
          key: args.key,
          jobModel: args.jobModel,
          jobDetailModel: args.jobDetailModel,
          bottomWidget: args.bottomWidget,
        ),
      );
    },
    JobRequestsRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.JobRequestsPage(),
      );
    },
    Menu01Route.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.Menu01Page(),
      );
    },
    Profile01Route.name: (routeData) {
      final args = routeData.argsAs<Profile01RouteArgs>(
          orElse: () => const Profile01RouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.Profile01Page(key: args.key),
      );
    },
    ProfileEdit01Route.name: (routeData) {
      final args = routeData.argsAs<ProfileEdit01RouteArgs>(
          orElse: () => const ProfileEdit01RouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.ProfileEdit01Page(key: args.key),
      );
    },
    Saved01Route.name: (routeData) {
      final args = routeData.argsAs<Saved01RouteArgs>(
          orElse: () => const Saved01RouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.Saved01Page(key: args.key),
      );
    },
    Search01Route.name: (routeData) {
      final args = routeData.argsAs<Search01RouteArgs>(
          orElse: () => const Search01RouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i27.Search01Page(key: args.key),
      );
    },
    Settings01Route.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.Settings01Page(),
      );
    },
    BecomeCeoRouter.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.SettingsBeCeoPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.SplashPage(),
      );
    },
    PoliciesListRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.PoliciesListPage(),
      );
    },
    QuillEditorRoute.name: (routeData) {
      final args = routeData.argsAs<QuillEditorRouteArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i32.QuillEditorPage(
          key: args.key,
          onDone: args.onDone,
          controller: args.controller,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthRouterPage]
class AuthRouter extends _i33.PageRouteInfo<void> {
  const AuthRouter({List<_i33.PageRouteInfo>? children})
      : super(
          AuthRouter.name,
          initialChildren: children,
        );

  static const String name = 'AuthRouter';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i1.HomePageRouterPage]
class HomePageRouter extends _i33.PageRouteInfo<void> {
  const HomePageRouter({List<_i33.PageRouteInfo>? children})
      : super(
          HomePageRouter.name,
          initialChildren: children,
        );

  static const String name = 'HomePageRouter';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i1.JobReqRouterPage]
class JobReqRouter extends _i33.PageRouteInfo<void> {
  const JobReqRouter({List<_i33.PageRouteInfo>? children})
      : super(
          JobReqRouter.name,
          initialChildren: children,
        );

  static const String name = 'JobReqRouter';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i1.BannerRouterPage]
class BannerRouter extends _i33.PageRouteInfo<void> {
  const BannerRouter({List<_i33.PageRouteInfo>? children})
      : super(
          BannerRouter.name,
          initialChildren: children,
        );

  static const String name = 'BannerRouter';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i1.JobAdsRouterPage]
class JobAdsRouter extends _i33.PageRouteInfo<void> {
  const JobAdsRouter({List<_i33.PageRouteInfo>? children})
      : super(
          JobAdsRouter.name,
          initialChildren: children,
        );

  static const String name = 'JobAdsRouter';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i1.FeedbackRouterPage]
class FeedbackRouter extends _i33.PageRouteInfo<void> {
  const FeedbackRouter({List<_i33.PageRouteInfo>? children})
      : super(
          FeedbackRouter.name,
          initialChildren: children,
        );

  static const String name = 'FeedbackRouter';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i1.PoliciesRouterPage]
class PoliciesRouter extends _i33.PageRouteInfo<void> {
  const PoliciesRouter({List<_i33.PageRouteInfo>? children})
      : super(
          PoliciesRouter.name,
          initialChildren: children,
        );

  static const String name = 'PoliciesRouter';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i1.QuillTestRouterPage]
class QuillRouter extends _i33.PageRouteInfo<void> {
  const QuillRouter({List<_i33.PageRouteInfo>? children})
      : super(
          QuillRouter.name,
          initialChildren: children,
        );

  static const String name = 'QuillRouter';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i2.Account01Page]
class MyAccountRouter extends _i33.PageRouteInfo<void> {
  const MyAccountRouter({List<_i33.PageRouteInfo>? children})
      : super(
          MyAccountRouter.name,
          initialChildren: children,
        );

  static const String name = 'MyAccountRouter';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i3.Account02ChangeIdPage]
class AccountChangeIdRouter extends _i33.PageRouteInfo<void> {
  const AccountChangeIdRouter({List<_i33.PageRouteInfo>? children})
      : super(
          AccountChangeIdRouter.name,
          initialChildren: children,
        );

  static const String name = 'AccountChangeIdRouter';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i4.BannerCreatePage]
class BannerCreateRoute extends _i33.PageRouteInfo<BannerCreateRouteArgs> {
  BannerCreateRoute({
    _i34.Key? key,
    required String bannerType,
    required Function onBannerCreate,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          BannerCreateRoute.name,
          args: BannerCreateRouteArgs(
            key: key,
            bannerType: bannerType,
            onBannerCreate: onBannerCreate,
          ),
          initialChildren: children,
        );

  static const String name = 'BannerCreateRoute';

  static const _i33.PageInfo<BannerCreateRouteArgs> page =
      _i33.PageInfo<BannerCreateRouteArgs>(name);
}

class BannerCreateRouteArgs {
  const BannerCreateRouteArgs({
    this.key,
    required this.bannerType,
    required this.onBannerCreate,
  });

  final _i34.Key? key;

  final String bannerType;

  final Function onBannerCreate;

  @override
  String toString() {
    return 'BannerCreateRouteArgs{key: $key, bannerType: $bannerType, onBannerCreate: $onBannerCreate}';
  }
}

/// generated route for
/// [_i5.BannerDetailsPage]
class BannerDetailsRoute extends _i33.PageRouteInfo<BannerDetailsRouteArgs> {
  BannerDetailsRoute({
    _i35.Key? key,
    required _i36.BannerModel banner,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          BannerDetailsRoute.name,
          args: BannerDetailsRouteArgs(
            key: key,
            banner: banner,
          ),
          initialChildren: children,
        );

  static const String name = 'BannerDetailsRoute';

  static const _i33.PageInfo<BannerDetailsRouteArgs> page =
      _i33.PageInfo<BannerDetailsRouteArgs>(name);
}

class BannerDetailsRouteArgs {
  const BannerDetailsRouteArgs({
    this.key,
    required this.banner,
  });

  final _i35.Key? key;

  final _i36.BannerModel banner;

  @override
  String toString() {
    return 'BannerDetailsRouteArgs{key: $key, banner: $banner}';
  }
}

/// generated route for
/// [_i6.BannerEditPage]
class BannerEditRoute extends _i33.PageRouteInfo<BannerEditRouteArgs> {
  BannerEditRoute({
    _i35.Key? key,
    required _i36.BannerModel bannerMd,
    required Function onBannerEdit,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          BannerEditRoute.name,
          args: BannerEditRouteArgs(
            key: key,
            bannerMd: bannerMd,
            onBannerEdit: onBannerEdit,
          ),
          initialChildren: children,
        );

  static const String name = 'BannerEditRoute';

  static const _i33.PageInfo<BannerEditRouteArgs> page =
      _i33.PageInfo<BannerEditRouteArgs>(name);
}

class BannerEditRouteArgs {
  const BannerEditRouteArgs({
    this.key,
    required this.bannerMd,
    required this.onBannerEdit,
  });

  final _i35.Key? key;

  final _i36.BannerModel bannerMd;

  final Function onBannerEdit;

  @override
  String toString() {
    return 'BannerEditRouteArgs{key: $key, bannerMd: $bannerMd, onBannerEdit: $onBannerEdit}';
  }
}

/// generated route for
/// [_i7.BannerHomeListPage]
class BannerHomeListRoute extends _i33.PageRouteInfo<void> {
  const BannerHomeListRoute({List<_i33.PageRouteInfo>? children})
      : super(
          BannerHomeListRoute.name,
          initialChildren: children,
        );

  static const String name = 'BannerHomeListRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i8.BannerSetListPage]
class BannerSetListRoute extends _i33.PageRouteInfo<void> {
  const BannerSetListRoute({List<_i33.PageRouteInfo>? children})
      : super(
          BannerSetListRoute.name,
          initialChildren: children,
        );

  static const String name = 'BannerSetListRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i9.QuillTest]
class QuillTestRoute extends _i33.PageRouteInfo<QuillTestRouteArgs> {
  QuillTestRoute({
    _i35.Key? key,
    required dynamic Function(_i37.QuillController) onDone,
    _i37.QuillController? controller,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          QuillTestRoute.name,
          args: QuillTestRouteArgs(
            key: key,
            onDone: onDone,
            controller: controller,
          ),
          initialChildren: children,
        );

  static const String name = 'QuillTestRoute';

  static const _i33.PageInfo<QuillTestRouteArgs> page =
      _i33.PageInfo<QuillTestRouteArgs>(name);
}

class QuillTestRouteArgs {
  const QuillTestRouteArgs({
    this.key,
    required this.onDone,
    this.controller,
  });

  final _i35.Key? key;

  final dynamic Function(_i37.QuillController) onDone;

  final _i37.QuillController? controller;

  @override
  String toString() {
    return 'QuillTestRouteArgs{key: $key, onDone: $onDone, controller: $controller}';
  }
}

/// generated route for
/// [_i10.JobAdCreatePage]
class JobAdCreateRoute extends _i33.PageRouteInfo<void> {
  const JobAdCreateRoute({List<_i33.PageRouteInfo>? children})
      : super(
          JobAdCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'JobAdCreateRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i11.JobAdsListPage]
class JobAdsListRoute extends _i33.PageRouteInfo<void> {
  const JobAdsListRoute({List<_i33.PageRouteInfo>? children})
      : super(
          JobAdsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'JobAdsListRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i12.Login01Page]
class Login01Route extends _i33.PageRouteInfo<void> {
  const Login01Route({List<_i33.PageRouteInfo>? children})
      : super(
          Login01Route.name,
          initialChildren: children,
        );

  static const String name = 'Login01Route';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i13.Registration01Page]
class Registration01Route extends _i33.PageRouteInfo<void> {
  const Registration01Route({List<_i33.PageRouteInfo>? children})
      : super(
          Registration01Route.name,
          initialChildren: children,
        );

  static const String name = 'Registration01Route';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i14.RegDone01Page]
class RegDone01Route extends _i33.PageRouteInfo<void> {
  const RegDone01Route({List<_i33.PageRouteInfo>? children})
      : super(
          RegDone01Route.name,
          initialChildren: children,
        );

  static const String name = 'RegDone01Route';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i15.DashboardPage]
class DashboardRoute extends _i33.PageRouteInfo<void> {
  const DashboardRoute({List<_i33.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i16.FeedbackListPage]
class FeedbackListRoute extends _i33.PageRouteInfo<void> {
  const FeedbackListRoute({List<_i33.PageRouteInfo>? children})
      : super(
          FeedbackListRoute.name,
          initialChildren: children,
        );

  static const String name = 'FeedbackListRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i17.GeneralWrapper]
class GeneralWrapperRouter
    extends _i33.PageRouteInfo<GeneralWrapperRouterArgs> {
  GeneralWrapperRouter({
    _i35.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          GeneralWrapperRouter.name,
          args: GeneralWrapperRouterArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'GeneralWrapperRouter';

  static const _i33.PageInfo<GeneralWrapperRouterArgs> page =
      _i33.PageInfo<GeneralWrapperRouterArgs>(name);
}

class GeneralWrapperRouterArgs {
  const GeneralWrapperRouterArgs({this.key});

  final _i35.Key? key;

  @override
  String toString() {
    return 'GeneralWrapperRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i18.Intro01Page]
class Intro01Route extends _i33.PageRouteInfo<void> {
  const Intro01Route({List<_i33.PageRouteInfo>? children})
      : super(
          Intro01Route.name,
          initialChildren: children,
        );

  static const String name = 'Intro01Route';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i19.CeoJobCreatePage]
class CeoJobCreateRouter extends _i33.PageRouteInfo<void> {
  const CeoJobCreateRouter({List<_i33.PageRouteInfo>? children})
      : super(
          CeoJobCreateRouter.name,
          initialChildren: children,
        );

  static const String name = 'CeoJobCreateRouter';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i20.CeoJobEditPage]
class CeoJobEditRouter extends _i33.PageRouteInfo<CeoJobEditRouterArgs> {
  CeoJobEditRouter({
    required _i38.JobModel jobModel,
    required _i39.JobDetailModel jobDetailModel,
    _i35.Key? key,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<CeoJobEditRouterArgs> page =
      _i33.PageInfo<CeoJobEditRouterArgs>(name);
}

class CeoJobEditRouterArgs {
  const CeoJobEditRouterArgs({
    required this.jobModel,
    required this.jobDetailModel,
    this.key,
  });

  final _i38.JobModel jobModel;

  final _i39.JobDetailModel jobDetailModel;

  final _i35.Key? key;

  @override
  String toString() {
    return 'CeoJobEditRouterArgs{jobModel: $jobModel, jobDetailModel: $jobDetailModel, key: $key}';
  }
}

/// generated route for
/// [_i21.JobDetailsPage]
class JobDetailsRouter extends _i33.PageRouteInfo<JobDetailsRouterArgs> {
  JobDetailsRouter({
    _i35.Key? key,
    required _i38.JobModel jobModel,
    _i39.JobDetailModel? jobDetailModel,
    _i35.Widget? bottomWidget,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<JobDetailsRouterArgs> page =
      _i33.PageInfo<JobDetailsRouterArgs>(name);
}

class JobDetailsRouterArgs {
  const JobDetailsRouterArgs({
    this.key,
    required this.jobModel,
    this.jobDetailModel,
    this.bottomWidget,
  });

  final _i35.Key? key;

  final _i38.JobModel jobModel;

  final _i39.JobDetailModel? jobDetailModel;

  final _i35.Widget? bottomWidget;

  @override
  String toString() {
    return 'JobDetailsRouterArgs{key: $key, jobModel: $jobModel, jobDetailModel: $jobDetailModel, bottomWidget: $bottomWidget}';
  }
}

/// generated route for
/// [_i22.JobRequestsPage]
class JobRequestsRoute extends _i33.PageRouteInfo<void> {
  const JobRequestsRoute({List<_i33.PageRouteInfo>? children})
      : super(
          JobRequestsRoute.name,
          initialChildren: children,
        );

  static const String name = 'JobRequestsRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i23.Menu01Page]
class Menu01Route extends _i33.PageRouteInfo<void> {
  const Menu01Route({List<_i33.PageRouteInfo>? children})
      : super(
          Menu01Route.name,
          initialChildren: children,
        );

  static const String name = 'Menu01Route';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i24.Profile01Page]
class Profile01Route extends _i33.PageRouteInfo<Profile01RouteArgs> {
  Profile01Route({
    _i40.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          Profile01Route.name,
          args: Profile01RouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Profile01Route';

  static const _i33.PageInfo<Profile01RouteArgs> page =
      _i33.PageInfo<Profile01RouteArgs>(name);
}

class Profile01RouteArgs {
  const Profile01RouteArgs({this.key});

  final _i40.Key? key;

  @override
  String toString() {
    return 'Profile01RouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i25.ProfileEdit01Page]
class ProfileEdit01Route extends _i33.PageRouteInfo<ProfileEdit01RouteArgs> {
  ProfileEdit01Route({
    _i35.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          ProfileEdit01Route.name,
          args: ProfileEdit01RouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileEdit01Route';

  static const _i33.PageInfo<ProfileEdit01RouteArgs> page =
      _i33.PageInfo<ProfileEdit01RouteArgs>(name);
}

class ProfileEdit01RouteArgs {
  const ProfileEdit01RouteArgs({this.key});

  final _i35.Key? key;

  @override
  String toString() {
    return 'ProfileEdit01RouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i26.Saved01Page]
class Saved01Route extends _i33.PageRouteInfo<Saved01RouteArgs> {
  Saved01Route({
    _i35.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          Saved01Route.name,
          args: Saved01RouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Saved01Route';

  static const _i33.PageInfo<Saved01RouteArgs> page =
      _i33.PageInfo<Saved01RouteArgs>(name);
}

class Saved01RouteArgs {
  const Saved01RouteArgs({this.key});

  final _i35.Key? key;

  @override
  String toString() {
    return 'Saved01RouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i27.Search01Page]
class Search01Route extends _i33.PageRouteInfo<Search01RouteArgs> {
  Search01Route({
    _i35.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          Search01Route.name,
          args: Search01RouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Search01Route';

  static const _i33.PageInfo<Search01RouteArgs> page =
      _i33.PageInfo<Search01RouteArgs>(name);
}

class Search01RouteArgs {
  const Search01RouteArgs({this.key});

  final _i35.Key? key;

  @override
  String toString() {
    return 'Search01RouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i28.Settings01Page]
class Settings01Route extends _i33.PageRouteInfo<void> {
  const Settings01Route({List<_i33.PageRouteInfo>? children})
      : super(
          Settings01Route.name,
          initialChildren: children,
        );

  static const String name = 'Settings01Route';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i29.SettingsBeCeoPage]
class BecomeCeoRouter extends _i33.PageRouteInfo<void> {
  const BecomeCeoRouter({List<_i33.PageRouteInfo>? children})
      : super(
          BecomeCeoRouter.name,
          initialChildren: children,
        );

  static const String name = 'BecomeCeoRouter';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i30.SplashPage]
class SplashRoute extends _i33.PageRouteInfo<void> {
  const SplashRoute({List<_i33.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i31.PoliciesListPage]
class PoliciesListRoute extends _i33.PageRouteInfo<void> {
  const PoliciesListRoute({List<_i33.PageRouteInfo>? children})
      : super(
          PoliciesListRoute.name,
          initialChildren: children,
        );

  static const String name = 'PoliciesListRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i32.QuillEditorPage]
class QuillEditorRoute extends _i33.PageRouteInfo<QuillEditorRouteArgs> {
  QuillEditorRoute({
    _i35.Key? key,
    required dynamic Function(_i37.QuillController) onDone,
    _i37.QuillController? controller,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          QuillEditorRoute.name,
          args: QuillEditorRouteArgs(
            key: key,
            onDone: onDone,
            controller: controller,
          ),
          initialChildren: children,
        );

  static const String name = 'QuillEditorRoute';

  static const _i33.PageInfo<QuillEditorRouteArgs> page =
      _i33.PageInfo<QuillEditorRouteArgs>(name);
}

class QuillEditorRouteArgs {
  const QuillEditorRouteArgs({
    this.key,
    required this.onDone,
    this.controller,
  });

  final _i35.Key? key;

  final dynamic Function(_i37.QuillController) onDone;

  final _i37.QuillController? controller;

  @override
  String toString() {
    return 'QuillEditorRouteArgs{key: $key, onDone: $onDone, controller: $controller}';
  }
}
