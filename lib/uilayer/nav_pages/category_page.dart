import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_cares_app/domainlayer/category_util.dart';
import 'package:interactive_cares_app/domainlayer/commpon_appbar.dart';

class Category extends StatelessWidget {
  Category({super.key});

  final categorylist = CategoryData.categories;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commonAppBar('Catergory'),
        Padding(
          padding: EdgeInsets.all(15.0.w),
          child: Column(
            children: [
              Row(children: [
                Text('Select Your Favourite', style: TextStyle(fontSize: 20.sp))
              ]),
              Row(children: [
                Text('Category',
                    style: TextStyle(
                        fontSize: 20.sp, fontWeight: FontWeight.w700)),
                Text('And Start Learning', style: TextStyle(fontSize: 20.sp)),
              ]),
              SizedBox(height: 50.h),
              AspectRatio(
                  aspectRatio: 1,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categorylist.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1),
                      itemBuilder: (_, index) {
                        return CategoryData.CategoryView(
                            categorylist[index]['name'] as String,
                            categorylist[index]['icon'] as IconData);
                      }))
            ],
          ),
        ),
      ],
    ))));
  }
}
