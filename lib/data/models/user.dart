class User {
  late String id = "";
  late String token = "";
  late final String name;
  late final String email;
  late final String password;
  late final bool isActive;
  late final String createdTime;
  late final int v;

  User();

  User.newUser({
    this.name = "",
    this.token = "",
    required this.email,
    required this.password,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    isActive = json['isActive'];
    createdTime = json['createdTime'];
    v = json['__v'];
  }

  User.fromLocal(Map<String, dynamic> localData) {
    id = localData["id"];
    name = localData['name'];
    email = localData['email'];
    password = localData['password'];
    isActive = localData['isActive'];
    createdTime = localData['createdTime'];
    v = localData['v'];
    token = localData['token'];
  }

  Map toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };

  Map toLocal() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "isActive": isActive,
        "createdTime": createdTime,
        "v": v,
        "token": token
      };
}
