import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_quill/flutter_quill.dart';
import '../../../../manager/models/Ads/banner_ads/banner_md.dart';
import '../../../template/template.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/common/helper_function.dart';
import '../../../utils/constants.dart';
import '../../../widgets/photo_widgets/banner_details_image_loader.dart';

@RoutePage()
class BannerDetailsPage extends StatefulWidget {
  BannerModel banner;

  BannerDetailsPage({Key? key, required this.banner}) : super(key: key);

  @override
  State<BannerDetailsPage> createState() => _BannerDetailsPageState();
}

class _BannerDetailsPageState extends State<BannerDetailsPage> {
  QuillController quillText = QuillController.basic();

  @override
  void initState() {
    super.initState();
    convertJsonToQuillController(widget.banner.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(60.w),
        child: SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalSpace: 20,
          children: [
            SpacedRow(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SpacedColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedText(
                            text: calculateDuration(
                                widget.banner.createdAt, context),
                            textStyle: ThemeTextRegular.k10
                                .copyWith(color: ThemeColors.coolgray500)),
                        SizedText(
                            text: widget.banner.companyName,
                            textStyle: ThemeTextRegular.k10),
                      ]),
                  InkWell(
                    onTap: () {
                      context.router.popTop();
                    },
                    child: HeroIcon(HeroIcons.xMark, size: 84.h),
                  )
                ]),
            SizedBox(height: 20.h),
            Align(
                alignment: Alignment.center,
                child: BannerDetailsImageLoader(bannerModel: widget.banner)),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SpacedColumn(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      verticalSpace: 40,
                      children: [
                        Expanded(
                          child: QuillEditor(
                            maxHeight: 2000.h,
                            controller: quillText,
                            readOnly: true,
                            focusNode: FocusNode(),
                            scrollController: ScrollController(),
                            scrollable: true,
                            padding: EdgeInsets.zero,
                            autoFocus: false,
                            expands: true,
                            showCursor: false,
                          ),
                        ),
                        // SizedBox(height: 20.h),
                        // if (widget.banner.email != null ||
                        //     widget.banner.email != "")
                        //   SpacedRow(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       SizedText(
                        //           text: "Email : ",
                        //           textStyle: ThemeTextMedium.k10),
                        //       InkWell(
                        //           onTap: () async {
                        //             sendEmail(widget.banner.email!,
                        //                 Constants.emailSubFormat);
                        //           },
                        //           child: SizedText(
                        //               text: "${widget.banner.email}",
                        //               textStyle: ThemeTextSemiBold.k10.copyWith(
                        //                   color: ThemeColors.blue700))),
                        //     ],
                        //   ),
                        // if (widget.banner.website != null ||
                        //     widget.banner.website != "")
                        //   SpacedRow(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       SizedText(
                        //           text: "Website : ",
                        //           textStyle: ThemeTextMedium.k10),
                        //       InkWell(
                        //           onTap: () {
                        //             final Uri toLaunch = Uri(
                        //                 scheme: 'https',
                        //                 host: widget.banner.website);
                        //             _launchInWebViewOrVC(toLaunch);
                        //           },
                        //           child: SizedText(
                        //               text: "${widget.banner.website}",
                        //               textStyle: ThemeTextSemiBold.k10.copyWith(
                        //                   color: ThemeColors.blue700))),
                        //     ],
                        //   )
                      ])),
            )
          ],
        ));
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void sendEmail(String recipientEmail, String subject) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: recipientEmail,
      queryParameters: {
        'subject': subject,
      },
    );
    final String url = params.toString();
  }

  void convertJsonToQuillController(String jsonText) {
    String jsonString = jsonText;
    List<dynamic> jsonList = json.decode(jsonString);
    Delta delta = Delta.fromJson(jsonList);
    Document document = Document.fromJson(delta.toJson());
    setState(() {
      quillText = QuillController(
        document: document,
        selection: const TextSelection.collapsed(offset: 0),
      );
    });
  }
}
