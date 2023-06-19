import 'package:mehonot_admin/manager/redux/states/user_state.dart';
import '../../template/template.dart';

class FeedbackModal extends StatefulWidget {
  const FeedbackModal({Key? key}) : super(key: key);

  @override
  State<FeedbackModal> createState() => _FeedbackModalState();
}

class _FeedbackModalState extends State<FeedbackModal> {
  final TextEditingController _feedbackController = TextEditingController();
  double sliderValue = 0;
  String feedback = '';
  Color feedbackColor = ThemeColors.indigo600;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor:
            isDark(context) ? ThemeColors.black : ThemeColors.white,
        content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: SpacedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SpacedRow(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedText(
                          text: S(context).feedback,
                          textStyle: ThemeTextRegular.k18.copyWith(
                              color: isDark(context)
                                  ? ThemeColors.white
                                  : ThemeColors.black,
                              fontWeight: FontWeight.w600)),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: HeroIcon(
                          HeroIcons.xMark,
                          color: isDark(context)
                              ? ThemeColors.white
                              : ThemeColors.black,
                          size: 100.w,
                        ),
                      )
                    ]),
                dottedLineWidget(),
                SizedText(
                    text: S(context).feedbackComment,
                    softWrap: true,
                    textStyle: ThemeTextRegular.k10.copyWith(
                        color: isDark(context)
                            ? ThemeColors.white
                            : ThemeColors.black,
                        fontWeight: FontWeight.w400)),
                buildRating(),
                TextFormField(
                  maxLines: 5,
                  controller: _feedbackController,
                  style: ThemeTextRegular.k12.copyWith(
                      color: isDark(context)
                          ? ThemeColors.white
                          : ThemeColors.black,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      hintText: S(context).enterYourFeedback,
                      hintStyle: ThemeTextRegular.k12.copyWith(
                          color: isDark(context)
                              ? ThemeColors.white
                              : ThemeColors.black,
                          fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isDark(context)
                                  ? ThemeColors.white
                                  : ThemeColors.black,
                              width: 1.w),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SpacedRow(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 240.w,
                          height: 100.h,
                          child: PrimaryButton(
                              buttonText: S(context).dismiss,
                              buttonType: ButtonType.Ghost,
                              btnTextStyle: ThemeTextRegular.k12,
                              linkTypeBtnColor: isDark(context)
                                  ? ThemeColors.white
                                  : ThemeColors.black,
                              onPressed: () {
                                Navigator.pop(context);
                              })),
                      SizedBox(
                          width: 400.w,
                          height: 100.h,
                          child: PrimaryButton(
                              buttonText: S(context).submit,
                              buttonSize: ButtonSize.L,
                              btnTextStyle: ThemeTextRegular.k12,
                              linkTypeBtnColor: isDark(context)
                                  ? ThemeColors.white
                                  : ThemeColors.black,
                              onPressed: () {
                                submitFeedback();
                              }))
                    ])
              ],
            )));
  }

  dottedLineWidget() {
    List<Widget> list = [];
    for (int i = 0; i < 40; i++) {
      list.add(Container(
        color: ThemeColors.black,
        height: 1.h,
        width: 11.w,
      ));
    }
    return SpacedRow(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      horizontalSpace: 20.w,
      children: list,
    );
  }

  Widget buildRating() {
    return Slider(
      value: sliderValue,
      label: feedback,
      max: 3,
      min: -3,
      activeColor: feedbackColor,
      inactiveColor: ThemeColors.indigo200,
      divisions: 6,
      onChanged: (double value) {
        setState(() {
          sliderValue = value;
          switch (sliderValue.round()) {
            case 3:
              feedback =
                  "  ${sliderValue.round().toString()}⭐ ${S(context).amazing} ";
              feedbackColor = ThemeColors.green600;
              break;
            case 2:
              feedback =
                  "  ${sliderValue.round().toString()}⭐ ${S(context).excellent} ";
              feedbackColor = ThemeColors.green500;
              break;
            case 1:
              feedback =
                  "  ${sliderValue.round().toString()}⭐ ${S(context).good} ";
              feedbackColor = ThemeColors.green400;
              break;
            case 0:
              feedback =
                  "  ${sliderValue.round().toString()}⭐ ${S(context).okay} ";
              feedbackColor = ThemeColors.indigo400;
              break;
            case -1:
              feedback =
                  "  ${sliderValue.round().toString()}⭐ ${S(context).bad}";
              feedbackColor = ThemeColors.red400;
              break;
            case -2:
              feedback =
                  " ${sliderValue.round().toString()}⭐ ${S(context).veryBad} ";
              feedbackColor = ThemeColors.red500;
              break;
            case -3:
              feedback =
                  " ${sliderValue.round().toString()}⭐ ${S(context).terrible} ";
              feedbackColor = ThemeColors.red600;
              break;
          }
        });
      },
    );
  }

  Future submitFeedback() async {
    bool success = await appStore.dispatch(GetPostFeedbackAction(
        userData: appStore.state.userState.userData,
        feedback: _feedbackController.text,
        rating: sliderValue.toInt()));
    if (success) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: ThemeColors.green400,
          duration: const Duration(seconds: 1),
          content: SizedText(
              text: S(context).feedbackCommentSuccess,
              textStyle: ThemeTextRegular.k12.copyWith(
                  color: ThemeColors.green800, fontWeight: FontWeight.w400)),
        ));
      }
    }
  }
}
