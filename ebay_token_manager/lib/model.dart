import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Configuration {
  final String restApiKey;
  final String appId;
  final String apiUrl;
  final String username;
  final String password;

  Configuration(
      {this.restApiKey, this.apiUrl, this.appId, this.username, this.password});
  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);
}

@JsonSerializable()
class EbayToken {
  final String accessToken;
  final DateTime expireDate;
  final String authServerUrl;
  final int expire;
  final String key;
  final String username;
  final String password;
  final String scope;
  final String objectId;
  EbayToken(
      {this.accessToken,
      this.expire,
      this.authServerUrl,
      this.expireDate,
      this.key,
      this.password,
      this.scope,
      this.objectId,
      this.username});
  factory EbayToken.fromJson(json) => _$EbayTokenFromJson(json);
  Map<String, dynamic> toJson() => _$EbayTokenToJson(this);
  EbayToken copyWith(
          {String accessToken,
          int expire,
          String authServerUrl,
          DateTime expireDate,
          String key,
          String password,
          String scope,
          String objectId,
          String username}) =>
      EbayToken(
          accessToken: accessToken ?? this.accessToken,
          authServerUrl: authServerUrl ?? this.authServerUrl,
          expire: expire ?? this.expire,
          expireDate: expireDate ?? this.expireDate,
          key: key ?? this.key,
          objectId: objectId ?? this.objectId,
          password: password ?? this.password,
          scope: scope ?? this.scope,
          username: username ?? this.username);
}
