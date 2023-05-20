// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillModel _$SkillModelFromJson(Map json) => SkillModel(
      skillLevel: (json['skillLevel'] as num).toDouble(),
      skillName: json['skillName'] as String,
    );

Map<String, dynamic> _$SkillModelToJson(SkillModel instance) =>
    <String, dynamic>{
      'skillName': instance.skillName,
      'skillLevel': instance.skillLevel,
    };
