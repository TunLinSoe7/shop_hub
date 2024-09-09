// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      userName: json['user_name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'user_name': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'token':instance.token
    };
