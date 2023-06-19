import 'package:json_annotation/json_annotation.dart';
import './recruit_con_md.dart';
import './work_con_md.dart';

part 'job_dtl_md.g.dart';

@JsonSerializable(anyMap: true)
class JobDetailModel {
  String jobId;
  String jobDetailsId;
  String? ownerName;
  String? description;
  String? email;
  String phone;
  String? website;
  RecruitConModel recruitCondition;
  WorkConModel workCondition;
  String? moreDetails;
  List<String>? appliedBy;
  List<String> images;

  @override
  JobDetailModel({
    required this.jobId,
    required this.jobDetailsId,
    this.ownerName,
    this.description,
    this.email,
    required this.images,
    required this.phone,
    this.website,
    required this.recruitCondition,
    required this.workCondition,
    this.moreDetails,
    this.appliedBy,
  });

  factory JobDetailModel.fromJson(Map json) => _$JobDetailModelFromJson(json);

  Map toJson() => _$JobDetailModelToJson(this);
}
