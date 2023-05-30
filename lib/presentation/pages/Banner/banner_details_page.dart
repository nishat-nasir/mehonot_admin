import 'package:auto_route/annotations.dart';import 'package:cloud_firestore/cloud_firestore.dart';import 'package:mehonot_admin/manager/models/Banner/banner_md.dart';import '../../template/template.dart';import 'package:url_launcher/url_launcher.dart';import '../../utils/common/helper_function.dart';import '../../utils/constants.dart';@RoutePage()class BannerDetailsPage extends StatefulWidget {  BannerModel banner;  BannerDetailsPage({Key? key, required this.banner}) : super(key: key);  @override  State<BannerDetailsPage> createState() => _BannerDetailsPageState();}class _BannerDetailsPageState extends State<BannerDetailsPage> {  @override  Widget build(BuildContext context) {    return Padding(        padding: EdgeInsets.all(60.w),        child: SingleChildScrollView(            child: SpacedColumn(              crossAxisAlignment: CrossAxisAlignment.start,              verticalSpace: 20,              children: [                SizedText(                    text: calculateDuration(widget.banner.createdAt),                    textStyle: ThemeTextRegular.k14                        .copyWith(color: ThemeColors.coolgray500)),                SizedText(                    text: widget.banner.companyName,                    textStyle: ThemeTextLight.k10),                Align(                    alignment: Alignment.center,                    child: ClipRRect(                        borderRadius: BorderRadius.circular(10),                        child: Image.network(                          widget.banner.image,                          width: 300,                          height: 200,                          fit: BoxFit.cover,                        ))),                Padding(                    padding: EdgeInsets.symmetric(horizontal: 20.w),                    child: SpacedColumn(                        mainAxisAlignment: MainAxisAlignment.start,                        crossAxisAlignment: CrossAxisAlignment.start,                        verticalSpace: 40,                        children: [                          SizedBox(height: 10.h),                          SizedText(                              text: widget.banner.title,                              textStyle: ThemeTextBold.k12),                          SizedText(                              text: widget.banner.description,                              softWrap: true,                              textStyle: ThemeTextRegular.k10),                          SizedBox(height: 20.h),                          if (widget.banner.email != null ||                              widget.banner.email != "")                            SpacedRow(                              crossAxisAlignment: CrossAxisAlignment.center,                              children: [                                SizedText(                                    text: "Email : ",                                    textStyle: ThemeTextMedium.k10),                                InkWell(                                    onTap: () async {                                      sendEmail(widget.banner.email!,                                          Constants.emailSubFormat);                                    },                                    child: SizedText(                                        text: "${widget.banner.email}",                                        textStyle: ThemeTextSemiBold.k10                                            .copyWith(color: ThemeColors                                            .blue700))),                              ],                            ),                          if (widget.banner.website != null ||                              widget.banner.website != "")                            SpacedRow(                              crossAxisAlignment: CrossAxisAlignment.start,                              children: [                                SizedText(                                    text: "Website : ",                                    textStyle: ThemeTextMedium.k10),                                InkWell(                                    onTap: () {                                      final Uri toLaunch = Uri(                                          scheme: 'https',                                          host: widget.banner.website);                                      _launchInWebViewOrVC(toLaunch);                                    },                                    child: SizedText(                                        text: "${widget.banner.website}",                                        textStyle: ThemeTextSemiBold.k10                                            .copyWith(color: ThemeColors                                            .blue700))),                              ],                            )                        ]))              ],            )));  }  Future<void> _launchInWebViewOrVC(Uri url) async {    if (!await launchUrl(      url,      mode: LaunchMode.inAppWebView,      webViewConfiguration: const WebViewConfiguration(          headers: <String, String>{'my_header_key': 'my_header_value'}),    )) {      throw Exception('Could not launch $url');    }  }  void sendEmail(String recipientEmail, String subject) async {    final Uri params = Uri(      scheme: 'mailto',      path: recipientEmail,      queryParameters: {        'subject': subject,      },    );    final String url = params.toString();  }}