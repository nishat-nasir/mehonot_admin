import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mehonot_admin/presentation/template/theme/theme_color.dart';
import 'package:mehonot_admin/presentation/template/theme/theme_constants.dart';
import 'package:mehonot_admin/presentation/template/theme/theme_size_style.dart';
import 'package:mehonot_admin/presentation/utils/common/helpers.dart';
import 'package:mehonot_admin/presentation/utils/common/log_tester.dart';
import 'package:mehonot_admin/presentation/utils/constants.dart';
import 'generated/rf_fit/l10n.dart';
import 'manager/navigation/router.dart';
import 'manager/redux/sets/app_state.dart';

final appRouter = AppRouter();

class MehonotApp extends StatefulWidget {
  const MehonotApp({Key? key}) : super(key: key);

  @override
  State<MehonotApp> createState() => MehonotAppState();

  static MehonotAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MehonotAppState>();
}

class MehonotAppState extends State<MehonotApp> with WidgetsBindingObserver {
  Locale _locale = const Locale("en");
  DateTime timeBackPressed = DateTime.now();

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return _onWillPop(context);
        },
        child: StoreProvider(
          store: appStore,
          child: ScreenUtilInit(
            designSize: const Size(
                ThemeSizeStyle.screenWidth, ThemeSizeStyle.screenHeight),
            builder: (BuildContext context, Widget? child) =>
                MaterialApp.router(
              builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
                  child: child!),
              debugShowCheckedModeBanner: kDebugMode,
              theme: lightTheme,
              darkTheme: darkTheme,
              routerDelegate: AutoRouterDelegate(
                appRouter,
                navigatorObservers: () => [_DefaultObserver()],
              ),
              routeInformationParser: appRouter.defaultRouteParser(),
              localizationsDelegates: const [
                AppIntl.delegate,
              ],
              locale: _locale,
              title: Constants.appName,
              supportedLocales: const [Locale('en'), Locale('bn')],
              localeResolutionCallback: (locale, supportedLocales) {
                locale = const Locale('en');
                for (Locale i in supportedLocales) {
                  if (i.languageCode == locale.languageCode) {
                    return locale;
                  }
                }
                return supportedLocales.first;
              },
            ),
          ),
        ));
  }

  Future<bool> _onWillPop(BuildContext context) {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);

    timeBackPressed = DateTime.now();

    if (isExitWarning) {
      logger("NOW EXIT");
      String message = S(context).pressBackAgainToExit;
      Fluttertoast.showToast(
          msg: message,
          fontSize: 14,
          backgroundColor:
              isDark(context) ? ThemeColors.indigo700 : ThemeColors.indigo300,
          textColor:
              isDark(context) ? ThemeColors.white : ThemeColors.indigo900);
      return Future.value(false);
    } else {
      logger("NOW EXIT NOT");
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future.value(false);
    }
  }
}

class _DefaultObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    logger('New route pushed: ${route.settings.name}', hint: 'Push');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    logger('Route popped: ${route.settings.name}', hint: 'Pop');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    logger(
        'Route replaced: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}',
        hint: 'Replace');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    logger('Tab route re-visited: ${route.name}', hint: 'Tab Change');
    // if (route.name == "HomePageRouter") {
    //   appStore.dispatch(GetJobsAction(
    //       division: convertStringToDivision(
    //           appStore.state.userState.userProfileData.address.division)));
    // }
  }
}
