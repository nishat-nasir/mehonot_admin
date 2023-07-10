import 'dart:io';

import 'package:mehonot_admin/manager/models/Job/job_md.dart';

import '../../../presentation/template/template.dart';
import '../../../presentation/utils/constants.dart';
import '../../../manager/models/Ads/banner_ads/banner_md.dart';
import '../../models/Ads/job_ads/job_ads_ids_md.dart';

@immutable
class AdsState {
  final List<BannerModel> homeBanners;
  final List<BannerModel> settingBanner;
  final List<JobModel> dhakaJobAds;
  final List<JobModel> chittagongJobAds;
  final List<JobModel> sylhetJobAds;
  final List<JobModel> rajshahiJobAds;
  final List<JobModel> khulnaJobAds;
  final List<JobModel> barisalJobAds;
  final List<JobModel> rangpurJobAds;
  final List<JobModel> mymensinghJobAds;
  final JobAdsIdsMd allJobAdsIds;

  AdsState({
    required this.homeBanners,
    required this.settingBanner,
    required this.dhakaJobAds,
    required this.chittagongJobAds,
    required this.sylhetJobAds,
    required this.rajshahiJobAds,
    required this.khulnaJobAds,
    required this.barisalJobAds,
    required this.rangpurJobAds,
    required this.mymensinghJobAds,
    required this.allJobAdsIds,
  });

  factory AdsState.initial() {
    return AdsState(
        homeBanners: [],
        settingBanner: [],
        dhakaJobAds: [],
        chittagongJobAds: [],
        sylhetJobAds: [],
        rajshahiJobAds: [],
        khulnaJobAds: [],
        barisalJobAds: [],
        rangpurJobAds: [],
        mymensinghJobAds: [],
        allJobAdsIds: JobAdsIdsMd(
          dhakaJobAds: [],
          chittagongJobAds: [],
          sylhetJobAds: [],
          rajshahiJobAds: [],
          khulnaJobAds: [],
          barisalJobAds: [],
          rangpurJobAds: [],
          mymensinghJobAds: [],
        ));
  }

  AdsState copyWith({
    List<BannerModel>? homeBanners,
    List<BannerModel>? settingBanner,
    List<JobModel>? dhakaJobAds,
    List<JobModel>? chittagongJobAds,
    List<JobModel>? sylhetJobAds,
    List<JobModel>? rajshahiJobAds,
    List<JobModel>? khulnaJobAds,
    List<JobModel>? barisalJobAds,
    List<JobModel>? rangpurJobAds,
    List<JobModel>? mymensinghJobAds,
    JobAdsIdsMd? allJobAdsIds,
  }) {
    return AdsState(
      homeBanners: homeBanners ?? this.homeBanners,
      settingBanner: settingBanner ?? this.settingBanner,
      dhakaJobAds: dhakaJobAds ?? this.dhakaJobAds,
      chittagongJobAds: chittagongJobAds ?? this.chittagongJobAds,
      sylhetJobAds: sylhetJobAds ?? this.sylhetJobAds,
      rajshahiJobAds: rajshahiJobAds ?? this.rajshahiJobAds,
      khulnaJobAds: khulnaJobAds ?? this.khulnaJobAds,
      barisalJobAds: barisalJobAds ?? this.barisalJobAds,
      rangpurJobAds: rangpurJobAds ?? this.rangpurJobAds,
      mymensinghJobAds: mymensinghJobAds ?? this.mymensinghJobAds,
      allJobAdsIds: allJobAdsIds ?? this.allJobAdsIds,
    );
  }
}

///------------------Update Ads Action ---------
class UpdateAdsStateAction {
  final List<BannerModel>? homeBanners;
  final List<BannerModel>? settingBanner;
  final List<JobModel>? dhakaJobAds;
  final List<JobModel>? chittagongJobAds;
  final List<JobModel>? sylhetJobAds;
  final List<JobModel>? rajshahiJobAds;
  final List<JobModel>? khulnaJobAds;
  final List<JobModel>? barisalJobAds;
  final List<JobModel>? rangpurJobAds;
  final List<JobModel>? mymensinghJobAds;
  final JobAdsIdsMd? allJobAdsIds;

  UpdateAdsStateAction({
    this.homeBanners,
    this.settingBanner,
    this.dhakaJobAds,
    this.chittagongJobAds,
    this.sylhetJobAds,
    this.rajshahiJobAds,
    this.khulnaJobAds,
    this.barisalJobAds,
    this.rangpurJobAds,
    this.mymensinghJobAds,
    this.allJobAdsIds,
  });
}

///------------------Ads Action ---------

class GetJobAdsDetailAction {
  Division division;

  GetJobAdsDetailAction({
    required this.division,
  });
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
  BuildContext context;

  GetCreateBannersAction({
    required this.bannerType,
    required this.bannerModel,
    required this.bannerImg,
    required this.division,
    required this.context,
  });
}

class GetUpdatedBannersAction {
  final String bannerType;
  final BannerModel bannerModel;
  final Division division;
  List<File>? imageFilesToAdd;
  String? imageUrlsToAdd;
  String? imageUrlsToDelete;
  BuildContext context;

  GetUpdatedBannersAction({
    required this.bannerType,
    required this.bannerModel,
    required this.division,
    this.imageFilesToAdd,
    this.imageUrlsToAdd,
    this.imageUrlsToDelete,
    required this.context,
  });
}

class GetCreateJobAdsAction {
  final String jobId;
  final Division division;
  final BuildContext context;

  GetCreateJobAdsAction({
    required this.jobId,
    required this.division,
    required this.context,
  });
}

class GetRemoveJobAdsAction {
  final String jobId;
  final Division division;

  GetRemoveJobAdsAction({
    required this.jobId,
    required this.division,
  });
}

class GetJobAdsIdsAction {
  GetJobAdsIdsAction();
}
