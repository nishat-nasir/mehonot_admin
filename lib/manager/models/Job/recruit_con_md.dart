import 'package:json_annotation/json_annotation.dart';

part 'recruit_con_md.g.dart';

@JsonSerializable(anyMap: true)
class RecruitConModel {
  String? education;
  String? personnel;
  String deadline;
  String? gender;
  int? age;

  @override
  RecruitConModel({
    this.education,
    this.personnel,
    required this.deadline,
    this.gender,
    this.age,
  });

  factory RecruitConModel.fromJson(Map json) => _$RecruitConModelFromJson(json);

  Map toJson() => _$RecruitConModelToJson(this);
}
