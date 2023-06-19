import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recruit_con_md.g.dart';

class TimestampConverter implements JsonConverter<Timestamp, dynamic> {
  const TimestampConverter();

  @override
  Timestamp fromJson(dynamic json) {
    return Timestamp.fromMillisecondsSinceEpoch(json.millisecondsSinceEpoch);
  }

  @override
  dynamic toJson(Timestamp timestamp) {
    return timestamp.millisecondsSinceEpoch;
  }
}

@JsonSerializable(anyMap: true)
class RecruitConModel {
  String? education;
  String? personnel;
  @TimestampConverter()
  Timestamp deadline;
  String? gender;
  String? age;

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
