// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_dtl_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDetailModel _$JobDetailModelFromJson(Map json) => JobDetailModel(
      jobId: json['jobId'] as String,
      jobDetailsId: json['jobDetailsId'] as String,
      ownerName: json['ownerName'] as String?,
      description: json['description'] as String?,
      email: json['email'] as String?,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      phone: json['phone'] as String,
      website: json['website'] as String?,
      recruitCondition:
          RecruitConModel.fromJson(json['recruitCondition'] as Map),
      workCondition: WorkConModel.fromJson(json['workCondition'] as Map),
      moreDetails: json['moreDetails'] as String?,
      appliedBy: (json['appliedBy'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      statusDesc: json['statusDesc'] as String?,
    );

Map<String, dynamic> _$JobDetailModelToJson(JobDetailModel instance) =>
    <String, dynamic>{
      'jobId': instance.jobId,
      'jobDetailsId': instance.jobDetailsId,
      'ownerName': instance.ownerName,
      'description': instance.description,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
      'recruitCondition': instance.recruitCondition,
      'workCondition': instance.workCondition,
      'moreDetails': instance.moreDetails,
      'appliedBy': instance.appliedBy,
      'images': instance.images,
      'statusDesc': instance.statusDesc,
    };
