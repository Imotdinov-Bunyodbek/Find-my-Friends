import 'package:find_friend/presentation/login/login_controller.dart';
import 'package:find_friend/ui/home_screen.dart';
import 'package:find_friend/ui/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final controller = Get.put(LoginController());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(flex: 70, child: SizedBox()),
              Expanded(
                flex: 137,
                child: Center(
                  child: Image.asset("assets/images/smile.png"),
                ),
              ),
              const Expanded(flex: 32, child: SizedBox()),
              const Expanded(
                  flex: 45,
                  child: Text(
                    "Welcome back!",
                    style: TextStyle(
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.w400,
                        fontSize: 30),
                  )),
              const Expanded(flex: 40, child: SizedBox()),
              Expanded(
                  flex: 140,
                  child: Column(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSans",
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
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
                      )),
                      SizedBox(height: 20),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(
                              fontFamily: "WorkSans",
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          textAlign: TextAlign.start,
                          controller: passwordController,
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
                      )),
                    ],
                  )),
              const Expanded(flex: 16, child: SizedBox()),
              const Expanded(
                  flex: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text("Forgot password?"), SizedBox(width: 20)],
                  )),
              const Expanded(flex: 40, child: SizedBox()),
              Expanded(
                  flex: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () async {
                        if (await controller.login(
                            email: emailController.text,
                            password: passwordController.text)) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF0098FF)),
                        child: Center(
                          child: controller.isLoading.value
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "Login",
                                  style: const TextStyle(
                                      fontFamily: "WorkSans",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25,
                                      color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  )),
              const Expanded(flex: 40, child: SizedBox()),
              Expanded(
                  flex: 24,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                          height: 1,
                          color: Colors.black54,
                        )),
                        SizedBox(width: 8),
                        Text(
                          "or",
                          style: TextStyle(
                              fontFamily: "WorkSans",
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              height: -0.19,
                              color: Colors.black),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: Colors.black54,
                        ))
                      ],
                    ),
                  )),
              const Expanded(flex: 40, child: SizedBox()),
              Expanded(
                  flex: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                                style: BorderStyle.solid)),
                        child: Center(
                          child: Image.asset("assets/images/facebook.png",
                              width: 30, height: 30),
                        ),
                      ),
                      SizedBox(width: 24),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                                style: BorderStyle.solid)),
                        child: Center(
                          child: Image.asset("assets/images/google.png",
                              width: 30, height: 30),
                        ),
                      ),
                      SizedBox(width: 24),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                                style: BorderStyle.solid)),
                        child: Center(
                          child: Image.asset("assets/images/apple.png",
                              width: 30, height: 30),
                        ),
                      ),
                    ],
                  )),
              const Expanded(flex: 40, child: SizedBox()),
              Expanded(
                  flex: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: "WorkSans",
                            fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "WorkSans",
                              fontSize: 18),
                        ),
                      ),
                    ],
                  )),
              const Expanded(flex: 40, child: SizedBox())
            ],
          );
        }));
  }
}
