import 'package:find_friend/data/repository/auth_repository.dart';
import 'package:get/get.dart';

import '../../data/model/user.dart';

class HomeController extends GetxController {
  var userList = <User>[].obs;
  final repository = AuthRepository();
  Future<void> init() async {
    userList.value = await repository.getUsers();
  }
}
