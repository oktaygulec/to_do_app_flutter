import 'dart:convert';
import '/data/models/user.dart';
import '/service/abstracts/api_manager.dart';

class UserApi extends ApiManager {
  static User currentUser = new User();

  Future<bool> login(User user) async {
    final response = await super.request(
      userLoginURI,
      getHeadersJSON,
      MethodType.POST,
      body: user.toJson(),
    );

    final isOK = checkRequest(
      response,
      successMessage: "Logged in!",
      errorMessage: "Login error! - Status code: ${response.statusCode}",
    );

    if (isOK) {
      final body = json.decode(response.body);
      user =
          await getUser(user.email); // fill name, isActive, createdTime, v etc.
      currentUser = user; // set global user
      currentUser.token = body["token"]; // set global user's token
      return true;
    }
    return false;
  }

  Future<void> register(User user) async {
    final response = await request(
      userURI,
      getHeadersJSON,
      MethodType.POST,
      body: user.toJson(),
    );

    checkRequest(
      response,
      successMessage: "Registered",
      errorMessage: "Register error! Status code: ${response.statusCode}",
    );
  }

  Future<User> getUser(String email) async {
    final response = await request(userURI, getHeadersJSON, MethodType.GET);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      for (var item in body) {
        if (item["email"] == email) {
          print("User found: ${item["_id"]}");
          return User.fromJson(item);
        }
      }
      print("User not found...");
      return new User();
    }
    print("getUser error. Status code: ${response.statusCode}");
    return new User();
  }

  Future<bool> isUser(String email) async {
    User u = await getUser(email);
    return u.id != "" ? true : false;
  }
}
