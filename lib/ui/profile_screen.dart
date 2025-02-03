import 'package:find_friend/presentation/profile/profile_controller.dart';
import 'package:find_friend/ui/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../presentation/main_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileController());
  final ImagePicker picker = ImagePicker();
  final mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Column(
          children: [
            SizedBox(height: height),
            Container(
              height: 70,
              width: double.infinity,
              color: const Color(0xFF0098FF),
              child: const Center(
                  child: Text("My Profile",
                      style: TextStyle(
                          fontFamily: "WorkSans",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white))),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.name,
                style: TextStyle(
                    fontFamily: "WorkSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.start,
                controller: controller.nameController.value,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(
                      fontFamily: "WorkSans",
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    fontFamily: "WorkSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.start,
                controller: controller.emailController.value,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                      fontFamily: "WorkSans",
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(
                    fontFamily: "WorkSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.start,
                controller: controller.passwordController.value,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.visibility),
                  labelText: "Password",
                  labelStyle: TextStyle(
                      fontFamily: "WorkSans",
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        "Image:",
                        style: TextStyle(
                            fontFamily: "WorkSans",
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Colors.grey.withOpacity(0.2)),
                      child: Center(
                        child: Text(
                          controller.imagePath.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: "WorkSans",
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        controller.setImagePath(image);
                      }
                    },
                    child: const SizedBox(
                      width: 40,
                      height: 50,
                      child: Icon(Icons.file_upload),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {
                  controller.setLocation();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF0098FF)),
                  child: Center(
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Update Location",
                            style: TextStyle(
                                fontFamily: "WorkSans",
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {
                  if (!controller.isLoading.value &&
                      controller.nameController.value.text.isNotEmpty &&
                      controller.emailController.value.text.isNotEmpty &&
                      controller.passwordController.value.text.isNotEmpty) {
                    if (await controller.updateProfile(
                        controller.nameController.value.text,
                        controller.emailController.value.text,
                        controller.passwordController.value.text)) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF0098FF)),
                  child: Center(
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Update Profile",
                            style: TextStyle(
                                fontFamily: "WorkSans",
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  controller.logOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Log Out",
                        style: TextStyle(
                            fontFamily: "WorkSans",
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.red)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
