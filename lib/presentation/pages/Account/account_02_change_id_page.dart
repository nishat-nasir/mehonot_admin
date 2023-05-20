import 'package:auto_route/auto_route.dart';import 'package:flutter/foundation.dart';import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';import '../../../manager/redux/states/auth_state.dart';import '../../template/template.dart';import '../../utils/common/validators.dart';import '../../widgets/error_alert_widget.dart';@RoutePage(name: "AccountChangeIdRouter")class Account02ChangeIdPage extends StatefulWidget {  const Account02ChangeIdPage({Key? key}) : super(key: key);  @override  State<Account02ChangeIdPage> createState() => _Account02ChangeIdPageState();}class _Account02ChangeIdPageState extends State<Account02ChangeIdPage> {  final TextEditingController _newPhoneNumCntr = TextEditingController();  final TextEditingController _passCntr = TextEditingController();  final TextEditingController _otpCntr = TextEditingController();  final GlobalKey<FormState> _formKeyChangeId =      GlobalKey<FormState>(debugLabel: '_formKeyChangeId');  String errorText = "";  bool otpSent = false;  bool isOtpSending = false;  int? sentOtp;  String? verId;  bool isOtpSent = false;  bool isOtpCorrect = false;  int regStep = 0;  @override  Widget build(BuildContext context) {    return Padding(        padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 30.h),        child: SpacedColumn(          crossAxisAlignment: CrossAxisAlignment.center,          mainAxisAlignment: MainAxisAlignment.spaceBetween,          children: [            SpacedRow(                crossAxisAlignment: CrossAxisAlignment.center,                mainAxisAlignment: MainAxisAlignment.spaceBetween,                children: [                  SizedText(                    text: S(context).changeId,                    textStyle: ThemeTextRegular.k18,                  ),                  IconButton(                      onPressed: () {                        context.router.popTop();                      },                      icon: HeroIcon(HeroIcons.xMark, size: 84.h))                ]),            Form(                key: _formKeyChangeId,                child: Padding(                    padding: EdgeInsets.symmetric(horizontal: 10.w),                    child: Center(                        child: SpacedColumn(                            crossAxisAlignment: CrossAxisAlignment.start,                            verticalSpace: 16,                            children: [                          if (!otpSent) SizedText(text: S(context).phoneNumber),                          if (!otpSent)                            PrsmInputField(                                enableShadow: false,                                defaultBorderColor: isDark(context)                                    ? MehonotColorsLight.primaryColor                                    : ThemeColors.coolgray200,                                controller: _newPhoneNumCntr,                                width: 300.w,                                disableAll: isOtpSending,                                hintText: S(context).phoneNumber,                                formatter: [                                  MaskedInputFormatter('00000000000',                                      allowedCharMatcher: RegExp(r'[0-9]'))                                ],                                validator: kDebugMode                                    ? Validator(context).validateField                                    : Validator(context).validatePhone,                                leftIcon: HeroIcons.phone),                          SizedBox(height: 40.h),                          if (!otpSent)                            SizedText(                              text: S(context).password,                            ),                          if (!otpSent)                            PrsmInputField(                                enableShadow: false,                                defaultBorderColor: isDark(context)                                    ? MehonotColorsLight.primaryColor                                    : ThemeColors.coolgray200,                                controller: _passCntr,                                width: 300.w,                                disableAll: isOtpSending,                                hintText: S(context).password,                                validator: Validator(context).validatePassword,                                isPassword: true),                          SizedBox(height: 40.h),                          if (otpSent) SizedText(text: S(context).otp),                          if (otpSent)                            PrsmInputField(                                enableShadow: false,                                defaultBorderColor: isDark(context)                                    ? MehonotColorsLight.primaryColor                                    : ThemeColors.coolgray200,                                width: 300.w,                                controller: _otpCntr,                                formatter: [                                  MaskedInputFormatter('000000',                                      allowedCharMatcher: RegExp(r'[0-9]'))                                ],                                isRequired: true,                                validator: (value) {                                  if (value!.isEmpty) {                                    return S(context).fieldCanNotEmpty;                                  } else if (value.length < 6) {                                    return S(context).otpMustBe6Digit;                                  }                                  return null;                                },                                keyboardType: TextInputType.number,                                hintText: S(context).otp),                          SizedBox(height: 32.h),                          if (errorText.isNotEmpty)                            AnimatedOpacity(                                duration: const Duration(milliseconds: 300),                                opacity: 1.0,                                child: AlertOrigin(                                  text: errorText,                                )), // if (!isOtpSending || !otpSent)                        ])))),            if (!otpSent)              Padding(                  padding: EdgeInsets.symmetric(horizontal: 40.w),                  child: PrimaryButton(                      buttonText: S(context).otpSent,                      isLoading: isOtpSent,                      onPressed: () async {                        if (_formKeyChangeId.currentState!.validate()) {                          //TODO: Add Otp Sending //TODO: Now I don't have a phone // _onSendOtp(); //                          bool isExist = await appStore.dispatch(                              GetCheckPhoneNumExistsAction(                                  phoneNumber: _newPhoneNumCntr.text));                          if (!isExist) {                            setState(() {                              // isOtpSending = true;                              errorText = "";                              otpSent = true;                            });                            nextStep();                          } else {                            setState(() {                              errorText = S(context).numberAlreadyExist;                            });                          }                        }                      })),            if (otpSent)              Padding(                  padding: EdgeInsets.symmetric(horizontal: 40.w),                  child: PrimaryButton(                      buttonText: S(context).verifyOtp,                      //TODO: Add Otp Verification(enteringSmsCode) // onPressed: () => enteringSmsCode(otpController.text))                      onPressed: () => changeId()))          ],        ));  }  void changeId() {}  void nextStep() {    if (_formKeyChangeId.currentState!.validate()) {      setState(() {        regStep++;      });    } else {      return;    }  }  void prevStep() {    setState(() {      regStep--;    });  }}