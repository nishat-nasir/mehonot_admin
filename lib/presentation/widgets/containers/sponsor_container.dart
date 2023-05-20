import '../../template/template.dart';

class SponsorContainer extends StatelessWidget {
  const SponsorContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(children: [
      SpacedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          singleSponsorWidget(context),
          singleSponsorWidget(context),
        ],
      ),
      SizedBox(height: 20.h),
      SpacedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          singleSponsorWidget(context),
          singleSponsorWidget(context),
        ],
      ),
    ]);
  }

  Widget singleSponsorWidget(BuildContext context) {
    return Container(
      height: 250.h,
      constraints: BoxConstraints(
          minWidth: (MediaQuery.of(context).size.width / 2) - 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: ThemeShadows.shadowSm),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(
            'assets/images/png/nft.jpg',
            fit: BoxFit.fitWidth,
          )),
    );
  }
}
