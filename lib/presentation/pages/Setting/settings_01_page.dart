import 'package:auto_route/auto_route.dart';
import 'package:mehonot_admin/manager/redux/states/auth_state.dart';
import 'package:mehonot_admin/presentation/pages/Account/account_01_page.dart';
import 'package:mehonot_admin/presentation/template/template.dart';

import '../../../manager/hive_client.dart';
import '../../../manager/navigation/router.gr.dart';
import '../../widgets/toogle.dart';
import '../../widgets/user_acc_head.dart';

@RoutePage()
class Settings01Page extends StatefulWidget {
  const Settings01Page({Key? key}) : super(key: key);

  @override
  State<Settings01Page> createState() => _Settings01PageState();
}

class _Settings01PageState extends State<Settings01Page> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    double singleBoxWidth = MediaQuery
        .of(context)
        .size
        .width / 3 - 40.w;
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.all(30.w),
      child: SpacedColumn(
          verticalSpace: 28,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: SizedText(
                  text: S(context).account, textStyle: ThemeTextRegular.k16),
            ),
            UserAccountHeadWidget(
              name:
              "${appStore.state.userState.userProfileData.firstName} ${appStore
                  .state.userState.userProfileData.lastName}",
              email: appStore.state.userState.userProfileData.email,
              onTap: () {
                context.pushRoute(const MyAccountRouter());
              },
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: SizedText(
                  text: S(context).others, textStyle: ThemeTextRegular.k16),
            ),
            firstRow(singleBoxWidth),
            secRow(singleBoxWidth),
            thirdRow(singleBoxWidth),
          ]),
    );
  }

  Widget firstRow(double singleBoxWidth) {
    return SpacedRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          tab(
              width: singleBoxWidth,
              onTap: () {},
              child: SvgPicture.asset("assets/images/svg/home_icon.svg")),
          tab(
              width: singleBoxWidth,
              onTap: () async {},
              child: SpacedColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () async {
                          State state = this;
                          MehonotApp.of(state.context)
                              ?.setLocale(const Locale('en', 'US'));
                          await HiveClient.setLanguage("en");
                          await Future.delayed(
                              const Duration(milliseconds: 100));
                          setState(() {});
                        },
                        child: SizedText(
                            text: S(context).english,
                            textStyle: ThemeTextSemiBold.k16)),
                    const Divider(
                      color: ThemeColors.coolgray700,
                      thickness: 1,
                    ),
                    InkWell(
                        onTap: () async {
                          State state = this;
                          MehonotApp.of(state.context)
                              ?.setLocale(const Locale('bn', 'BD'));
                          await HiveClient.setLanguage("bn");
                          await Future.delayed(
                              const Duration(milliseconds: 100));
                          setState(() {});
                        },
                        child: SizedText(
                            text: S(context).bengali,
                            textStyle: ThemeTextSemiBold.k16)),
                  ])),
          tab(
              width: singleBoxWidth,
              onTap: () {
                context.pushRoute(const BecomeCeoRouter());
              },
              child: Center(
                  child: SizedText(
                    text: "CEO",
                    textStyle:
                    ThemeTextBold.k18.copyWith(color: ThemeColors.lightblue800),
                  )))
        ]);
  }

  Widget secRow(double singleBoxWidth) {
    isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return SpacedRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              child: Container(
                height: 260.h,
                width: singleBoxWidth * 2 + 30.w,
                decoration: BoxDecoration(
                  color: isDark ? ThemeColors.bluegray600 : ThemeColors
                      .lightblue50,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: ThemeShadows.shadowSm,
                ),
              )),
          tab(
              width: singleBoxWidth,
              onTap: () {},
              child: SvgPicture.asset(
                "assets/images/svg/share_icon.svg",
                color: ThemeColors.lightblue400,
              )),
        ]);
  }

  Widget thirdRow(double singleBoxWidth) {
    return SpacedColumn(
      verticalSpace: 24,
      children: [
        SpacedRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            longTab(
              width: singleBoxWidth * 2 + 30.w,
              onTap: () {},
              text: S(context).feedback,
              iconColor: ThemeColors.lightblue400,
            ),
            PrsmToggle(
                value: isDark,
                toggleWidth: singleBoxWidth,
                toggleHeight: 120.h,
                toggleSize: 100.h,
                onToggle: (val) {
                  setState(() {
                    isDark = val;
                  });
                }),
          ],
        ),
        SpacedRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            horizontalSpace: 100,
            children: [
              longTab(
                width: singleBoxWidth * 2 + 30.w,
                onTap: () {},
                text: S(context).about,
                iconColor: ThemeColors.yellow400,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context, builder: (context) => _logOut(context));
                },
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: ThemeColors.red500.withOpacity(0.1),
                        spreadRadius: 0.005,
                        blurRadius: 50.r,
                        offset: const Offset(0, 0) // changes position of shadow
                    )
                  ]),
                  child: HeroIcon(
                    HeroIcons.arrowRightOnRectangle,
                    color: ThemeColors.red500,
                    size: 160.h,
                    style: HeroIconStyle.solid,
                  ),
                ),
              )
            ])
      ],
    );
  }

  Widget tab({required Widget child,
    required VoidCallback onTap,
    double? height,
    double? width}) {
    isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? MehonotColorsDark.canvasColor : ThemeColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
            color: isDark ? ThemeColors.bluegray600 : ThemeColors.gray200,
            width: .5.w),
        // boxShadow: ThemeShadows.shadowSm,
      ),
      height: height ?? 260.h,
      width: width ?? 190.w,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        radius: 8.r,
        onTap: onTap,
        highlightColor: ThemeColors.white,
        splashColor: ThemeColors.white,
        child: Padding(
          padding: EdgeInsets.all(25.w),
          child: Center(child: child),
        ),
      ),
    );
  }

  Widget longTab({required double width,
    required String text,
    required Color iconColor,
    required VoidCallback onTap}) {
    isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Material(
      child: InkWell(
          onTap: onTap,
          radius: 8.r,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            height: 180.h,
            width: width,
            decoration: BoxDecoration(
              color: isDark ? MehonotColorsDark.canvasColor : ThemeColors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                  color: isDark ? ThemeColors.bluegray600 : ThemeColors.gray200,
                  width: .5.w),
              // boxShadow: ThemeShadows.shadowSm,
            ),
            child: SpacedRow(
              horizontalSpace: 16,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.w),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: iconColor.withOpacity(0.09),
                          spreadRadius: 0.005,
                          blurRadius: 10.r,
                          offset:
                          const Offset(0, 0) // changes position of shadow
                      )
                    ]),
                    child: HeroIcon(
                      HeroIcons.exclamationCircle,
                      color: iconColor,
                      style: HeroIconStyle.solid,
                      size: 100.w,
                    ),
                  ),
                ),
                SizedText(text: text, textStyle: ThemeTextBold.k18),
              ],
            ),
          )),
    );
  }

  Widget _logOut(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      alignment: Alignment.center,
      title: SizedText(
        textAlign: TextAlign.center,
        text: "${S(context).areYouSure}\n${S(context).youWantToLogout}",
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: const BorderSide(color: ThemeColors.red500)),
      actions: [
        TextButton(
            onPressed: () {
              context.popRoute();
            },
            child: SizedText(
              text: S(context).cancel,
              textStyle: ThemeTextSemiBold.k18,
            )),
        TextButton(
            onPressed: () async {
              await appStore.dispatch(GetLogoutAction());
              context.popRoute();
              context.pushRoute(const Login01Route());
            },
            child: SizedText(
              text: S(context).logout,
              textStyle:
              ThemeTextSemiBold.k18.copyWith(color: ThemeColors.red500),
            )),
      ],
    );
  }
}
