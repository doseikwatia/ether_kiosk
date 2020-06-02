import 'package:http/http.dart' as http;

extension Ext on http.Response {
  bool get successful => this.statusCode >= 200 && this.statusCode <= 299;
}
