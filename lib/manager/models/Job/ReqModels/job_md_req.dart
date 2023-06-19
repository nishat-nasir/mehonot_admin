import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../Address/address_md.dart';
part 'job_md_req.g.dart';

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
class JobModelReq {
  String title;
  String companyName;
  List<String> category;
  List<String> tags;
  String? companyLogo;
  AddressModel address;
  String type;
  String? workStartTime;
  String? workFinishTime;
  String postedByUserId;
  String status;
  double wageAmount;
  @TimestampConverter()
  Timestamp timestamp;
  @override
  JobModelReq({
    required this.title,
    required this.companyName,
    required this.category,
    required this.tags,
    this.companyLogo,
    required this.address,
    required this.type,
    this.workStartTime,
    this.workFinishTime,
    required this.postedByUserId,
    required this.status,
    required this.wageAmount,
    required this.timestamp,
  });
  factory JobModelReq.fromJson(Map json) => _$JobModelReqFromJson(json);
  Map toJson() => _$JobModelReqToJson(this);
}
