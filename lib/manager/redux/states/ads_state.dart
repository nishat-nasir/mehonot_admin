import '../../../presentation/template/template.dart';
import '../../models/Sponsor/sponsor_md.dart';

@immutable
class AdsState {
  final List<SponsorModel> homeTopAds;
  final List<SponsorModel> homeMidAds;
  final List<SponsorModel> settingsAds;

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
    List<SponsorModel>? homeTopAds,
    List<SponsorModel>? homeMidAds,
    List<SponsorModel>? settingsAds,
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
  final List<SponsorModel>? homeTopAds;
  final List<SponsorModel>? homeMidAds;
  final List<SponsorModel>? settingsAds;

  UpdateAdsStateAction({
    this.homeTopAds,
    this.homeMidAds,
    this.settingsAds,
  });
}

///------------------Ads Action ---------

class GetSettingsAdsAction {
  GetSettingsAdsAction();
}

class GetHomeMidAdsAction {
  GetHomeMidAdsAction();
}

class GetHomeTopAdsAction {
  GetHomeTopAdsAction();
}
