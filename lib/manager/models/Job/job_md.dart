import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mehonot_admin/presentation/utils/constants.dart';
import '../Address/address_md.dart';

part 'job_md.g.dart';

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
class JobModel {
  String jobId;
  String jobDetailsId;
  String title;
  String companyName;
  List<String> category;
  List<String> tags;
  String? companyLogo;
  AddressModel address;
  String type;
  String workStartTime;
  String workFinishTime;
  String postedByUserId;
  JobStatus status;
  double wageAmount;
  @TimestampConverter()
  Timestamp timestamp;

  JobModel({
    required this.jobId,
    required this.jobDetailsId,
    required this.title,
    required this.companyName,
    this.companyLogo,
    required this.category,
    required this.tags,
    required this.address,
    required this.type,
    required this.workStartTime,
    required this.workFinishTime,
    required this.postedByUserId,
    required this.status,
    required this.wageAmount,
    required this.timestamp,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}
