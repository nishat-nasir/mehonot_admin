import 'package:json_annotation/json_annotation.dart';

part 'job_ads_ids_md.g.dart';

@JsonSerializable(anyMap: true)
class JobAdsIdsMd {
  List<String> dhakaJobAds;
  List<String> khulnaJobAds;
  List<String> rajshahiJobAds;
  List<String> rangpurJobAds;
  List<String> sylhetJobAds;
  List<String> barisalJobAds;
  List<String> chittagongJobAds;
  List<String> mymensinghJobAds;

  JobAdsIdsMd({
    required this.dhakaJobAds,
    required this.khulnaJobAds,
    required this.rajshahiJobAds,
    required this.rangpurJobAds,
    required this.sylhetJobAds,
    required this.barisalJobAds,
    required this.chittagongJobAds,
    required this.mymensinghJobAds,
  });

  factory JobAdsIdsMd.fromJson(Map<String, dynamic> json) =>
      _$JobAdsIdsMdFromJson(json);

  Map<String, dynamic> toJson() => _$JobAdsIdsMdToJson(this);
}
