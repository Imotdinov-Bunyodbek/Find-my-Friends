import 'package:find_friend/data/repository/auth_repository.dart';
import 'package:find_friend/data/model/my_hive.dart';
import 'package:get/get.dart';

import '../../data/model/user.dart';

class LoginController extends GetxController {
  final AuthRepository repository = AuthRepository();
  final isLoading = false.obs;
  final hive = MyHiveHelper();
  var _users = <User>[];
  void init() async {
    _users = await repository.getUsers();
  }
  bool login({required String email, required String password}) {
    isLoading.value = true;
    for(int i = 0; i < _users.length; i++)  {
      if(_users[i].email == email && _users[i].password == password) {
        hive.setUser(_users[i]);
        isLoading.value = false;
        return true;
      }
    }
    isLoading.value = false;
    return false;
  }

}