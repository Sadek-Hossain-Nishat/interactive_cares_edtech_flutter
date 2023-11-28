import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interactive_cares_app/domainlayer/auth_viewmodel.dart';
import 'package:interactive_cares_app/domainlayer/color_util.dart';
import 'package:interactive_cares_app/uilayer/category_item_page.dart';
import 'package:interactive_cares_app/uilayer/signin/signin_page.dart';
import 'package:interactive_cares_app/uilayer/signup/signup_page.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final authviewmodel = Get.put(AuthViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColor.primarycolor,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'images/splashlogo.png',
                          width: 100.w,
                          height: 90.h,
                        ),
                        // SizedBox(
                        //   width: 120.w,
                        // ),
                        Obx(
                          () => authviewmodel.isSigned == true
                              ? InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                        title: 'Info',
                                        titleStyle: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w600),
                                        textConfirm: 'Yes',
                                        textCancel: 'No',
                                        confirmTextColor: Colors.white,
                                        cancelTextColor: Colors.blueGrey,
                                        onConfirm: () {
                                          authviewmodel.signOut();
                                          Get.back();
                                        },
                                        content: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    authviewmodel
                                                        .currentuserEmail.value,
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: AppColor
                                                            .primarycolor,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                            Row(children: [
                                              Icon(Icons.power_off,
                                                  color: AppColor.primarycolor),
                                              Text('Sign OUt?',
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color:
                                                          AppColor.primarycolor,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ]),
                                          ],
                                        ));
                                  },
                                  child: CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: Colors.blueGrey,
                                    child: Obx(() => Text(
                                        authviewmodel.currentuserEmail.value[0]
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 30.sp))),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.all(5.w),
                                  width: 110.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r))),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        onTap: () {
                                          Get.to(SignInPage(),
                                              duration: Duration(
                                                  seconds:
                                                      2), //duration of transitions, default 1 sec
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                      ),
                                      Text(
                                        '|',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      GestureDetector(
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        onTap: () {
                                          Get.to(SignUpPage(),
                                              duration: Duration(
                                                  seconds:
                                                      2), //duration of transitions, default 1 sec
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 0.7,
              child: Container(
                // height: 300.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/backgroundimage.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  // make sure we apply clip it properly
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.transparent.withOpacity(0.5),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200.h,
                          ),
                          Text(
                            "Enhance Your",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "Learning",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Row(
                              children: [
                                Text(
                                  "Popular",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: OutlinedButton(
                                      onPressed: () {
                                        Get.to(CategoryItemPage(name: 'Web'),
                                            duration: Duration(
                                                seconds:
                                                    1), //duration of transitions, default 1 sec
                                            transition: Transition.rightToLeft);
                                      },
                                      child: Text(
                                        "Web",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.8)))),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: OutlinedButton(
                                      onPressed: () {
                                        Get.to(CategoryItemPage(name: 'Mobile'),
                                            duration: Duration(
                                                seconds:
                                                    1), //duration of transitions, default 1 sec
                                            transition: Transition.rightToLeft);
                                      },
                                      child: Text(
                                        "Mobile",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.8)))),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: OutlinedButton(
                                      onPressed: () {
                                        Get.to(
                                            CategoryItemPage(name: 'Graphics'),
                                            duration: Duration(
                                                seconds:
                                                    1), //duration of transitions, default 1 sec
                                            transition: Transition.rightToLeft);
                                      },
                                      child: Text(
                                        "Graphics",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.8)))),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AspectRatio(
                aspectRatio: 2,
                child: Container(
                    color: Colors.blue,
                    child: Center(
                      child: Column(children: [
                        SizedBox(height: 50.h),
                        Text(
                          "Select Your Favourite Category & Start Learning",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                    ))),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                // height: 300.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/homelogo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
