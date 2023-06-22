import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../manager/navigation/router.gr.dart';
import '../../manager/redux/states/user_state.dart';
import '../template/template.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/appbar/default_appbar.dart';
import '../widgets/no_appbar.dart';
import '../widgets/sidebar/default_sidebar.dart';

@RoutePage(name: "GeneralWrapperRouter")
class GeneralWrapper extends StatelessWidget {
  GeneralWrapper({Key? key}) : super(key: key);

  GlobalKey<ScaffoldState> generalWrapperGlobalKey = GlobalKey<ScaffoldState>();

  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return WillPopScope(
        onWillPop: () {
          return _onWillPop(context);
        },
        child: AutoTabsScaffold(
            backgroundColor: isDark ? Colors.black : ThemeColors.gray50,
            animationCurve: Curves.easeInOutCubicEmphasized,
            drawerEnableOpenDragGesture: false,
            scaffoldKey: generalWrapperGlobalKey,
            drawer: const DefaultSidebar(),
            resizeToAvoidBottomInset: true,
            appBarBuilder: (appBarCtx, tabsRouter) {
              logger(appBarCtx.topRoute.name, hint: '----------');
              switch (appBarCtx.topRoute.name) {
                case DashboardRoute.name:
                  return PrsmDefaultAppBar(
                    generalWrapperGlobalKey: generalWrapperGlobalKey,
                    titleText: "Mehonot",
                  );
                case JobRequestsRoute.name:
                  return PrsmDefaultAppBar(
                    generalWrapperGlobalKey: generalWrapperGlobalKey,
                    titleText: "Job Requests",
                  );
                case BannerHomeListRoute.name:
                  return PrsmDefaultAppBar(
                    generalWrapperGlobalKey: generalWrapperGlobalKey,
                    titleText: "Home banners",
                  );
                case BannerSetListRoute.name:
                  return PrsmDefaultAppBar(
                    generalWrapperGlobalKey: generalWrapperGlobalKey,
                    titleText: "Setting banners",
                  );

                case BannerCreateRoute.name:
                  return PrsmDefaultAppBar(
                    generalWrapperGlobalKey: generalWrapperGlobalKey,
                    titleText: "Create banner",
                    leftIcon: HeroIcons.xMark,
                    onLeftIconPress: () {
                      context.router.popTop();
                    },
                  );
                case BannerEditRoute.name:
                  return PrsmDefaultAppBar(
                    titleText: "Edit banner",
                    leftIcon: HeroIcons.xMark,
                    onLeftIconPress: () {
                      context.router.popTop();
                    },
                  );
                case FeedbackListRoute.name:
                  return PrsmDefaultAppBar(
                    generalWrapperGlobalKey: generalWrapperGlobalKey,
                    titleText: "Feedback",
                  );
                case MyAccountRouter.name:
                  return PrsmDefaultAppBar(
                      generalWrapperGlobalKey: generalWrapperGlobalKey,
                      titleText: S(context).account,
                      leftIcon: HeroIcons.chevronLeft,
                      onLeftIconPress: () {
                        context.router.popTop();
                      });
                case CeoJobCreateRouter.name:
                  return PrsmDefaultAppBar(
                      generalWrapperGlobalKey: generalWrapperGlobalKey,
                      titleText: S(context).postJob,
                      leftIcon: HeroIcons.xMark,
                      onLeftIconPress: () {
                        context.back();
                      });
                case CeoJobEditRouter.name:
                  return PrsmDefaultAppBar(
                      generalWrapperGlobalKey: generalWrapperGlobalKey,
                      titleText: "Edit Job",
                      leftIcon: HeroIcons.xMark,
                      onLeftIconPress: () {
                        context.back();
                      });
                case JobDetailsRouter.name:
                  return PrsmDefaultAppBar(
                      generalWrapperGlobalKey: generalWrapperGlobalKey,
                      titleText: "Job Details",
                      leftIcon: HeroIcons.chevronLeft,
                      onLeftIconPress: () {
                        context.back();
                      });
                case JobAdsListRoute.name:
                  return PrsmDefaultAppBar(
                      generalWrapperGlobalKey: generalWrapperGlobalKey,
                      titleText: "Job Ads");

                case JobAdCreateRoute.name:
                  return PrsmDefaultAppBar(
                      generalWrapperGlobalKey: generalWrapperGlobalKey,
                      leftIcon: HeroIcons.xMark,
                      onLeftIconPress: () {
                        context.back();
                      },
                      titleText: "Create Job Ads");
                default:
                  return const NoAppBar();
              }
            },
            routes: const [
              HomePageRouter(),
              JobReqRouter(),
              BannerRouter(),
              JobAdsRouter(),
              FeedbackRouter(),
            ]));
  }

  Future<bool> _onWillPop(BuildContext context) {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);

    timeBackPressed = DateTime.now();

    if (isExitWarning) {
      logger("NOW EXIT");
      String message = S(context).pressBackAgainToExit;
      // Fluttertoast.showToast(
      //     msg: message,
      //     fontSize: 14,
      //     backgroundColor:
      //         isDark(context) ? ThemeColors.indigo700 : ThemeColors.indigo300,
      //     textColor:
      //         isDark(context) ? ThemeColors.white : ThemeColors.indigo900);
      return Future.value(false);
    } else {
      logger("NOW EXIT NOT");
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future.value(false);
    }
  }
}
