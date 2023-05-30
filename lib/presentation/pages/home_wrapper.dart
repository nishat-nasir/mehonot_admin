import 'package:auto_route/auto_route.dart';

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

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return AutoTabsScaffold(
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
                titleText: "Mehnat",
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
                    context.navigateBack();
                  });
            case CeoJobEditRouter.name:
              return PrsmDefaultAppBar(
                  generalWrapperGlobalKey: generalWrapperGlobalKey,
                  titleText: "Edit Job",
                  leftIcon: HeroIcons.xMark,
                  onLeftIconPress: () {
                    context.navigateBack();
                  });
            case JobDetailsRouter.name:
              return PrsmDefaultAppBar(
                  generalWrapperGlobalKey: generalWrapperGlobalKey,
                  titleText: "Job Details",
                  leftIcon: HeroIcons.chevronLeft,
                  onLeftIconPress: () {
                    context.navigateBack();
                  });
            default:
              return const NoAppBar();
          }
        },
        routes: const [
          // HomePageRouter(),
          // SearchRouter(),
          // MenuRouter(),
          // SavedRouter(),
          // SettingsRouter(),

          HomePageRouter(),
          JobReqRouter(),
          BannerRouter(),
          FeedbackRouter(),
        ]);
  }
}
