import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interactive_cares_app/domainlayer/color_util.dart';
import 'package:interactive_cares_app/uilayer/bottom_nav.dart';

import 'package:interactive_cares_app/uilayer/signup/signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _obscuretext = true;
  bool userExist = false;

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

  login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.toString(), password: password.text.toString());

      Get.offAll(BottomNav()
          // duration:
          //     Duration(seconds: 2), //duration of transitions, default 1 sec
          // transition: Transition.leftToRight
          );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
    }
  }

  googlesigninexecution() {
    googleSignIn().then((value) {
      Get.offAll(
        BottomNav(),
        // duration:
        //     Duration(seconds: 2), //duration of transitions, default 1 sec
        // transition: Transition.leftToRight
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      print("$e");
    });
  }

  Future<UserCredential> googleSignIn() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(actions: [
            Padding(
              padding: EdgeInsets.all(15.w),
              child: InkWell(
                onTap: () {
                  Get.offAll(
                    BottomNav(),
                    // duration: Duration(
                    //     seconds: 2), //duration of transitions, default 1 sec
                    // transition: Transition.leftToRight
                  );
                },
                child: CircleAvatar(
                  backgroundColor: AppColor.primarycolor,
                  radius: 15.r,
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
            )
          ], backgroundColor: Colors.white, elevation: 0),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Login',
                            style: TextStyle(
                                fontSize: 32.sp, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Text('Hello there,', style: TextStyle(fontSize: 14.sp)),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: new InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                              hintText: 'Email',
                            ),
                          ),
                          SizedBox(height: 20.h),
                          TextFormField(
                            obscureText: _obscuretext,
                            obscuringCharacter: '*',
                            controller: password,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Password must be at least 7 characters long.';
                              }
                              return null;
                            },
                            decoration: new InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscuretext = !_obscuretext;
                                    });
                                  },
                                  icon: _obscuretext
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                              hintText: 'Password',
                            ),
                          ),
                          SizedBox(height: 50.h),
                          SizedBox(
                            height: 50.h,
                            width: 400.w,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColor.primarycolor)),
                                onPressed: () {
                                  login();
                                },
                                child: Text('LOGIN NOW',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700))),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Text('New here?',
                                  style: TextStyle(fontSize: 14.sp)),
                              InkWell(
                                onTap: () => Get.off(SignUpPage()),
                                child: Text('Sign Up',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.primarycolor)),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Text(
                              '- - - - - - - - - - - - - - - -OR- - - - - - - - - - - - - - - -'),
                          SizedBox(height: 40.h),
                          SizedBox(
                              height: 60.h,
                              width: 400.w,
                              child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () {
                                    googlesigninexecution();
                                  },
                                  icon: Image.asset('images/googlelogo.jpg',
                                      height: 100.h, width: 100.w),
                                  label: Text('Sign in with Google',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87))))
                        ],
                      ),
                    )
                  ]),
            ),
          )),
    );
  }
}
