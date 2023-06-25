import 'package:auto_route/auto_route.dart';

import 'package:mehonot_admin/manager/navigation/router.gr.dart';
import 'package:mehonot_admin/presentation/pages/Dashboard/dashboard_page.dart';
import 'package:mehonot_admin/presentation/pages/Job/job_requests_page.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: "/", page: AuthRouter.page, children: [
      AutoRoute(path: "", page: SplashRoute.page),
      AutoRoute(path: "login", page: Login01Route.page),
      AutoRoute(path: "register", page: Registration01Route.page),
      AutoRoute(path: "reg-done", page: RegDone01Route.page),
      AutoRoute(path: "intro-page", page: Intro01Route.page),
      AutoRoute(path: "home", page: GeneralWrapperRouter.page, children: [
        AutoRoute(
            path: 'home-page',
            page: HomePageRouter.page,
            children: [AutoRoute(path: '', page: DashboardRoute.page)]),
        AutoRoute(path: 'job-req', page: JobReqRouter.page, children: [
          AutoRoute(path: '', page: JobRequestsRoute.page),
          AutoRoute(path: 'job-details', page: JobDetailsRouter.page)
        ]),
        AutoRoute(path: 'banner', page: BannerRouter.page, children: [
          AutoRoute(path: 'home-banners', page: BannerHomeListRoute.page),
          AutoRoute(path: 'setting-banners', page: BannerSetListRoute.page),
          AutoRoute(path: 'banner-details', page: BannerDetailsRoute.page),
          AutoRoute(path: 'banner-create', page: BannerCreateRoute.page),
          AutoRoute(path: 'banner-edit', page: BannerEditRoute.page),
        ]),
        AutoRoute(path: 'job-ads', page: JobAdsRouter.page, children: [
          AutoRoute(path: '', page: JobAdsListRoute.page),
          AutoRoute(path: 'job-ad-details', page: JobDetailsRouter.page),
          AutoRoute(path: 'job-ad-create', page: JobAdCreateRoute.page),
        ]),
        AutoRoute(path: 'feedback', page: FeedbackRouter.page, children: [
          AutoRoute(path: '', page: FeedbackListRoute.page),
        ]),
        AutoRoute(path: 'quilltest', page: QuillRouter.page, children: [
          AutoRoute(path: '', page: QuillTestRoute.page),
        ]),
      ]),
    ])
  ];
}

@RoutePage(name: 'AuthRouter')
class AuthRouterPage extends AutoRouter {}

@RoutePage(name: 'HomePageRouter')
class HomePageRouterPage extends AutoRouter {}

@RoutePage(name: 'JobReqRouter')
class JobReqRouterPage extends AutoRouter {}

@RoutePage(name: 'BannerRouter')
class BannerRouterPage extends AutoRouter {}

@RoutePage(name: 'JobAdsRouter')
class JobAdsRouterPage extends AutoRouter {}

@RoutePage(name: 'FeedbackRouter')
class FeedbackRouterPage extends AutoRouter {}

@RoutePage(name: 'QuillRouter')
class QuillTestRouterPage extends AutoRouter {}
