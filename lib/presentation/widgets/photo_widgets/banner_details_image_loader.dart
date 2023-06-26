import 'package:cached_network_image/cached_network_image.dart';import 'package:flutter/material.dart';import 'package:mehonot_admin/manager/models/Ads/banner_ads/banner_md.dart';import 'package:mehonot_admin/presentation/widgets/photo_widgets/shimmer_loader.dart';import 'package:shimmer/shimmer.dart';import '../../utils/common/helpers.dart';class BannerDetailsImageLoader extends StatefulWidget {  final BannerModel bannerModel;  const BannerDetailsImageLoader({super.key, required this.bannerModel});  @override  State<BannerDetailsImageLoader> createState() =>      _BannerDetailsImageLoaderState();}class _BannerDetailsImageLoaderState extends State<BannerDetailsImageLoader> {  @override  Widget build(BuildContext context) {    return ClipRRect(      borderRadius: BorderRadius.circular(10),      child: CachedNetworkImage(        imageUrl: widget.bannerModel.image,        width: 500,        height: 120,        fit: BoxFit.cover,        placeholder: (context, url) => const ShimmerImgLoader(          width: 500,          height: 120,        ),        errorWidget: (context, url, error) => Image.asset(          'assets/images/png/error_img.png',          fit: BoxFit.cover,          width: 500,          height: 120,        ),      ),    );  }}