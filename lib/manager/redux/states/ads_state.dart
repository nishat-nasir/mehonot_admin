import 'dart:io';

import 'package:mehonot_admin/manager/models/Job/job_md.dart';

import '../../../presentation/template/template.dart';
import '../../../presentation/utils/constants.dart';
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

class GetHomeJobAdsAction {
  GetHomeJobAdsAction();
}

class GetHomeBannersAction {
  final int? limit;

  GetHomeBannersAction({this.limit});
}

class GetSettingsBannersAction {
  final int? limit;

  GetSettingsBannersAction({this.limit});
}

class GetCreateBannersAction {
  final String bannerType;
  final BannerModel bannerModel;
  final File bannerImg;
  final Division division;

  GetCreateBannersAction({
    required this.bannerType,
    required this.bannerModel,
    required this.bannerImg,
    required this.division,
  });
}

class GetUpdatedBannersAction {
  final String bannerType;
  final BannerModel bannerModel;
  final Division division;
  List<File>? imageFilesToAdd;
  List<String>? imageUrlsToAdd;
  List<String>? imageUrlsToDelete;

  GetUpdatedBannersAction({
    required this.bannerType,
    required this.bannerModel,
    required this.division,
    this.imageFilesToAdd,
    this.imageUrlsToAdd,
    this.imageUrlsToDelete,
  });
}

class GetPostHomeJobAdsAction {
  final String jobId;

  GetPostHomeJobAdsAction({
    required this.jobId,
  });
}
