// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map json) => BannerModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      companyName: json['companyName'] as String,
      postedById: json['postedById'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String,
      description: json['description'] as String?,
      website: json['website'] as String?,
      bannerType: json['bannerType'] as String,
      category: json['category'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      startAt: const TimestampConverter().fromJson(json['startAt']),
      removeAt: const TimestampConverter().fromJson(json['removeAt']),
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'companyName': instance.companyName,
      'postedById': instance.postedById,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.image,
      'description': instance.description,
      'website': instance.website,
      'bannerType': instance.bannerType,
      'category': instance.category,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'startAt': const TimestampConverter().toJson(instance.startAt),
      'removeAt': const TimestampConverter().toJson(instance.removeAt),
    };
