import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../manager/navigation/router.gr.dart';
import '../../../manager/redux/states/auth_state.dart';
import '../../template/template.dart';
import '../../utils/common/validators.dart';
import '../../utils/constants.dart';
import '../../widgets/error_alert_widget.dart';

@RoutePage()
class Login01Page extends StatefulWidget {
  const Login01Page({Key? key}) : super(key: key);

  @override
  State<Login01Page> createState() => _Login01PageState();
}

class _Login01PageState extends State<Login01Page> {
  final GlobalKey<FormState> _formKeyLoginPage =
      GlobalKey<FormState>(debugLabel: '_formKeyLoginPage');

  TextEditingController phoneNumController =
      TextEditingController(text: kDebugMode ? "01011111111" : "");
  TextEditingController pwController =
      TextEditingController(text: kDebugMode ? "Test123!" : "");

  DateTime timeBackPressed = DateTime.now();
  String errorText = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
            backgroundColor: isDark(context)
                ? MehonotColorsDark.canvasColor
                : MehonotColorsLight.canvasColor,
            body: Form(
                key: _formKeyLoginPage,
                child: Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: SpacedColumn(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            verticalSpace: 54.h,
                            children: [
                              SizedText(
                                  text: Constants.appName,
                                  textStyle: ThemeTextExtraBold.k48),
                              const SizedBox(),
                              PrsmInputField(
                                  controller: phoneNumController,
                                  width: 300.w,
                                  enableShadow: false,
                                  defaultBorderColor: isDark(context)
                                      ? MehonotColorsLight.primaryColor
                                      : ThemeColors.coolgray200,
                                  isRequired: true,
                                  keyboardType: TextInputType.phone,
                                  formatter: [
                                    MaskedInputFormatter('00000000000',
                                        allowedCharMatcher: RegExp(r'[0-9]'))
                                  ],
                                  validator: Validator(context).validatePhone,
                                  hintText: S(context).phoneNumber,
                                  leftIcon: HeroIcons.phone),
                              PrsmInputField(
                                controller: pwController,
                                width: 300.w,
                                enableShadow: false,
                                defaultBorderColor: isDark(context)
                                    ? MehonotColorsLight.primaryColor
                                    : ThemeColors.coolgray200,
                                hintText: S(context).password,
                                validator: Validator(context).validateField,
                                isPassword: true,
                              ),
                              SpacedRow(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: onForgotPasswordPress(context),
                                      child: SizedText(
                                          text: S(context).forgotPassword,
                                          textStyle: ThemeTextRegular.k12),
                                    ),
                                    InkWell(
                                      onTap: () => onSignUpPress(context),
                                      child: SizedText(
                                          text: S(context).signUp,
                                          textStyle: ThemeTextRegular.k12),
                                    ),
                                  ]),
                              SizedBox(height: 32.h),
                              if (errorText.isNotEmpty)
                                AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: 1.0,
                                    child: AlertOrigin(
                                      text: errorText,
                                    )),
                              PrimaryButton(
                                  buttonText: S(context).login,
                                  isLoading: isLoading,
                                  onPressed: () => onLoginPress(context)),
                            ]))))));
  }

  onLoginPress(BuildContext context) async {
    setState(() {
      errorText = "";
    });

    if (_formKeyLoginPage.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String phNum = phoneNumController.text;
      if (!phNum.startsWith('0')) {
        phNum = "0${phoneNumController.text}";
      }
      bool matched = await appStore.dispatch(
          GetLoginAction(phoneNumber: phNum, password: pwController.text));

      if (matched) {
        setState(() {
          isLoading = false;
        });
        await appRouter.replace(const GeneralWrapperRouter());
      }
      if (!matched) {
        setState(() {
          isLoading = false;
          errorText = S(context).loginError + S(context).pleaseTryAgain;
        });
      }
    }
  }

  onSignUpPress(BuildContext context) {
    context.pushRoute(const Registration01Route());
  }

  onForgotPasswordPress(BuildContext context) {
    // Route to Forgot pass page
  }

  Future<bool> onWillPop() {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);

    timeBackPressed = DateTime.now();

    if (isExitWarning) {
      String message = S(context).pressBackAgainToExit;
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
