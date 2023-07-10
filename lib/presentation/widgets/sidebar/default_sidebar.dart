import 'package:auto_route/auto_route.dart';import 'package:flutter/services.dart';import 'package:mehonot_admin/manager/redux/states/ads_state.dart';import 'package:mehonot_admin/presentation/widgets/sidebar/sidebar_item.dart';import '../../../manager/models/User/user_profile_md.dart';import '../../../manager/navigation/router.gr.dart';import '../../../manager/redux/states/init_state.dart';import '../../../manager/redux/states/jobs_state.dart';import '../../template/template.dart';import '../../utils/constants.dart';import 'info_banner.dart';class DefaultSidebar extends StatefulWidget {  const DefaultSidebar({Key? key}) : super(key: key);  @override  State<DefaultSidebar> createState() => _DefaultSidebarState();}class _DefaultSidebarState extends State<DefaultSidebar> {  @override  Widget build(BuildContext context) {    UserProfileModel prof = appStore.state.userState.userProfileData;    return Container(        color: isDark(context) ? ThemeColors.coolgray900 : ThemeColors.white,        height: MediaQuery.of(context).size.height,        width: 500.w,        child: Column(            crossAxisAlignment: CrossAxisAlignment.start,            mainAxisAlignment: MainAxisAlignment.spaceBetween,            children: [              Column(children: [                Padding(                    padding: EdgeInsets.only(                      left: 19.w,                      top: 70.h,                      bottom: 48.h,                    ),                    child: Row(                        mainAxisAlignment: MainAxisAlignment.spaceBetween,                        children: [                          InfoBanner(                            topText: "Mehonot",                            bottomText: "${prof.firstName} ${prof.lastName}",                          ),                          Stack(children: [                            IconButton(                                tooltip: "Notifications",                                color: ThemeColors.green500,                                alignment: Alignment.centerRight,                                icon: HeroIcon(HeroIcons.bell, size: 60.h),                                onPressed: () {}), // if notification exists                            Positioned(                                right: 34.w,                                top: 34.h,                                child: Container(                                    width: 12.w,                                    height: 12.h,                                    decoration: BoxDecoration(                                        color: ThemeColors.green500,                                        borderRadius:                                            BorderRadius.circular(12.r))))                          ])                        ])),                Padding(                    padding: EdgeInsets.only(left: 14.w),                    child: Column(                        crossAxisAlignment: CrossAxisAlignment.start,                        children: [                          SizedText(                            text: "Menu",                            textStyle: ThemeTextExtraBold.k12,                          ),                          SizedBox(height: 18.h),                          SidebarItem(                            text: "Dashboard",                            icon: HeroIcons.home,                            onTap: () {                              Navigator.pop(context);                              context.navigateTo(const DashboardRoute());                            },                          ),                          SidebarItem(                            text: "Job Requests",                            icon: HeroIcons.clipboardDocumentList,                            onTap: () async {                              Navigator.pop(context);                              if (context.mounted) {                                context.navigateTo(const JobRequestsRoute());                              }                            },                          ),                          SidebarItem(                            text: "Home banners",                            icon: HeroIcons.rectangleGroup,                            onTap: () async {                              Navigator.pop(context);                              if (context.mounted) {                                context.navigateTo(const BannerHomeListRoute());                              }                            },                          ),                          SidebarItem(                            text: "Setting banners",                            icon: HeroIcons.rectangleGroup,                            onTap: () async {                              Navigator.pop(context);                              if (context.mounted) {                                context.navigateTo(const BannerSetListRoute());                              }                            },                          ),                          SidebarItem(                            text: "Job Ads",                            icon: HeroIcons.buildingOffice,                            onTap: () async {                              Navigator.pop(context);                              if (context.mounted) {                                context.navigateTo(const JobAdsRouter());                              }                            },                          ),                          SidebarItem(                            text: "Feedback",                            icon: HeroIcons.rss,                            onTap: () {                              Navigator.pop(context);                              context.navigateTo(const FeedbackRouter());                            },                          ),                          SidebarItem(                            text: "Make Policies",                            icon: HeroIcons.bookOpen,                            onTap: () async {                              bool success = await appStore                                  .dispatch(GetTermsAndPoliciesAction());                              if (success && context.mounted) {                                context.navigateTo(                                    GeneralWrapperRouter(children: const [                                  PoliciesRouter(),                                ]));                              }                            },                          ),                          SidebarItem(                            text: "Exit app",                            icon: HeroIcons.arrowRightOnRectangle,                            onTap: () {                              showDialog(                                  context: context,                                  builder: (context) {                                    return AlertDialog(                                      title: const Text("Exit app"),                                      content: const Text(                                          "Are you sure you want to exit the app?"),                                      actions: [                                        TextButton(                                            onPressed: () {                                              Navigator.of(context).pop();                                            },                                            child: const Text("Cancel")),                                        TextButton(                                            onPressed: () {                                              Navigator.of(context).pop();                                              SystemNavigator.pop();                                            },                                            child: const Text("Exit")),                                      ],                                    );                                  });                            },                          ),                        ]))              ])            ]));  }}