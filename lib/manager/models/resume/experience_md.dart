import 'package:json_annotation/json_annotation.dart';

part 'experience_md.g.dart';

@JsonSerializable(anyMap: true)
class ExperienceModel {
  String companyName;
  String positionName;
  String description;
  String location;
  String startDate;
  String? endDate;

  @override
  ExperienceModel({
    required this.companyName,
    required this.positionName,
    required this.description,
    required this.location,
    required this.startDate,
    this.endDate,
  });

  factory ExperienceModel.fromJson(Map json) => _$ExperienceModelFromJson(json);

  Map toJson() => _$ExperienceModelToJson(this);
}
