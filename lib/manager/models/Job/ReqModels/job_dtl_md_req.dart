import 'package:json_annotation/json_annotation.dart';
import 'package:mehonot_admin/manager/models/Job/ReqModels/recruit_con_md_req.dart';
import 'package:mehonot_admin/manager/models/Job/work_con_md.dart';

part 'job_dtl_md_req.g.dart';

@JsonSerializable(anyMap: true)
class JobDetailModelReq {
  DateTime createdAt;
  String? ownerName;
  String? description;
  String? email;
  String phone;
  String? website;
  RecruitConModelReq? recruitCondition;
  WorkConModel? workCondition;
  String? moreDetails;
  List<String>? appliedBy;
  List<String> images;

  @override
  JobDetailModelReq({
    required this.createdAt,
    this.ownerName,
    this.description,
    this.email,
    required this.phone,
    this.website,
    required this.images,
    this.recruitCondition,
    this.workCondition,
    this.moreDetails,
    this.appliedBy,
  });

  factory JobDetailModelReq.fromJson(Map json) =>
      _$JobDetailModelReqFromJson(json);

  Map toJson() => _$JobDetailModelReqToJson(this);
}
