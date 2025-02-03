import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_friend/presentation/main_controller.dart';
import 'package:find_friend/ui/map_screen.dart';
import 'package:find_friend/presentation/home/home_controller.dart';
import 'package:find_friend/ui/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  late HomeController controller;

  HomeScreen({super.key}) {
    controller = Get.put(HomeController());
    controller.init();
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isEnabled = false;
  final mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).padding.top;
    return Scaffold(
        backgroundColor:
            mainController.isDark.value ? Colors.black : Colors.white,
        body: SafeArea(
          child: Obx(() {
            return Column(
              children: [
                Container(
                  height: 70,
                  width: double.infinity,
                  color: Color(0xFF0098FF),
                  child: Stack(
                    children: [
                      const Positioned.fill(
                          child: Center(
                        child: Text("My Friends",
                            style: TextStyle(
                                fontFamily: "WorkSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white)),
                      )),
                      Positioned.fill(
                        right: 16,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Switch(
                                value: isEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    isEnabled = value;
                                    mainController.isDark.value = value;
                                  });
                                })),
                      ),
                      Positioned.fill(
                        left: 16,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => ProfileScreen()));
                              },
                              child: Icon(Icons.person,
                                  size: 24, color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
                Flexible(
                    child: ListView.separated(
                        padding: EdgeInsets.only(top: height),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => MapScreen(
                                            user: widget
                                                .controller.userList[index])));
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(28),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: widget
                                            .controller.userList[index].image,
                                        width: 48,
                                        height: 48),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    widget.controller.userList[index].name,
                                    style: TextStyle(
                                        fontFamily: "WorkSans",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: mainController.isDark.value
                                            ? Colors.white
                                            : Colors.black),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemCount: widget.controller.userList.length)),
              ],
            );
          }),
        ));
  }
}
