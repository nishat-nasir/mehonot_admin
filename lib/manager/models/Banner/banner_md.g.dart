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
      image:json['phone'] as String,
      description: json['description'] as String?,
      website: json['website'] as String?,
      bannerType: json['bannerType'] as String,
      category: json['category'] as String?,
      createdAt: json['createdAt'] as String?,
      removeAt: json['removeAt'] as String?,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'companyName': instance.companyName,
      'postedById': instance.postedById,
      'email': instance.email,
      'phone': instance.phone,
      'images': instance.image,
      'description': instance.description,
      'website': instance.website,
      'bannerType': instance.bannerType,
      'category': instance.category,
      'createdAt': instance.createdAt,
      'removeAt': instance.removeAt,
    };
