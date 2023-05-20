import 'package:json_annotation/json_annotation.dart';

part 'skill_md.g.dart';

@JsonSerializable(anyMap: true)
class SkillModel {
  String skillName;
  double skillLevel;

  @override
  SkillModel({
    required this.skillLevel,
    required this.skillName,
  });

  factory SkillModel.fromJson(Map json) => _$SkillModelFromJson(json);

  Map toJson() => _$SkillModelToJson(this);
}
