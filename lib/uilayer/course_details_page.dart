import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_cares_app/domainlayer/commpon_appbar.dart';
import 'package:interactive_cares_app/domainlayer/course_item_view.dart';

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
              child: Center(
                child: Column(
                  children: [
                    new Card(
                      child: CousreItemView.videoThumnail(course_video),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    Text(course_title,
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 20.h),
                    Text('by Sadek Hossain Nishat',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400)),
                    SizedBox(height: 50.h),
                    course_enroll == false
                        ? InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                  title: '',
                                  content: Container(
                                    height: 250.h,
                                    width: 200.w,
                                    child: Card(
                                      elevation: 0,
                                      //Card with circular border
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 30.h),
                                          Text('This course is not enrolled',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(height: 30.h),
                                          SizedBox(
                                            height: 50.h,
                                            width: 180.w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              Colors
                                                                  .blueAccent),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                      ))),
                                                  onPressed: () {},
                                                  child: Text('Enroll Now'),
                                                ),
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              Colors.redAccent),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                      ))),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                            child: Container(
                              height: 50.h,
                              width: 180.w,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(15.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Start Right Now!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp)),
                                      Icon(Icons.send,
                                          color: Colors.white, size: 16.sp)
                                    ],
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r))),
                            ))
                        : SizedBox(
                            height: 50.h,
                            width: 180.w,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.green),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ))),
                              onPressed: () {},
                              child: Text('Already enrolled'),
                            ),
                          ),
                    SizedBox(height: 60.h),
                    Row(
                      children: [
                        Text('About This Course',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 300.w,
                          child: Text(
                            'The Future of Programming: Collaboration Between AI and Programmers. Rather than AI replacing developers, it will likely reshape their role. Collaboration is the most likely scenario for the coming future. Equipped with next-generation AI tools, developers will be relieved from mundane, time-consuming routines',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        )
      ]),
    )));
  }
}
