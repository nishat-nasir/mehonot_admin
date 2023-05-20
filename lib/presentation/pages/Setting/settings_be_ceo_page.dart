import 'package:auto_route/auto_route.dart';
import 'package:lottie/lottie.dart';

import '../../../manager/navigation/router.gr.dart';
import '../../template/template.dart';

@RoutePage(name: "BecomeCeoRouter")
class SettingsBeCeoPage extends StatelessWidget {
  const SettingsBeCeoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Padding(
          padding: EdgeInsets.only(right: 30.w, bottom: 10.h),
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  context.router.popTop();
                },
                icon: HeroIcon(HeroIcons.xMark, size: 84.h)),
          ),
        ),
        SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/create_post.json'),
              const SizedBox(height: 40),
              SizedText(
                text: S(context).postJobHereMsg,
                height: 300.h,
                width: MediaQuery.of(context).size.width - 200.w,
                softWrap: true,
                textAlign: TextAlign.center,
                textStyle: ThemeTextSemiBold.k16,
              ),
              PrimaryButton(
                  buttonText: S(context).postJob,
                  buttonSize: ButtonSize.L3,
                  onPressed: () {
                    context.pushRoute(CeoJobCreateRouter());
                  }),
              SizedBox(height: 10.h),
              PrimaryButton(
                  buttonText: S(context).becomeACeo,
                  buttonSize: ButtonSize.L3,
                  onPressed: () {}),
            ]),
        SizedBox(height: 20.h),
      ],
    );
  }
}
