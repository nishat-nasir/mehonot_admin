// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map json) => JobModel(
      jobId: json['jobId'] as String,
      jobDetailsId: json['jobDetailsId'] as String,
      title: json['title'] as String,
      companyName: json['companyName'] as String,
      images: json['images'] as String?,
      address: AddressModel.fromJson(json['address'] as Map),
      type: json['type'] as String,
      workStartTime: json['workStartTime'] as String,
      workFinishTime: json['workFinishTime'] as String,
      postedByUserId: json['postedByUserId'] as String,
    );

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
      'jobId': instance.jobId,
      'jobDetailsId': instance.jobDetailsId,
      'title': instance.title,
      'companyName': instance.companyName,
      'images': instance.images,
      'address': instance.address,
      'type': instance.type,
      'workStartTime': instance.workStartTime,
      'workFinishTime': instance.workFinishTime,
      'postedByUserId': instance.postedByUserId,
    };
