import '../../template/template.dart';

class SponsorBannerContainer extends StatelessWidget {
  final String imageUrl;

  const SponsorBannerContainer({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 300.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: ThemeShadows.shadowSm,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: Image.network(imageUrl, fit: BoxFit.fitWidth)));
  }
}
