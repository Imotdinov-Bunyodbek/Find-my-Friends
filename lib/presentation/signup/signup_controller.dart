import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/model/location_service.dart';
import '../../data/model/my_hive.dart';
import '../../data/model/user.dart';
import '../../data/repository/auth_repository.dart';

class SignUpController extends GetxController{
  final AuthRepository repository = AuthRepository();
  final LocationService locationService = LocationService();
  var isSuccess = false.obs;
  var imagePath = "".obs;
  var isLoading = false.obs;
  final hive = MyHiveHelper();

  Future<bool> signUp({required String email, required String password, required String name}) async {
    isLoading.value = true;
    File image = File(imagePath.value);
    var imageUrl = await repository.uploadImage(image);
    final location = await locationService.getCurrentLocation();
    final user = User(id: "", name: name, email: email, password: password, image: imageUrl, lat: location.lat.toString(), long: location.long.toString());
    if(await repository.signUp(user)) {
      hive.setUser(user);
      isLoading.value = false;
      return true;
    }
    isLoading.value = false;
    return false;
  }
  void setImagePath(XFile image) async {
    imagePath.value = image.path;
  }
}