// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_reg_terms_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncRegTermsMd _$SyncRegTermsMdFromJson(Map json) => SyncRegTermsMd(
      id: json['id'] as String,
      version: json['version'] as String,
      createdDate: json['createdDate'] as String,
      serviceTerms: json['serviceTerms'] as String,
      marketingInfoTerms: json['marketingInfoTerms'] as String,
      personalInfoTerms: json['personalInfoTerms'] as String,
      softwareTerms: json['softwareTerms'] as String,
      halalTerms: json['halalTerms'] as String,
    );

Map<String, dynamic> _$SyncRegTermsMdToJson(SyncRegTermsMd instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'createdDate': instance.createdDate,
      'softwareTerms': instance.softwareTerms,
      'serviceTerms': instance.serviceTerms,
      'personalInfoTerms': instance.personalInfoTerms,
      'marketingInfoTerms': instance.marketingInfoTerms,
      'halalTerms': instance.halalTerms,
    };
