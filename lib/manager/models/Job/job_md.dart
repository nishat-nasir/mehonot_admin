import 'package:json_annotation/json_annotation.dart';
import '../Address/address_md.dart';

part 'job_md.g.dart';

@JsonSerializable(anyMap: true)
class JobModel {
  String jobId;
  String jobDetailsId;
  String title;
  String companyName;
  String? images;
  AddressModel address;
  String type;
  String workStartTime;
  String workFinishTime;
  String postedByUserId;

  @override
  JobModel({
    required this.jobId,
    required this.jobDetailsId,
    required this.title,
    required this.companyName,
    this.images,
    required this.address,
    required this.type,
    required this.workStartTime,
    required this.workFinishTime,
    required this.postedByUserId,
  });

  factory JobModel.fromJson(Map json) => _$JobModelFromJson(json);

  Map toJson() => _$JobModelToJson(this);
}
