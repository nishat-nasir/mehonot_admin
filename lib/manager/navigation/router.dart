import 'package:auto_route/auto_route.dart';

import 'package:mehonot_admin/manager/navigation/router.gr.dart';


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
        AutoRoute(path: '', page: HomePageRouter.page, children: [
          AutoRoute(path: '', page: Home01Route.page),
          AutoRoute(path: 'my-profile', page: MyProfileRouter.page, children: [
            AutoRoute(path: "", page: Profile01Route.page),
            AutoRoute(path: "editProfile", page: ProfileEdit01Route.page),
          ]),
          AutoRoute(path: "jobDetailsPage", page: JobDetailsRouter.page),
        ]),
        AutoRoute(path: "search", page: SearchRouter.page, children: [
          AutoRoute(path: "", page: Search01Route.page),
        ]),
        AutoRoute(path: "menu", page: MenuRouter.page, children: [
          AutoRoute(path: "", page: Menu01Route.page),
        ]),
        AutoRoute(path: "saved", page: SavedRouter.page, children: [
          AutoRoute(path: "", page: Saved01Route.page),
        ]),
        AutoRoute(path: "settings", page: SettingsRouter.page, children: [
          AutoRoute(path: "", page: Settings01Route.page),
          AutoRoute(path: "become-ceo", page: BecomeCeoRouter.page),
          AutoRoute(path: "ceo-job-create", page: CeoJobCreateRouter.page),
          AutoRoute(path: "my-account", page: MyAccountRouter.page),
          AutoRoute(path: "ceo-job-edit", page: CeoJobEditRouter.page),
          AutoRoute(
              path: "account-change-id", page: AccountChangeIdRouter.page),
        ]),
      ]),
    ]),
  ];
}

@RoutePage(name: 'AuthRouter')
class AuthRouterPage extends AutoRouter {}

@RoutePage(name: 'HomePageRouter')
class HomePageRouterPage extends AutoRouter {}

@RoutePage(name: 'MyProfileRouter')
class MyProfileRouterPage extends AutoRouter {}

@RoutePage(name: 'SearchRouter')
class SearchRouterPage extends AutoRouter {}

@RoutePage(name: 'MenuRouter')
class MenuRouterrPage extends AutoRouter {}

@RoutePage(name: 'SavedRouter')
class SavedRouterPage extends AutoRouter {}

@RoutePage(name: 'SettingsRouter')
class SettingsRouterPage extends AutoRouter {}
