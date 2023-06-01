// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_dtl_md_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDetailModelReq _$JobDetailModelReqFromJson(Map json) => JobDetailModelReq(
      createdAt: DateTime.parse(json['createdAt'] as String),
      ownerName: json['ownerName'] as String?,
      description: json['description'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String,
      website: json['website'] as String?,
      category: json['category'] as String?,
      recruitCondition: json['recruitCondition'] == null
          ? null
          : RecruitConModelReq.fromJson(json['recruitCondition'] as Map),
      workCondition: json['workCondition'] == null
          ? null
          : WorkConModel.fromJson(json['workCondition'] as Map),
      moreDetails: json['moreDetails'] as String?,
      appliedBy: (json['appliedBy'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$JobDetailModelReqToJson(JobDetailModelReq instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'ownerName': instance.ownerName,
      'description': instance.description,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
      'category': instance.category,
      'recruitCondition': instance.recruitCondition,
      'workCondition': instance.workCondition,
      'moreDetails': instance.moreDetails,
      'appliedBy': instance.appliedBy,
    };
