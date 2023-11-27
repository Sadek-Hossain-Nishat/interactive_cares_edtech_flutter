import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_cares_app/domainlayer/auth_viewmodel.dart';
import 'package:interactive_cares_app/domainlayer/color_util.dart';
import 'package:interactive_cares_app/uilayer/signin/signin_page.dart';
import 'package:interactive_cares_app/uilayer/signup/signup_page.dart';

Widget commonAppBar(String pagename) {
  var authviewmodel = Get.put(AuthViewModel());
  return Container(
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
                              middleText: authviewmodel.currentuserEmail.value,
                              middleTextStyle: TextStyle(
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
                                  Text(authviewmodel.currentuserEmail.value,
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: const Color.fromRGBO(
                                              0, 188, 212, 1),
                                          fontWeight: FontWeight.w500)),
                                  Row(children: [
                                    Icon(Icons.power_off,
                                        color: Colors.blueGrey),
                                    Text('Sign OUt?',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: AppColor.primarycolor,
                                            fontWeight: FontWeight.w500))
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.r))),
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
                                    transition: Transition.rightToLeft);
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
                                    transition: Transition.rightToLeft);
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
  );
}
