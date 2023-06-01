import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banner_md.g.dart';

class TimestampConverter implements JsonConverter<Timestamp, dynamic> {
  const TimestampConverter();

  @override
  Timestamp fromJson(dynamic json) {
    return Timestamp.fromMillisecondsSinceEpoch(json.millisecondsSinceEpoch);
  }

  @override
  dynamic toJson(Timestamp timestamp) {
    return timestamp.millisecondsSinceEpoch;
  }
}

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
  @TimestampConverter()
  Timestamp startAt;
  @TimestampConverter()
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
