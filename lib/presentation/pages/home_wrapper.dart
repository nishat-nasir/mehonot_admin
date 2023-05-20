import 'package:auto_route/auto_route.dart';
import 'package:mehonot_admin/presentation/widgets/appbar/search_appbar.dart';

import '../../manager/navigation/router.gr.dart';
import '../../manager/redux/states/user_state.dart';
import '../template/template.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/appbar/default_appbar.dart';
import '../widgets/no_appbar.dart';

@RoutePage(name: "GeneralWrapperRouter")
class GeneralWrapper extends StatelessWidget {
  const GeneralWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return AutoTabsScaffold(
        backgroundColor: isDark ? Colors.black : ThemeColors.gray50,
        animationCurve: Curves.easeInOutCubicEmphasized,
        resizeToAvoidBottomInset: true,
        appBarBuilder: (appBarCtx, tabsRouter) {
          logger(appBarCtx.topRoute.name, hint: '----------');
          switch (appBarCtx.topRoute.name) {
            case Home01Route.name:
              return PrsmDefaultAppBar(
                  titleText: "TestApp",
                  rightIcon: HeroIcons.user,
                  onRightIconPress: () {
                    context.pushRoute(const MyProfileRouter());
                  });
            case MyProfileRouter.name:
              return const PrsmDefaultAppBar();
            case Profile01Route.name:
              return PrsmDefaultAppBar(
                  titleText: S(context).profile,
                  rightIcon: HeroIcons.pencilSquare,
                  onRightIconPress: () {
                    context.pushRoute(ProfileEdit01Route());
                  },
                  leftIcon: HeroIcons.chevronLeft,
                  onLeftIconPress: () {
                    context.navigateBack();
                  });
            // case ProfileEdit01Route.name:
            //   return PrsmDefaultAppBar(
            //       titleText: S(context).editProfile,
            //       rightIcon: HeroIcons.plusCircle,
            //       onRightIconPress: ,
            //       leftIcon: HeroIcons.chevronLeft,
            //       onLeftIconPress: () {
            //         context.navigateBack();
            //       });
            case Saved01Route.name:
              return PrsmDefaultAppBar(titleText: S(context).savedJobs);
            case Settings01Route.name:
              return PrsmDefaultAppBar(titleText: S(context).settings);
            case MyAccountRouter.name:
              return PrsmDefaultAppBar(
                  titleText: S(context).account,
                  leftIcon: HeroIcons.chevronLeft,
                  onLeftIconPress: () {
                    context.router.popTop();
                  });
            case CeoJobCreateRouter.name:
              return PrsmDefaultAppBar(
                  titleText: S(context).postJob,
                  leftIcon: HeroIcons.xMark,
                  onLeftIconPress: () {
                    context.navigateBack();
                  });
            case CeoJobEditRouter.name:
              return PrsmDefaultAppBar(
                  titleText: "Edit Job",
                  leftIcon: HeroIcons.xMark,
                  onLeftIconPress: () {
                    context.navigateBack();
                  });
            case JobDetailsRouter.name:
              return PrsmDefaultAppBar(
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
