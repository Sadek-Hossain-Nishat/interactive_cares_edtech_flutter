import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_cares_app/uilayer/category_item_page.dart';

class CategoryData {
  static final categories = [
    {"name": "Popular", "icon": Icons.people},
    {"name": "Web", "icon": Icons.webhook},
    {"name": "Mobile", "icon": Icons.mobile_friendly},
    {"name": "Graphics", "icon": Icons.graphic_eq_sharp},
  ];

  static Widget CategoryView(String name, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(
              CategoryItemPage(
                name: name,
              ),
              duration:
                  Duration(seconds: 1), //duration of transitions, default 1 sec
              transition: Transition.rightToLeft);
        },
        child: new Container(
          child: new Card(
            child: new Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(icon, size: 100.0.sp, color: Colors.blueAccent),
                    SizedBox(height: 10.h),
                    Text(name, style: TextStyle(color: Colors.blueAccent))
                  ],
                ),
              ),
            ),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          // decoration: new BoxDecoration(
          //   boxShadow: [
          //     new BoxShadow(
          //       color: Colors.black,
          //       blurRadius: 20.0,
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
