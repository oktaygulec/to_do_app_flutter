import '/data/models/user.dart';
import '/service/abstracts/storage_manager.dart';
import '/service/api/user_api.dart';

class UserStorage extends StorageManager {
  Future<User> getUser() async {
    final token = await readData("user_token");

    if (token == null) {
      return User();
    }

    if (UserApi.currentUser.token.isEmpty) {
      UserApi.currentUser = User.fromLocal({
        "id": await readData("user_id"),
        "name": await readData("user_name"),
        "email": await readData("user_email"),
        "password": await readData("user_password"),
        "isActive": await readData("user_isActive"),
        "createdTime": await readData("user_createdTime"),
        "v": await readData("user_v"),
        "token": await readData("user_token")
      });
    }

    return UserApi.currentUser;
  }

  Future<void> saveUser(User user) async {
    Map userData = user.toLocal();

    await saveData("user_id", userData["id"]);
    await saveData("user_name", userData["name"]);
    await saveData("user_email", userData["email"]);
    await saveData("user_password", userData["password"]);
    await saveData("user_isActive", userData["isActive"]);
    await saveData("user_createdTime", userData["createdTime"]);
    await saveData("user_v", userData["v"]);
    await saveData("user_token", userData["token"]);

    UserApi.currentUser = user;

    print("Local user data saved.");
  }

  Future<void> deleteUser() async {
    await deleteData("user_id");
    await deleteData("user_name");
    await deleteData("user_email");
    await deleteData("user_password");
    await deleteData("user_isActive");
    await deleteData("user_createdTime");
    await deleteData("user_v");
    await deleteData("user_token");

    UserApi.currentUser = User();

    print("Local user data deleted");
  }
}
