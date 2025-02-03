import 'package:find_friend/presentation/signup/signup_controller.dart';
import 'package:find_friend/ui/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(flex: 40, child: SizedBox()),
            Expanded(
              flex: 100,
              child: Center(
                child: Image.asset("assets/images/smile.png"),
              ),
            ),
            const Expanded(flex: 20, child: SizedBox()),
            const Expanded(
                flex: 45,
                child: Text(
                  "Join Us!",
                  style: TextStyle(
                      fontFamily: "WorkSans",
                      fontWeight: FontWeight.w400,
                      fontSize: 30
                  ),
                )
            ),
            const Expanded(flex: 20, child: SizedBox()),
            Expanded(
                flex: 300,
                child: Column(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                                fontFamily: "WorkSans",
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                            ),
                            textAlign: TextAlign.start,
                            controller: nameController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              focusColor: Colors.black,
                              labelText: "Name",
                              labelStyle: TextStyle(
                                  fontFamily: "WorkSans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 12),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontFamily: "WorkSans",
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                            ),
                            textAlign: TextAlign.start,
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              focusColor: Colors.black,
                              labelText: "Email",
                              labelStyle: TextStyle(
                                  fontFamily: "WorkSans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 12),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(
                                fontFamily: "WorkSans",
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                            ),
                            textAlign: TextAlign.start,
                            controller: passwordController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.visibility),
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  fontFamily: "WorkSans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 12),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(
                                fontFamily: "WorkSans",
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                            ),
                            textAlign: TextAlign.start,
                            controller: confirmPassController,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.visibility),
                              labelText: "Confirm Password",
                              labelStyle: TextStyle(
                                  fontFamily: "WorkSans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 12),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                color: Colors.white
                            ),
                            child: Center(
                              child: Text(
                                "Image:",
                                style: TextStyle(
                                    fontFamily: "WorkSans",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                  color: Colors.grey.withOpacity(0.2)
                              ),
                              child: Center(
                                child: Text(
                                  controller.imagePath.value,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: "WorkSans",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
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
                    ))
                  ],
                )
            ),
            const Expanded(flex: 50, child: SizedBox()),
            Expanded(
                flex: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () async {
                      if(!controller.isLoading.value && passwordController.text == confirmPassController.text) {
                        if(await controller.signUp(email: emailController.text, password: passwordController.text, name: nameController.text)) {
                          Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ro'yxatdan o'tish amalga oshmadi!")));
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF0098FF)
                      ),
                      child: Center(
                        child: controller.isLoading.value ? CircularProgressIndicator(color: Colors.white) : Text(
                          "SignUp",
                          style: TextStyle(
                              fontFamily: "WorkSans",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
            const Expanded(flex: 20, child: SizedBox()),
            Expanded(
                flex: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account? ",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "WorkSans",
                          fontSize: 18
                      ),
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: "WorkSans",
                            fontSize: 18
                        ),
                      ),
                    ),
                  ],
                )
            ),
            const Expanded(flex: 20, child: SizedBox())
          ],
        );
      }),
    );
  }
}
