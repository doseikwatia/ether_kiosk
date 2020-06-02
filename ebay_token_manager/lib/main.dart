import 'dart:convert';
import 'dart:io';
import 'model.dart';
import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'parseserver.dart';
import 'extensions.dart';

Future<void> main(List<String> arguments) async {
  const CONFIG_FILE = 'config-file';
  var parser = ArgParser()
    ..addOption(CONFIG_FILE,
        abbr: 'c',
        defaultsTo: 'config.json',
        help: 'Specifies configuration file');
  //Parsing argument
  ArgResults argResults;
  try {
    argResults = parser.parse(arguments);
  } catch (ex) {
    print(parser.usage);
    exit(1);
  }
  String cfgFilename = argResults[CONFIG_FILE];
  String cfgString;
  try {
    cfgString = File(cfgFilename).readAsStringSync();
  } catch (ex) {
    print('${ex.message}; filename: $cfgFilename');
    exit(1);
  }
  var cfgData = jsonDecode(cfgString);
  var cfg = Configuration.fromJson(cfgData);
  //initializing parserver
  var parseserver = Parseserver(
      appId: cfg.appId,
      appUrl: cfg.apiUrl,
      restApiKey: cfg.restApiKey,
      password: cfg.password,
      username: cfg.username);
  await refreshEbayToken(parseserver);
}

Future<void> refreshEbayToken(Parseserver parseserver) async {
  var tokens = await parseserver.getEbayToken();
  var ebaytoken = tokens[0];
  if (ebaytoken.accessToken != null &&
      ebaytoken.expireDate
          .subtract(Duration(minutes: 5))
          .isAfter(DateTime.now())) return;
  var authString =
      base64Encode('${ebaytoken.username}:${ebaytoken.password}'.codeUnits);
  var header = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Basic $authString',
  };
  var body =
      'grant_type=client_credentials&scope=${Uri.encodeComponent(ebaytoken.scope)}';
  var resp =
      await http.post(ebaytoken.authServerUrl, headers: header, body: body);
  if (!resp.successful) throw HttpException(resp.reasonPhrase);
  var newTokenData = jsonDecode(resp.body);
  parseserver.updateRemoteConfig(ebaytoken.copyWith(
      accessToken: newTokenData['access_token'],
      expire: newTokenData['expires_in'],
      expireDate:
          DateTime.now().add(Duration(seconds: newTokenData['expires_in']))));
}
