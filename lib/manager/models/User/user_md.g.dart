// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map json) => UserModel(
      userId: json['userId'] as String,
      userProfileId: json['userProfileId'] as String,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      isAdmin: json['isAdmin'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'userProfileId': instance.userProfileId,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'isAdmin': instance.isAdmin,
    };
