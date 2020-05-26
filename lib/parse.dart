
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Parseserver {
  static Parse _app;

  static Parse get app=> _app;
  
  static Future initialize() async {
    _app = await Parse().initialize(
      'OaoQtXvrIncvFLwOv8qsUuH2DeEhiPn8bdjGPg1X', 
      'https://parseapi.back4app.com/', 
      clientKey: 'wQZXFJXbKp9uZRElTQkbDmyF8maVaY5qNBB7q3bw',
      appName: 'etherKiosk',
      debug: true
    );
  }
}
