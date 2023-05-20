// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperienceModel _$ExperienceModelFromJson(Map json) => ExperienceModel(
      companyName: json['companyName'] as String,
      positionName: json['positionName'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$ExperienceModelToJson(ExperienceModel instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'positionName': instance.positionName,
      'description': instance.description,
      'location': instance.location,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
