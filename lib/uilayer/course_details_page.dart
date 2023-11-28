import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_cares_app/domainlayer/commpon_appbar.dart';
import 'package:interactive_cares_app/domainlayer/course_item_view.dart';
import 'package:interactive_cares_app/uilayer/bottom_nav.dart';
import 'package:interactive_cares_app/uilayer/course_player_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseDetailsPage extends StatefulWidget {
  String course_type;
  String course_title;
  String course_video;
  bool course_enroll;
  bool course_complete;
  int course_position;
  final String videoId;
  final List<String> videolist;
  final List<String> ids;

  CourseDetailsPage({
    super.key,
    required this.course_type,
    required this.course_title,
    required this.course_video,
    required this.course_enroll,
    required this.course_complete,
    required this.course_position,
    required this.videoId,
    required this.videolist,
    required this.ids,
  });

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  bool enroll = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    FirebaseFirestore.instance
        .collection("usersdata/users/${currentUser!.email}")
        .where('course_title', isEqualTo: widget.course_title)
        .get()
        .then((value) {
      value.docs.forEach((doc) {
        setState(() {
          enroll = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        commonAppBar(widget.course_type),
        AspectRatio(
          aspectRatio: 0.4,
          child: Padding(
              padding: EdgeInsets.all(15.0.w),
              child: Center(
                child: Column(
                  children: [
                    new Card(
                      child: CousreItemView.videoThumnail(widget.course_video),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    Text(widget.course_title,
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 20.h),
                    Text('by Sadek Hossain Nishat',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400)),
                    SizedBox(height: 50.h),
                    enroll == false
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
                                                  onPressed: () {
                                                    enrollNow();
                                                  },
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
                              onPressed: () {
                                Get.to(
                                    CoursePlayerPage(
                                        course_type: widget.course_type,
                                        course_title: widget.course_title,
                                        course_video: widget.course_video,
                                        course_enroll: widget.course_enroll,
                                        course_complete: widget.course_complete,
                                        course_position: widget.course_position,
                                        videoId: widget.videoId,
                                        ids: widget.ids),
                                    duration: Duration(
                                        seconds:
                                            1), //duration of transitions, default 1 sec
                                    transition: Transition.rightToLeft);
                              },
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
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Text('About This Course',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    AspectRatio(
                        aspectRatio: 0.4,
                        child: Container(
                            child: ListView.builder(
                          // Let the ListView know how many items it needs to build.
                          itemCount: widget.videolist.length,
                          // Provide a builder function. This is where the magic happens.
                          // Convert each item into a widget based on the type of item it is.
                          itemBuilder: (context, index) {
                            final item = widget.videolist[index];

                            return ListTile(
                              leading: CousreItemView.videotileimg(item),
                              title: Text('Part-${index}'),
                            );
                          },
                        )))
                  ],
                ),
              )),
        )
      ]),
    )));
  }

  void enrollNow() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.defaultDialog(
            title: '',
            content: Container(
              height: 250.h,
              width: 230.w,
              child: Card(
                elevation: 0,
                //Card with circular border
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(
                    child: Column(
                  children: [
                    Text('OOPS! You are not signed in',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 30.h),
                    SizedBox(
                      height: 50.h,
                      width: 180.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blueAccent),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                            onPressed: () {
                              Get.offAll(BottomNav()
                                  // duration:
                                  //     Duration(seconds: 2), //duration of transitions, default 1 sec
                                  // transition: Transition.leftToRight
                                  );
                            },
                            child: Text('Sign In'),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.redAccent),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
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
                )),
              ),
            ));
      } else {
        print('User is signed in!');
        // isSigned.value = true;
        // currentuserEmail.value = user.email!;

        final FirebaseAuth _auth = FirebaseAuth.instance;
        var currentUser = _auth.currentUser;
        CollectionReference _collectionRef = FirebaseFirestore.instance
            .collection("usersdata/users/${currentUser!.email}");

        _collectionRef.doc().set({
          "course_type": widget.course_type,
          "course_title": widget.course_title,
          "course_video": widget.videolist,
          "course_enroll": true,
          "course_complete": false,
          "course_position": [0, 0]
        }).then((value) {
          Get.back();
          Get.defaultDialog(
              title: '',
              content: Container(
                height: 250.h,
                width: 230.w,
                child: Card(
                  elevation: 0,
                  //Card with circular border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                      child: Column(
                    children: [
                      Icon(Icons.done, size: 100.sp, color: Colors.green),
                      SizedBox(height: 30.h),
                      Text('Successfully Enrolled',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.green,
                              fontWeight: FontWeight.w700))
                    ],
                  )),
                ),
              ));
          Timer(Duration(seconds: 2), () {
            Get.back();
            Get.to(
                CoursePlayerPage(
                    course_type: widget.course_type,
                    course_title: widget.course_title,
                    course_video: widget.course_video,
                    course_enroll: widget.course_enroll,
                    course_complete: widget.course_complete,
                    course_position: widget.course_position,
                    videoId: widget.videoId,
                    ids: widget.ids),
                duration: Duration(
                    seconds: 1), //duration of transitions, default 1 sec
                transition: Transition.rightToLeft);
          });
        }).catchError((error) => print("something is wrong"));
      }
    });
  }
}
