import 'package:find_friend/data/repository/auth_repository.dart';
import 'package:get/get.dart';

import '../../data/model/my_hive.dart';
import '../../data/model/user.dart';

class HomeController extends GetxController {
  var userList = <User>[].obs;
  final repository = AuthRepository();
  final currentUser = MyHiveHelper().getUser();
  Future<void> init() async {
    var tempList = await repository.getUsers();
    tempList.removeWhere((user) => user.email == currentUser.email && user.password == currentUser.password);
    userList.value = tempList;
  }
}