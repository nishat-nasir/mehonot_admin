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
          : const TimestampConverter().fromJson(json['deadline'] as Timestamp),
      gender: json['gender'] as String?,
      age: json['age'] as String?,
    );

Map<String, dynamic> _$RecruitConModelReqToJson(RecruitConModelReq instance) =>
    <String, dynamic>{
      'education': instance.education,
      'personnel': instance.personnel,
      'deadline': instance.deadline == null
          ? null
          : const TimestampConverter().toJson(instance.deadline as Timestamp),
      'gender': instance.gender,
      'age': instance.age,
    };
