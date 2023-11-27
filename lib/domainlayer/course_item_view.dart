import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CousreItemView {
  static Widget courseItemView(
      String course_type,
      String course_title,
      String course_video,
      bool course_enroll,
      bool course_complete,
      int course_position) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: () {
          // Get.to(
          //     CategoryItemPage(
          //       name: name,
          //     ),
          //     duration:
          //         Duration(seconds: 1), //duration of transitions, default 1 sec
          //     transition: Transition.rightToLeft);
          print(course_title);
        },
        child: new Container(
          height: 300.h,
          child: new Card(
            child: new Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    videoThumnail(course_video),
                    SizedBox(height: 20.h),
                    Text(course_title,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w500))
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

  static Widget videoThumnail(String url) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    return Image.network(YoutubePlayer.getThumbnail(videoId: videoId!));
  }
}