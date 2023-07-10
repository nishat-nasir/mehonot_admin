import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:mehonot_admin/presentation/pages/Policies/policies_list_page.dart';

import '../../manager/navigation/router.gr.dart';
import '../template/template.dart';
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
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: SafeArea(
          child: AutoTabsScaffold(
              backgroundColor: isDark ? Colors.black : ThemeColors.gray50,
              animationCurve: Curves.easeInOutCubicEmphasized,
              drawerEnableOpenDragGesture: false,
              scaffoldKey: generalWrapperGlobalKey,
              drawer: const DefaultSidebar(),
              resizeToAvoidBottomInset: true,
              onDrawerChanged: (isDrawerOpen) {
                if (isDrawerOpen) {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                }
              },
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
                      leftIcon: HeroIcons.chevronLeft,
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
                  case PoliciesListRoute.name:
                    return PrsmDefaultAppBar(
                      generalWrapperGlobalKey: generalWrapperGlobalKey,
                      titleText: "Policies",
                    );
                  case QuillTestRoute.name:
                    return PrsmDefaultAppBar(
                      generalWrapperGlobalKey: generalWrapperGlobalKey,
                      leftIcon: HeroIcons.xMark,
                      titleText: "Quil Test",
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
                PoliciesRouter(),
                QuillRouter(),
              ]),
        ));
  }
}
