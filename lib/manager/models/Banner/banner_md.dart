import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../Job/ReqModels/job_md_req.dart';

part 'banner_md.g.dart';

@JsonSerializable(anyMap: true)
class BannerModel {
  String? id;
  String title;
  String companyName;
  String postedById;
  String? email;
  String? phone;
  String image;
  String? description;
  String? website;
  String bannerType;
  String? category;
  @TimestampConverter()
  Timestamp createdAt;
  Timestamp startAt;
  Timestamp removeAt;


  @override
  BannerModel({
    required this.id,
    required this.title,
    required this.companyName,
    required this.postedById,
    this.email,
    required this.phone,
    required this.image,
    this.description,
    this.website,
    required this.bannerType,
    this.category,
    required this.createdAt,
    required this.startAt,
    required this.removeAt,
  });

  factory BannerModel.fromJson(Map json) => _$BannerModelFromJson(json);

  Map toJson() => _$BannerModelToJson(this);
}
