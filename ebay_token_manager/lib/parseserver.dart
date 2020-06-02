import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'extensions.dart';

class Parseserver {
  final String appId;
  final String restApiKey;
  final String appUrl;
  final String username;
  final String password;
  String _sessionToken;
  Parseserver(
      {this.appId, this.appUrl, this.restApiKey, this.username, this.password});
  Map<String, String> _newHeaders() {
    var headers = {
      'X-Parse-Application-Id': appId,
      'Content-Type': 'application/json',
      'X-Parse-REST-API-Key': restApiKey
    };
    if (_sessionToken != null) headers['X-Parse-Session-Token'] = _sessionToken;
    return headers;
  }

  Future<List<EbayToken>> getEbayToken() async {
    var tokens = await _getRemoteConfig('Configuration', 'ebay_access_token');
    return tokens.map((t) => EbayToken.fromJson(t)).toList(growable: false);
  }

  Future<List<dynamic>> _getRemoteConfig(String objectName, String key) async {
    if (_sessionToken == null) await _login(username, password);
    var headers = _newHeaders();
    var url =
        Uri.encodeFull('$appUrl/classes/$objectName?where={"key":"$key"}');
    var resp = await http.get(url, headers: headers);
    if (!resp.successful) throw HttpException(resp.reasonPhrase);
    var respData = jsonDecode(resp.body);
    return (respData['results'] as List<dynamic>);
  }

  Future<void> _login(String username, String password) async {
    var header = _newHeaders();
    header['X-Parse-Revocable-Session'] = '1';
    var url =
        Uri.encodeFull('$appUrl/login?username=$username&password=$password');
    var resp = await http.get(url, headers: header);
    if (!resp.successful) throw HttpException(resp.reasonPhrase);
    var respData = jsonDecode(resp.body);
    this._sessionToken = respData['sessionToken'];
  }

  Future<void> updateRemoteConfig(dynamic token) async {
    var header = _newHeaders();
    var url = '$appUrl/classes/Configuration/${token.objectId}';
    var body = jsonEncode(token);
    print(body);
    var resp = await http.put(url, headers: header, body: body);
    print(resp.body);
    if (!resp.successful) throw HttpException(resp.reasonPhrase);
  }
}
