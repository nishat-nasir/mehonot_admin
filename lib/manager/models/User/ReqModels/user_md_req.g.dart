// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_md_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModelReq _$UserModelReqFromJson(Map json) => UserModelReq(
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      isAdmin: json['isAdmin'] as bool,
    );

Map<String, dynamic> _$UserModelReqToJson(UserModelReq instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'isAdmin': instance.isAdmin,
    };
