import 'package:http/http.dart' as http;
import 'package:traveling/core/enums/request_type.dart';

class NetworkUtil {
  static String baseUrl = 'fakestoreapi.com';

  static Future<dynamic> sendRequest({
    required RequestType type,
    required String route,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
  }) async {
    var url = Uri.https(baseUrl, route, params);
    var response;

    switch (type) {
      case RequestType.POST:
        response = await http.post(url, body: body, headers: headers);
        break;
      case RequestType.GET:
        response = await http.get(url, headers: headers);
        break;
      case RequestType.DELETE:
        response = await http.delete(url, body: body, headers: headers);
        break;
      case RequestType.PUT:
        response = await http.put(url, body: body, headers: headers);
        break;
    }

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }
}
