// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationModel _$EducationModelFromJson(Map json) => EducationModel(
      subjectName: json['subjectName'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String?,
      location: json['location'] as String,
      instituteName: json['instituteName'] as String,
      degreeName: json['degreeName'] as String,
    );

Map<String, dynamic> _$EducationModelToJson(EducationModel instance) =>
    <String, dynamic>{
      'subjectName': instance.subjectName,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'location': instance.location,
      'instituteName': instance.instituteName,
      'degreeName': instance.degreeName,
    };
