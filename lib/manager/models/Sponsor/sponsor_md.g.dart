// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$SponsorModelFromJson(Map json) =>
    BannerModel(
          title: json['title'] as String,
          companyName: json['companyName'] as String,
          posterName: json['posterName'] as String?,
          email: json['email'] as String?,
          phone: json['phone'] as String,
          images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
          address: json['address'] as String,
          description: json['description'] as String?,
          website: json['website'] as String?,
          type: json['type'] as String,
          category: json['category'] as String?,
          time: json['time'] as String,
    );

Map<String, dynamic> _$SponsorModelToJson(BannerModel instance) =>
    <String, dynamic>{
          'title': instance.title,
          'companyName': instance.companyName,
          'posterName': instance.posterName,
          'email': instance.email,
          'phone': instance.phone,
          'images': instance.images,
          'address': instance.address,
          'description': instance.description,
          'website': instance.website,
          'type': instance.type,
          'category': instance.category,
          'time': instance.time,
    };
