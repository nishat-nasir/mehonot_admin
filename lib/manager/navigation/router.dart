import 'package:auto_route/auto_route.dart';

import 'package:mehonot_admin/manager/navigation/router.gr.dart';
import 'package:mehonot_admin/presentation/pages/Dashboard/dashboardPage.dart';
import 'package:mehonot_admin/presentation/pages/Job/job_requests_page.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();
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
        AutoRoute(
            path: 'job-req',
            page: JobReqRouter.page,
            children: [AutoRoute(path: '', page: JobRequestsRoute.page)]),
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
