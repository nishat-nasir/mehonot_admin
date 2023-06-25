// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recruit_con_md_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecruitConModelReq _$RecruitConModelReqFromJson(Map json) => RecruitConModelReq(
      education: json['education'] as String?,
      personnel: json['personnel'] as String?,
      deadline: const TimestampConverter().fromJson(json['deadline']),
      gender: json['gender'] as String?,
      age: json['age'] as String?,
    );

Map<String, dynamic> _$RecruitConModelReqToJson(RecruitConModelReq instance) =>
    <String, dynamic>{
      'education': instance.education,
      'personnel': instance.personnel,
      'gender': instance.gender,
      'age': instance.age,
      'deadline': _$JsonConverterToJson<dynamic, Timestamp>(
          instance.deadline, const TimestampConverter().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
