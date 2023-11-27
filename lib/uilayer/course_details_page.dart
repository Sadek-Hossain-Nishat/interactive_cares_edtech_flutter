import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_cares_app/domainlayer/commpon_appbar.dart';

class CourseDetailsPage extends StatefulWidget {
  String course_type;
  String course_title;
  String course_video;
  bool course_enroll;
  bool course_complete;
  int course_position;
  CourseDetailsPage({
    super.key,
    required this.course_type,
    required this.course_title,
    required this.course_video,
    required this.course_enroll,
    required this.course_complete,
    required this.course_position,
  });

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState(
        this.course_type,
        this.course_title,
        this.course_video,
        this.course_enroll,
        this.course_complete,
        this.course_position,
      );
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  String course_type;
  String course_title;
  String course_video;
  bool course_enroll;
  bool course_complete;
  int course_position;
  _CourseDetailsPageState(
      this.course_type,
      this.course_title,
      this.course_video,
      this.course_enroll,
      this.course_complete,
      this.course_position);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        commonAppBar(course_type),
        AspectRatio(
          aspectRatio: 0.4,
          child: Padding(
              padding: EdgeInsets.all(15.0.w),
              child: Column(
                children: [
                  Row(children: [
                    Text('',
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.w500))
                  ]),
                  SizedBox(height: 60.h),
                ],
              )),
        )
      ]),
    )));
  }
}
