import 'package:cached_network_image/cached_network_image.dart';

import '../../template/template.dart';
import '../photo_widgets/shimmer_loader.dart';

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
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.fitWidth,
            placeholder: (context, url) => ShimmerImgLoader(
              height: 300.h,
              width: double.infinity,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ));
  }
}
