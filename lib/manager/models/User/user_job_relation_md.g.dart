// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_job_relation_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserJobRelationMd _$UserJobRelationMdFromJson(Map json) => UserJobRelationMd(
      userProfileId: json['userProfileId'] as String,
      myJobsIds:
          (json['myJobsIds'] as List<dynamic>).map((e) => e as String).toList(),
      savedJobsIds: (json['savedJobsIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      appliedJobsIds: (json['appliedJobsIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserJobRelationMdToJson(UserJobRelationMd instance) =>
    <String, dynamic>{
      'userProfileId': instance.userProfileId,
      'myJobsIds': instance.myJobsIds,
      'savedJobsIds': instance.savedJobsIds,
      'appliedJobsIds': instance.appliedJobsIds,
    };
