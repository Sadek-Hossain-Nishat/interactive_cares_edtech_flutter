import 'package:flutter/material.dart';
import 'package:interactive_cares_app/domainlayer/commpon_appbar.dart';

class CoursePlayerPage extends StatefulWidget {
  String course_type;
  String course_title;
  String course_video;
  bool course_enroll;
  bool course_complete;
  int course_position;
  CoursePlayerPage({
    super.key,
    required this.course_type,
    required this.course_title,
    required this.course_video,
    required this.course_enroll,
    required this.course_complete,
    required this.course_position,
  });

  @override
  State<CoursePlayerPage> createState() => _CoursePlayerPageState(
        this.course_type,
        this.course_title,
        this.course_video,
        this.course_enroll,
        this.course_complete,
        this.course_position,
      );
}

class _CoursePlayerPageState extends State<CoursePlayerPage> {
  String course_type;
  String course_title;
  String course_video;
  bool course_enroll;
  bool course_complete;
  int course_position;
  _CoursePlayerPageState(this.course_type, this.course_title, this.course_video,
      this.course_enroll, this.course_complete, this.course_position);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(children: [commonAppBar(course_type)]),
    )));
  }
}
