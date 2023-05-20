import 'package:json_annotation/json_annotation.dart';

part 'sponsor_md.g.dart';

@JsonSerializable(anyMap: true)
class BannerModel {
  String title;
  String companyName;
  String? posterName;
  String? email;
  String phone;
  List<String>? images;
  String address;
  String? description;
  String? website;
  String type;
  String? category;
  String time;

  @override
  BannerModel({
    required this.title,
    required this.companyName,
    this.posterName,
    this.email,
    required this.phone,
    this.images,
    required this.address,
    this.description,
    this.website,
    required this.type,
    this.category,
    required this.time,
  });

  factory BannerModel.fromJson(Map json) => _$SponsorModelFromJson(json);

  Map toJson() => _$SponsorModelToJson(this);
}
