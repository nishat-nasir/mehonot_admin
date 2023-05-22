// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackMd _$FeedbackMdFromJson(Map json) =>
    FeedbackMd(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userProfileId: json['userProfileId'] as String,
      feedback: json['feedback'] as String,
      rating: json['rating'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$FeedbackMdToJson(FeedbackMd instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userProfileId': instance.userProfileId,
      'feedback': instance.feedback,
      'rating': instance.rating,
      'createdAt': instance.createdAt,
    };
