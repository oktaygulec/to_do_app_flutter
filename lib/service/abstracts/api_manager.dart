import 'dart:convert';
import 'package:http/http.dart' as http;
import '/service/api/_URIs.dart';
import '/service/api/user_api.dart';

enum MethodType { GET, POST, PUT, DELETE }

abstract class ApiManager {
  String get token => UserApi.currentUser.token;
  final String todoURI = URIs.TODO_URI;
  final String userURI = URIs.USER_URI;
  final String userLoginURI = URIs.USER_LOGIN_URI;

  Map<String, String> get getHeadersJSON => {
        'Content-Type': 'application/json; charset=UTF-8',
      };
  Map<String, String> get getHeadersWithToken => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

  Future<http.Response> request(
      String uri, Map<String, String> headers, MethodType methodType,
      {Map? body}) async {
    switch (methodType) {
      case MethodType.GET:
        return await http.get(Uri.parse(uri), headers: headers);
      case MethodType.POST:
        return await http.post(Uri.parse(uri),
            headers: headers, body: jsonEncode(body));
      case MethodType.PUT:
        return await http.put(Uri.parse(uri),
            headers: headers, body: jsonEncode(body));
      case MethodType.DELETE:
        return await http.delete(Uri.parse(uri), headers: headers);
    }
  }

  bool checkRequest(http.Response response,
      {String? successMessage, String? errorMessage}) {
    if (response.statusCode == 200) {
      print(successMessage ?? "Success! ${response.statusCode}");
      return true;
    }
    print(errorMessage ?? "Error! ${response.statusCode}");
    return false;
  }
}
