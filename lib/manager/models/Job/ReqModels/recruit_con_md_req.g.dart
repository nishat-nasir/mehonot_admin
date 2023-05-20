// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recruit_con_md_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecruitConModelReq _$RecruitConModelReqFromJson(Map json) => RecruitConModelReq(
      education: json['education'] as String?,
      personnel: json['personnel'] as String?,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      gender: json['gender'] as String?,
      age: json['age'] as int?,
    );

Map<String, dynamic> _$RecruitConModelReqToJson(RecruitConModelReq instance) =>
    <String, dynamic>{
      'education': instance.education,
      'personnel': instance.personnel,
      'deadline': instance.deadline?.toIso8601String(),
      'gender': instance.gender,
      'age': instance.age,
    };
