import '../../../presentation/template/template.dart';
import '../../models/Sponsor/sponsor_md.dart';

@immutable
class AdsState {
  final List<BannerModel> homeTopAds;
  final List<BannerModel> homeMidAds;
  final List<BannerModel> settingsAds;

  AdsState({
    required this.homeTopAds,
    required this.homeMidAds,
    required this.settingsAds,
  });

  factory AdsState.initial() {
    return AdsState(
      homeTopAds: [],
      homeMidAds: [],
      settingsAds: [],
    );
  }

  AdsState copyWith({
    List<BannerModel>? homeTopAds,
    List<BannerModel>? homeMidAds,
    List<BannerModel>? settingsAds,
  }) {
    return AdsState(
      homeTopAds: homeTopAds ?? this.homeTopAds,
      homeMidAds: homeMidAds ?? this.homeMidAds,
      settingsAds: settingsAds ?? this.settingsAds,
    );
  }
}

///------------------Update Ads Action ---------
class UpdateAdsStateAction {
  final List<BannerModel>? homeTopAds;
  final List<BannerModel>? homeMidAds;
  final List<BannerModel>? settingsAds;

  UpdateAdsStateAction({
    this.homeTopAds,
    this.homeMidAds,
    this.settingsAds,
  });
}

///------------------Ads Action ---------

class GetSettingBannersAction {
  GetSettingBannersAction();
}

class GetHomeJobAdsAction {
  GetHomeJobAdsAction();
}

class GetHomeBannersAction {
  GetHomeBannersAction();
}
