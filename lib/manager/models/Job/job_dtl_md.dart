import 'package:json_annotation/json_annotation.dart';
import 'package:mehonot_admin/manager/models/Job/recruit_con_md.dart';
import 'package:mehonot_admin/manager/models/Job/work_con_md.dart';

part 'job_dtl_md.g.dart';

@JsonSerializable(anyMap: true)
class JobDetailModel {
  String jobId;
  String jobDetailsId;
  String createdAt;
  String? ownerName;
  String? description;
  String? email;
  String phone;
  String? website;
  String? category;
  RecruitConModel recruitCondition;
  WorkConModel workCondition;
  String? moreDetails;

  @override
  JobDetailModel({
    required this.jobId,
    required this.jobDetailsId,
    required this.createdAt,
    this.ownerName,
    this.description,
    this.email,
    required this.phone,
    this.website,
    this.category,
    required this.recruitCondition,
    required this.workCondition,
    this.moreDetails,
  });

  factory JobDetailModel.fromJson(Map json) => _$JobDetailModelFromJson(json);

  Map toJson() => _$JobDetailModelToJson(this);
}
