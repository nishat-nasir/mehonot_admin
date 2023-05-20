// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_dtl_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDetailModel _$JobDetailModelFromJson(Map json) => JobDetailModel(
      jobId: json['jobId'] as String,
      jobDetailsId: json['jobDetailsId'] as String,
      createdAt: json['createdAt'] as String,
      ownerName: json['ownerName'] as String?,
      description: json['description'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String,
      website: json['website'] as String?,
      category: json['category'] as String?,
      recruitCondition:
          RecruitConModel.fromJson(json['recruitCondition'] as Map),
      workCondition: WorkConModel.fromJson(json['workCondition'] as Map),
      moreDetails: json['moreDetails'] as String?,
    );

Map<String, dynamic> _$JobDetailModelToJson(JobDetailModel instance) =>
    <String, dynamic>{
      'jobId': instance.jobId,
      'jobDetailsId': instance.jobDetailsId,
      'createdAt': instance.createdAt,
      'ownerName': instance.ownerName,
      'description': instance.description,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
      'category': instance.category,
      'recruitCondition': instance.recruitCondition,
      'workCondition': instance.workCondition,
      'moreDetails': instance.moreDetails,
    };
