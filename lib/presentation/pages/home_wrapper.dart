import 'package:auto_route/auto_route.dart';

import '../../manager/navigation/router.gr.dart';
import '../../manager/redux/states/user_state.dart';
import '../template/template.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/appbar/default_appbar.dart';
import '../widgets/no_appbar.dart';

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
scaffoldKey: generalWrapperGlobalKey,
        drawer: Container(
          color: isDark ? Colors.black : ThemeColors.gray50,
          child: const Text("Drawer"),
        ),
        resizeToAvoidBottomInset: true,
        appBarBuilder: (appBarCtx, tabsRouter) {
          logger(appBarCtx.topRoute.name, hint: '----------');
          switch (appBarCtx.topRoute.name) {
            case Home01Route.name:
              return PrsmDefaultAppBar(
                generalWrapperGlobalKey:generalWrapperGlobalKey,
                  titleText: "TestApp",
                  rightIcon: HeroIcons.user,
                  onRightIconPress: () {
                    context.pushRoute(const MyProfileRouter());
                  });
            case MyProfileRouter.name:
              return  PrsmDefaultAppBar(
                generalWrapperGlobalKey:generalWrapperGlobalKey,
              );
            case Profile01Route.name:
              return PrsmDefaultAppBar(
                generalWrapperGlobalKey:generalWrapperGlobalKey,
                  titleText: S(context).profile,
                  rightIcon: HeroIcons.pencilSquare,
                  onRightIconPress: () {
                    context.pushRoute(ProfileEdit01Route());
                  },
                  leftIcon: HeroIcons.chevronLeft,
                  onLeftIconPress: () {
                    context.navigateBack();
                  });

            case Saved01Route.name:
              return PrsmDefaultAppBar(
                  generalWrapperGlobalKey:generalWrapperGlobalKey,titleText: S(context).savedJobs);
            case Settings01Route.name:
              return PrsmDefaultAppBar(
                  generalWrapperGlobalKey:generalWrapperGlobalKey,titleText: S(context).settings);
            case MyAccountRouter.name:
              return PrsmDefaultAppBar(
                generalWrapperGlobalKey:generalWrapperGlobalKey,
                  titleText: S(context).account,
                  leftIcon: HeroIcons.chevronLeft,
                  onLeftIconPress: () {
                    context.router.popTop();
                  });
            case CeoJobCreateRouter.name:
              return PrsmDefaultAppBar(
                generalWrapperGlobalKey:generalWrapperGlobalKey,
                  titleText: S(context).postJob,
                  leftIcon: HeroIcons.xMark,
                  onLeftIconPress: () {
                    context.navigateBack();
                  });
            case CeoJobEditRouter.name:
              return PrsmDefaultAppBar(
                generalWrapperGlobalKey:generalWrapperGlobalKey,
                  titleText: "Edit Job",
                  leftIcon: HeroIcons.xMark,
                  onLeftIconPress: () {
                    context.navigateBack();
                  });
            case JobDetailsRouter.name:
              return PrsmDefaultAppBar(
                generalWrapperGlobalKey:generalWrapperGlobalKey,
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
          HomePageRouter(),
          SearchRouter(),
          // MenuRouter(),
          SavedRouter(),
          SettingsRouter(),
        ],
        bottomNavigationBuilder: (bCtx, tabsRouter) {
          logger(context.routeData.name);
          switch (bCtx.topRoute.name) {
            case BecomeCeoRouter.name:
              return const SizedBox();
            case CeoJobCreateRouter.name:
              return const SizedBox();
            case Profile01Route.name:
              return const SizedBox();
            case ProfileEdit01Route.name:
              return const SizedBox();
            case JobDetailsRouter.name:
              return const SizedBox();
            case MyAccountRouter.name:
              return const SizedBox();
            case AccountChangeIdRouter.name:
              return const SizedBox();
            case CeoJobEditRouter.name:
              return const SizedBox();
            default:
              return PrsmBottomNavbar(
                onChanged: tabsRouter.setActiveIndex,
                index: tabsRouter.activeIndex,
              );
          }
        });
  }
}
