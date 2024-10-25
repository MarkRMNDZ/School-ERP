// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthRequestSuccessImpl _$$AuthRequestSuccessImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthRequestSuccessImpl(
      AuthenticatedUser.fromJson(json['user'] as Map<String, dynamic>),
      json['access_token'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AuthRequestSuccessImplToJson(
        _$AuthRequestSuccessImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'access_token': instance.accessToken,
      'runtimeType': instance.$type,
    };

_$AuthRequestFailureImpl _$$AuthRequestFailureImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthRequestFailureImpl(
      (json['statusCode'] as num).toInt(),
      json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AuthRequestFailureImplToJson(
        _$AuthRequestFailureImpl instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'runtimeType': instance.$type,
    };
