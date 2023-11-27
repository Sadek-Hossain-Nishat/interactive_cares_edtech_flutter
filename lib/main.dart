import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_cares_app/domainlayer/color_util.dart';

import 'package:interactive_cares_app/firebase_options.dart';
import 'package:interactive_cares_app/splash_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColor.primarycolor,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: Size(width, height),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashcontroller = Get.put(SplashScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyan.shade50,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250.h,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 70.r,
                    child: Image.asset('images/splashlogo.png'),
                  ),
                  SizedBox(
                    height: 200.h,
                  ),
                  Text('Interactive Cares',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600))
                ]),
          ),
        ),
      ),
    );
  }
}
