import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_cares_app/domainlayer/color_util.dart';
import 'package:interactive_cares_app/uilayer/bottom_nav.dart';

import 'package:interactive_cares_app/uilayer/signin/signin_page.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool _obscuretext = true;
  bool _obscuretextconfirm = true;

  register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.toString(), password: password.text.toString());

      Get.to(SignInPage(),
          duration:
              Duration(seconds: 2), //duration of transitions, default 1 sec
          transition: Transition.rightToLeft);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
    confirmpassword.dispose();
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
                    child: Icon(Icons.close, color: Colors.white)),
              ),
            )
          ], backgroundColor: Colors.white, elevation: 0),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Text('Sign Up',
                            style: TextStyle(
                                fontSize: 32.sp, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Text('Already have an account?',
                            style: TextStyle(fontSize: 14.sp)),
                        InkWell(
                          onTap: () => Get.off(SignInPage()),
                          child: Text('Sign In',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.primarycolor)),
                        ),
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
                          SizedBox(height: 20.h),
                          TextFormField(
                            obscureText: _obscuretextconfirm,
                            obscuringCharacter: '*',
                            controller: confirmpassword,
                            validator: (value) {
                              return password.text == confirmpassword.text
                                  ? null
                                  : 'Passwords are not matched.';
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscuretextconfirm =
                                          !_obscuretextconfirm;
                                    });
                                  },
                                  icon: _obscuretextconfirm
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
                              hintText: 'Confirm password',
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
                                  if (formKey.currentState!.validate()) {
                                    print('okey');
                                    register();
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text("Passwords are must be matched"),
                                    ));
                                  }
                                },
                                child: Text('REGISTER NOW',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700))),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          )),
    );
  }
}
