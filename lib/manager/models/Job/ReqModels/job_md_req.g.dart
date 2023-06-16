// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_md_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModelReq _$JobModelReqFromJson(Map json) => JobModelReq(
      title: json['title'] as String,
      companyName: json['companyName'] as String,
      category:
          (json['category'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      companyLogo: json['companyLogo'] as String?,
      address: AddressModel.fromJson(json['address'] as Map),
      type: json['type'] as String,
      workStartTime: json['workStartTime'] as String?,
      workFinishTime: json['workFinishTime'] as String?,
      postedByUserId: json['postedByUserId'] as String,
      status: json['status'] as String,
      wageAmount: (json['wageAmount'] as num).toDouble(),
      timestamp: const TimestampConverter().fromJson(json['timestamp']),
    );

Map<String, dynamic> _$JobModelReqToJson(JobModelReq instance) =>
    <String, dynamic>{
      'title': instance.title,
      'companyName': instance.companyName,
      'category': instance.category,
      'tags': instance.tags,
      'companyLogo': instance.companyLogo,
      'address': instance.address,
      'type': instance.type,
      'workStartTime': instance.workStartTime,
      'workFinishTime': instance.workFinishTime,
      'postedByUserId': instance.postedByUserId,
      'status': instance.status,
      'wageAmount': instance.wageAmount,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };
