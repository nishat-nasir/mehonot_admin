// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_md.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map json) => UserProfileModel(
      userId: json['userId'] as String,
      userProfileId: json['userProfileId'] as String,
      userJobRelationId: json['userJobRelationId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      createdDate: json['createdDate'] as String,
      email: json['email'] as String,
      contactNumber: json['contactNumber'] as String,
      address: AddressModel.fromJson(json['address'] as Map),
      profileImage: json['profileImage'] as String,
      education: (json['education'] as List<dynamic>?)
          ?.map((e) => EducationModel.fromJson(e as Map))
          .toList(),
      experience: (json['experience'] as List<dynamic>?)
          ?.map((e) => ExperienceModel.fromJson(e as Map))
          .toList(),
      skill: (json['skill'] as List<dynamic>?)
          ?.map((e) => SkillModel.fromJson(e as Map))
          .toList(),
      birthday: json['birthday'] as String,
      positionTitle: json['positionTitle'] as String,
      bio: json['bio'] as String,
      isVerifiedOwner: json['isVerifiedOwner'] as bool?,
      isVerifiedExplorer: json['isVerifiedExplorer'] as bool?,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userProfileId': instance.userProfileId,
      'userJobRelationId': instance.userJobRelationId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'createdDate': instance.createdDate,
      'email': instance.email,
      'contactNumber': instance.contactNumber,
      'address': instance.address,
      'profileImage': instance.profileImage,
      'education': instance.education,
      'experience': instance.experience,
      'skill': instance.skill,
      'birthday': instance.birthday,
      'positionTitle': instance.positionTitle,
      'bio': instance.bio,
      'isVerifiedOwner': instance.isVerifiedOwner,
      'isVerifiedExplorer': instance.isVerifiedExplorer,
    };
