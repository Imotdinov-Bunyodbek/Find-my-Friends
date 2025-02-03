import 'dart:io';

import 'package:find_friend/data/model/app_lat_long.dart';
import 'package:find_friend/data/services/location_service.dart';
import 'package:find_friend/data/model/my_hive.dart';
import 'package:find_friend/data/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/model/user.dart';

class ProfileController extends GetxController {
  late MyHiveHelper hive;
  late AuthRepository repository;
  late LocationService locationService;
  late AppLatLong location;
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  late User user;

  void init() {
    hive = MyHiveHelper();
    user = hive.getUser();
    nameController.value.text = user.name;
    emailController.value.text = user.email;
    passwordController.value.text = user.password;
    imagePath.value = user.image;
    repository = AuthRepository();
    locationService = LocationService();
  }

  var imagePath = "".obs;
  var isLoading = false.obs;

  void setImagePath(XFile image) async {
    imagePath.value = image.path;
  }
  Future<void> setLocation() async {
    isLoading.value = true;
    location = await locationService.getCurrentLocation();
    isLoading.value = false;
  }

  void logOut() {
    hive.clear();
  }

  Future<bool> updateProfile(String name, String email, String password) async {
    isLoading.value = true;
    File image = File(imagePath.value);
    var imageUrl = await repository.uploadImage(image);
    final newUser = User(id: user.id, name: name, email: email, password: password, image: imageUrl, lat: location.lat.toString(), long: location.long.toString());
    if(await repository.update(newUser)) {
      hive.setUser(newUser);
      isLoading.value = false;
      return true;
    } else {
      isLoading.value = false;
      return false;
    }
  }
}
