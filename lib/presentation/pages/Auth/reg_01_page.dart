import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:mehonot_admin/manager/models/Address/address_md.dart';
import 'package:mehonot_admin/manager/models/User/user_job_relation_md.dart';
import 'package:mehonot_admin/presentation/utils/common/validators.dart';
import '../../../manager/models/User/ReqModels/user_md_req.dart';
import '../../../manager/models/User/user_profile_md.dart';
import '../../../manager/navigation/router.gr.dart';
import '../../../manager/redux/states/auth_state.dart';
import '../../template/template.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/constants.dart';
import '../../widgets/error_alert_widget.dart';

@RoutePage()
class Registration01Page extends StatefulWidget {
  const Registration01Page({Key? key}) : super(key: key);

  @override
  State<Registration01Page> createState() => _Registration01PageState();
}

class _Registration01PageState extends State<Registration01Page> {
  final GlobalKey<FormState> _formKeyRegPageNameDiv =
      GlobalKey<FormState>(debugLabel: '_formKeyRegPageNameDiv');

  final GlobalKey<FormState> _formKeyRegPagePhonePass =
      GlobalKey<FormState>(debugLabel: '_formKeyRegPagePhonePass');

  TextEditingController phoneNumController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  String errorText = "";
  bool otpSent = false;
  bool isOtpSending = false;
  int? sentOtp;
  String? verId;

  bool isOtpSent = false;
  bool isOtpCorrect = false;
  String createUserAddressDivisionString =
      Constants.locationsBd().names().first;
  Division createUserAddressDivisionDivision =
      convertStringToDivision(Constants.locationsBd().names().first);

  int regStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.w),
            child: Center(
              child: SpacedColumn(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  verticalSpace: 54.h,
                  children: [
                    SizedText(
                        text: S(context).signUp,
                        textStyle: ThemeTextExtraBold.k34),
                    SizedBox(height: 100.h),
                    if (regStep == 0) userSetupDetails_1(),
                    if (regStep == 1) userSetupDetails_2()
                  ]),
            )));
  }

  Widget userSetupDetails_1() {
    return Form(
        key: _formKeyRegPageNameDiv,
        child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalSpace: 54.h,
            children: [
              SizedText(text: S(context).firstName),
              PrsmInputField(
                  enableShadow: false,
                  defaultBorderColor: isDark(context)
                      ? PrsmColorsLight.primaryColor
                      : ThemeColors.coolgray200,
                  controller: firstNameController,
                  hintText: S(context).firstName,
                  validator: Validator(context).validateOnlyWords,
                  leftIcon: HeroIcons.user),
              SizedBox(height: 10.w),
              SizedText(text: S(context).lastName),
              PrsmInputField(
                  enableShadow: false,
                  defaultBorderColor: isDark(context)
                      ? PrsmColorsLight.primaryColor
                      : ThemeColors.coolgray200,
                  controller: lastNameController,
                  validator: Validator(context).validateOnlyWords,
                  hintText: S(context).lastName,
                  leftIcon: HeroIcons.user),
              SizedBox(height: 10.w),
              SizedText(text: S(context).division),
              SizedBox(
                  height: 140.h,
                  width: MediaQuery.of(context).size.width - 100.w,
                  child: PrsmDropdown(
                      enableShadow: false,
                      enableBorder: true,
                      listValues: Constants.locationsBd().names(),
                      value: createUserAddressDivisionString,
                      onChanged: (value) {
                        setState(() {
                          createUserAddressDivisionString = value;
                          createUserAddressDivisionDivision =
                              convertStringToDivision(value);
                        });
                      })),
              SizedBox(height: 100.h),
              PrimaryButton(
                  buttonText: S(context).nextStep, onPressed: () => nextStep()),
              SizedBox(height: 50.h),
              Center(
                  child: PrimaryButton(
                      buttonText: S(context).cancel,
                      buttonType: ButtonType.Ghost,
                      buttonSize: ButtonSize.M,
                      icon: HeroIcons.home,
                      onPressed: () {
                        appRouter.replace(const Login01Route());
                      }))
            ]));
  }

  Widget userSetupDetails_2() {
    return Form(
        key: _formKeyRegPagePhonePass,
        child: SpacedColumn(verticalSpace: 54.h, children: [
          if (!otpSent)
            PrsmInputField(
                enableShadow: false,
                defaultBorderColor: isDark(context)
                    ? PrsmColorsLight.primaryColor
                    : ThemeColors.coolgray200,
                controller: phoneNumController,
                width: 300.w,
                disableAll: isOtpSending,
                hintText: S(context).phoneNumber,
                formatter: [
                  MaskedInputFormatter('00000000000',
                      allowedCharMatcher: RegExp(r'[0-9]'))
                ],
                validator: kDebugMode
                    ? Validator(context).validateField
                    : Validator(context).validatePhone,
                leftIcon: HeroIcons.phone),
          if (!otpSent)
            PrsmInputField(
                enableShadow: false,
                defaultBorderColor: isDark(context)
                    ? PrsmColorsLight.primaryColor
                    : ThemeColors.coolgray200,
                controller: passController,
                width: 300.w,
                disableAll: isOtpSending,
                hintText: S(context).password,
                validator: Validator(context).validatePassword,
                isPassword: true),
          if (!otpSent)
            PrsmInputField(
                enableShadow: false,
                defaultBorderColor: isDark(context)
                    ? PrsmColorsLight.primaryColor
                    : ThemeColors.coolgray200,
                controller: confirmPassController,
                width: 300.w,
                validator: (value) {
                  if (value != passController.text) {
                    return S(context).passwordsDoNotMatch;
                  }
                  return null;
                },
                disableAll: isOtpSending,
                hintText: "${S(context).confirm} ${S(context).confirm}",
                isPassword: true),
          if (otpSent)
            PrsmInputField(
                enableShadow: false,
                defaultBorderColor: isDark(context)
                    ? PrsmColorsLight.primaryColor
                    : ThemeColors.coolgray200,
                width: 300.w,
                controller: otpController,
                formatter: [
                  MaskedInputFormatter('000000',
                      allowedCharMatcher: RegExp(r'[0-9]'))
                ],
                isRequired: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S(context).fieldCanNotEmpty;
                  } else if (value.length < 6) {
                    return S(context).otpMustBe6Digit;
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                hintText: S(context).otp),
          SizedBox(height: 32.h),
          if (errorText.isNotEmpty)
            AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: 1.0,
                child: AlertOrigin(
                  text: errorText,
                )),
          // if (!isOtpSending || !otpSent)
          if (!otpSent)
            PrimaryButton(
                buttonText: S(context).otpSent,
                isLoading: isOtpSent,
                onPressed: () async {
                  if (_formKeyRegPagePhonePass.currentState!.validate()) {
                    //TODO: Add Otp Sending
                    //TODO: Now I don't have a phone
                    // _onSendOtp();
                    bool isExist = await appStore.dispatch(
                        GetCheckPhoneNumExistsAction(
                            phoneNumber: phoneNumController.text));
                    if (!isExist) {
                      setState(() {
                        // isOtpSending = true;
                        errorText = "";
                        otpSent = true;
                      });
                      nextStep();
                    } else {
                      setState(() {
                        errorText = S(context).numberAlreadyExist;
                      });
                    }
                  }
                }),
          if (otpSent)
            PrimaryButton(
                buttonText: S(context).verifyOtp,
                //TODO: Add Otp Verification(enteringSmsCode)
                // onPressed: () => enteringSmsCode(otpController.text))
                onPressed: () => signUpPress())
        ]));
  }

  _onSendOtp() async {
    setState(() {
      isOtpSending = true;
    });
    String phNum = phoneNumController.text;
    if (!phNum.startsWith('0')) {
      phNum = "+820${phoneNumController.text}";
    }
    logger("Phone Number: $phNum");
    // bool userExists = await appStore
    //     .dispatch(GetCheckPhoneNumExistsAction(phoneNumber: phNum));
    bool userExists = false;
    if (!userExists) {
      setState(() {
        errorText = "";
      });
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          // phoneNumber: "+880$phNum",
          phoneNumber: "+82$phNum",
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            errorText = e.message.toString();
            setState(() {
              isOtpSending = false;
              isOtpSent = false;
            });
          },
          forceResendingToken: sentOtp,
          timeout: const Duration(milliseconds: 20000),
          codeSent: (String verificationId, int? resendToken) async {
            setState(() {
              isOtpSent = true;
              isOtpSending = false;
              sentOtp = resendToken;
              verId = verificationId;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            setState(() {
              isOtpSending = false;
              verId = verificationId;
            });
          },
        );
      } catch (e) {
        closeLoadingDialog();
        setState(() {
          isOtpSent = false;
        });
      }
    } else {
      setState(() {
        isOtpSending = false;
        errorText = S(context).numberAlreadyExist;
      });
    }
  }

  //TODO: Add enteringSmsCode check
  //TODO: Now I don't have a phone
  enteringSmsCode(value) async {
    // String phoneNumber = "+88${phoneNumController.text}";
    String phoneNumber = "+82${phoneNumController.text}";
    if (phoneNumController.text.startsWith("0")) {
      // phoneNumber = "+88${phoneNumController.text.substring(1)}";
      phoneNumber = "+82${phoneNumController.text.substring(1)}";
    }
    if (value.toString().length == 6) {
      String smsCode = value;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verId!, smsCode: smsCode);
      final res = await FirebaseAuth.instance.signInWithCredential(credential);
      if (res.user != null) {
        if (res.user!.phoneNumber == phoneNumber) {
          setState(() {
            isOtpCorrect = true;
          });
          signUpPress();
        }
      }
    }
  }

  signUpPress() async {
    bool registeredComplete = false;
    String phNum = phoneNumController.text;
    if (!phNum.startsWith('0')) {
      phNum = "0${phoneNumController.text}";
    }
    //TODO: Check if match the number with the otp

    logger("CALLING_REGISTER");
    logger(
        "${phNum} ${passController.text} ${firstNameController.text} ${lastNameController.text} ${createUserAddressDivisionString}");
    registeredComplete = await appStore.dispatch(GetRegisterAction(
      userModelReq: UserModelReq(
        phoneNumber: phNum,
        password: passController.text,
        isAdmin: false,
      ),
      userProfileModelReq: UserProfileModel(
        userId: "",
        userProfileId: "",
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: "",
        contactNumber: "",
        profileImage: "",
        createdDate: DateTime.now().toString(),
        address: AddressModel(
            area: "",
            city: "",
            district: "",
            division: createUserAddressDivisionString),
        birthday: "",
        positionTitle: "",
        bio: "",
        userJobRelationId: '',
      ),
      userJobRelationMd: UserJobRelationMd(
          userProfileId: '',
          savedJobsIds: [],
          appliedJobsIds: [],
          myJobsIds: []),
    ));
    // if (matched) { // if OTP Match then put in the DB
    if (registeredComplete) {
      appRouter.replace(const RegDone01Route());
    }
  }

  changeDivisionList(String value) {
    createUserAddressDivisionString = value;
    setState(() {
      createUserAddressDivisionDivision = convertStringToDivision(value);
    });
  }

  void nextStep() {
    if (_formKeyRegPageNameDiv.currentState!.validate()) {
      setState(() {
        regStep++;
      });
    } else {
      return;
    }
  }

  void prevStep() {
    setState(() {
      regStep--;
    });
  }
}
