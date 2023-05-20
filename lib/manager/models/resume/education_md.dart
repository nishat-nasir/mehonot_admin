import 'package:json_annotation/json_annotation.dart';

part 'education_md.g.dart';

@JsonSerializable(anyMap: true)
class EducationModel {
  String subjectName;
  String startDate;
  String? endDate;
  String location;
  String instituteName;
  String degreeName;

  @override
  EducationModel({
    required this.subjectName,
    required this.startDate,
    this.endDate,
    required this.location,
    required this.instituteName,
    required this.degreeName,
  });

  factory EducationModel.fromJson(Map json) => _$EducationModelFromJson(json);

  Map toJson() => _$EducationModelToJson(this);
}
