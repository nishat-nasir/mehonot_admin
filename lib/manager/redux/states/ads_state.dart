import 'dart:io';

import 'package:mehonot_admin/manager/models/Job/job_md.dart';

import '../../../presentation/template/template.dart';
import '../../models/Banner/banner_md.dart';

@immutable
class AdsState {
  final List<BannerModel> homeBanners;
  final List<BannerModel> settingBanner;
  final List<String> jobAds;

  AdsState({
    required this.homeBanners,
    required this.settingBanner,
    required this.jobAds,
  });

  factory AdsState.initial() {
    return AdsState(
      homeBanners: [],
      settingBanner: [],
      jobAds: [],
    );
  }

  AdsState copyWith({
    List<BannerModel>? homeBanners,
    List<BannerModel>? settingBanner,
    List<String>? jobAds,
  }) {
    return AdsState(
      homeBanners: homeBanners ?? this.homeBanners,
      settingBanner: settingBanner ?? this.settingBanner,
      jobAds: jobAds ?? this.jobAds,
    );
  }
}

///------------------Update Ads Action ---------
class UpdateAdsStateAction {
  final List<BannerModel>? homeBanners;
  final List<BannerModel>? settingBanner;
  final List<String>? jobAds;

  UpdateAdsStateAction({
    this.homeBanners,
    this.settingBanner,
    this.jobAds,
  });
}

///------------------Ads Action ---------

class GetBannersAction {
  GetBannersAction();
}

class GetHomeJobAdsAction {
  GetHomeJobAdsAction();
}

class GetCreateBannersAction {
  final String bannerType;
  final BannerModel bannerModel;
  final File bannerImg;

  GetCreateBannersAction({
    required this.bannerType,
    required this.bannerModel,
    required this.bannerImg,
  });
}

class GetUpdatedBannersAction {
  final String bannerType;
  final BannerModel bannerModel;
  final File? bannerImgToAdd;
  final String? imageUrlToDelete;

  GetUpdatedBannersAction({
    required this.bannerType,
    required this.bannerModel,
    this.bannerImgToAdd,
    this.imageUrlToDelete,
  });
}

class GetPostHomeJobAdsAction {
  final String jobId;

  GetPostHomeJobAdsAction({
    required this.jobId,
  });
}
