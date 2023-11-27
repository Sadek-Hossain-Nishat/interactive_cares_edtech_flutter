import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_cares_app/domainlayer/commpon_appbar.dart';
import 'package:interactive_cares_app/domainlayer/course_item_view.dart';

class CategoryItemPage extends StatefulWidget {
  String name;
  CategoryItemPage({super.key, required this.name});

  @override
  State<CategoryItemPage> createState() => _CategoryItemPageState(this.name);
}

class _CategoryItemPageState extends State<CategoryItemPage> {
  String name;
  _CategoryItemPageState(this.name);
  var _coursetitle = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   name == 'Graphics'
    //       ? _coursetitle = '${name} Design'
    //       : '{$name} Development';
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        commonAppBar(name),
        Padding(
            padding: EdgeInsets.all(15.0.w),
            child: Column(
              children: [
                Row(children: [
                  Text(
                      name == 'Graphics'
                          ? '${name} Design'
                          : name == 'Popular'
                              ? '${name} Course'
                              : '${name} App Development',
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.w500))
                ]),
                SizedBox(height: 60.h),
                AspectRatio(
                  aspectRatio: 0.5,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .where('product-name', isEqualTo: name)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Something went wrong!...',
                                style: TextStyle(color: Colors.black)),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Text(
                            'Loading',
                            style: TextStyle(color: Colors.black),
                          ));
                        }

                        return ListView(
                          children: snapshot.data!.docs.map((document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;

                            return CousreItemView.courseItemView(
                                data['course_type'],
                                data['course_title'],
                                data['course_video'],
                                data['course_enroll'],
                                data['course_complete'],
                                data['course_position']);
                          }).toList(),
                        );
                      }),
                )
              ],
            ))
      ]),
    )));
  }
}
