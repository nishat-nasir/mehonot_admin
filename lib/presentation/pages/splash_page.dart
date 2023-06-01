import 'package:auto_route/auto_route.dart';
import 'dart:developer';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../manager/redux/states/init_state.dart';
import '../template/template.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  DateTime timeBackPressed = DateTime.now();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(_load);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            body: Container(
                color: isDark(context)
                    ? ThemeColors.coolgray900
                    : ThemeColors.white,
                alignment: Alignment.center,
                child: SpacedColumn(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalSpace: 60,
                    children: [
                      SizedText(
                        text: "Salam\nAdmin",
                        textStyle: ThemeTextExtraBold.k28,
                      ),
                      SizedBox(
                          width: 140.w,
                          height: 140.w,
                          child: CircularProgressIndicator(
                            color: ThemeColors.lightblue600,
                            strokeWidth: 20.w,
                            backgroundColor: ThemeColors.lightblue100,
                            semanticsValue: 'Loading...',
                          ))
                    ]))));
  }

  Future<void> _load(Duration timeStamp) async {
    const totalSteps = '1';

    log('\nGet State INIT [1/$totalSteps]');
    appStore.dispatch(GetStateInitAction());
  }

  Future<bool> _onWillPop() {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);

    timeBackPressed = DateTime.now();

    if (isExitWarning) {
      const message = 'Press back again to exit';
      Fluttertoast.showToast(
          msg: message,
          fontSize: 18,
          backgroundColor: ThemeColors.white,
          textColor: ThemeColors.bluegray800);
      return Future.value(false);
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future.value(false);
    }
  }
}
