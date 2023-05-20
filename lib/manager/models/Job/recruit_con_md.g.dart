// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recruit_con_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecruitConModel _$RecruitConModelFromJson(Map json) => RecruitConModel(
      education: json['education'] as String?,
      personnel: json['personnel'] as String?,
      deadline: json['deadline'] as String,
      gender: json['gender'] as String?,
      age: json['age'] as int?,
    );

Map<String, dynamic> _$RecruitConModelToJson(RecruitConModel instance) =>
    <String, dynamic>{
      'education': instance.education,
      'personnel': instance.personnel,
      'deadline': instance.deadline,
      'gender': instance.gender,
      'age': instance.age,
    };
