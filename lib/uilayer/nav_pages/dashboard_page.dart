import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_cares_app/domainlayer/commpon_appbar.dart';
import 'package:interactive_cares_app/domainlayer/course_item_view.dart';
import 'package:interactive_cares_app/uilayer/signin/signin_page.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool userExist = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final currentUser = _auth.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          userExist = false;
        });
      } else {
        print('User is signed in!');
        setState(() {
          userExist = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
      children: [
        commonAppBar('Dashboard'),
        SizedBox(height: 60.h),
        userExist
            ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.w),
                    child: Row(children: [
                      Text('Enrolled Course',
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.w500))
                    ]),
                  ),
                  AspectRatio(
                    aspectRatio: 0.2,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("usersdata/users/${currentUser!.email}")
                            .where('course_enroll', isEqualTo: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  'Something went wrong!... ${snapshot.error}',
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
                            physics: const NeverScrollableScrollPhysics(),
                            children: snapshot.data!.docs.map((document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;

                              return CousreItemView.EnrollItemView(
                                data['course_type'],
                                data['course_title'],
                                data['course_video'],
                                data['course_enroll'],
                                data['course_complete'],
                                data['course_position'],
                              );
                            }).toList(),
                          );
                        }),
                  ),
                ],
              )
            : SizedBox(
                height: 50.h,
                width: 180.w,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () {
                    Get.offAll(SignInPage(),
                        duration: Duration(
                            seconds:
                                2), //duration of transitions, default 1 sec
                        transition: Transition.leftToRight);
                  },
                  child: Text('Sign In'),
                ),
              )
      ],
    ))));
  }
}
