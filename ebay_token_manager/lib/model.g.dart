// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) {
  return Configuration(
    restApiKey: json['rest_api_key'] as String,
    apiUrl: json['api_url'] as String,
    appId: json['app_id'] as String,
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'rest_api_key': instance.restApiKey,
      'app_id': instance.appId,
      'api_url': instance.apiUrl,
      'username': instance.username,
      'password': instance.password,
    };

EbayToken _$EbayTokenFromJson(Map<String, dynamic> json) {
  return EbayToken(
    accessToken: json['accessToken'] as String,
    expire: json['expire'] as int,
    authServerUrl: json['authServerUrl'] as String,
    expireDate: json['expireDate'] == null
        ? null
        : DateTime.parse(json['expireDate'] as String),
    key: json['key'] as String,
    password: json['password'] as String,
    scope: json['scope'] as String,
    objectId: json['objectId'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$EbayTokenToJson(EbayToken instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'expireDate': instance.expireDate?.toIso8601String(),
      'authServerUrl': instance.authServerUrl,
      'expire': instance.expire,
      'key': instance.key,
      'username': instance.username,
      'password': instance.password,
      'scope': instance.scope,
      'objectId': instance.objectId,
    };
