// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map json) => AddressModel(
      division: json['division'] as String,
      district: json['district'] as String?,
      city: json['city'] as String?,
      area: json['area'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'division': instance.division,
      'district': instance.district,
      'city': instance.city,
      'area': instance.area,
    };
