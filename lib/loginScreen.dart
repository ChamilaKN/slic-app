import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:slic_app/dashboardEvents.dart';
import 'package:slic_app/popUs.dart';

import 'endPoints.dart';

TextEditingController userNameController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 100.w,
          height: 100.h,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Center(
                  child: Container(
                    height: 20.h,
                    child: Image.asset("assets/slic.png"),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                //Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Username",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 14.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: TextField(
                    controller: userNameController,
                    // maxLines: 5,
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      focusColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0xFFf5f5f5),
                      hintText: "youremail@slic.lk ",
                      hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey, fontSize: 12.sp),
                      labelStyle: GoogleFonts.montserrat(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Password",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 14.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: TextField(
                    controller: passwordController,
                    // maxLines: 5,
                    obscureText: true,
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      focusColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0xFFf5f5f5),
                      hintText: "Password",
                      hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey, fontSize: 12.sp),
                      labelStyle: GoogleFonts.montserrat(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.sp),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (userNameController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Input Required'),
                              content: Text(
                                  'Please fill in both the username and password fields.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showAlertDialog(context, "Logging in . . .  ");
                        bool? isSuccess = await userLoginAPI(
                            userNameController.text, passwordController.text);
                        userNameController.clear();
                        passwordController.clear();
                        print(isSuccess);
                        if (isSuccess == true) {
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => dashboardEvents()),
                            (Route<dynamic> route) => false,
                          );
                          // Get.to(dashboardEvents());
                        } else {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Login Failed'),
                                content: Text('Invalid Credentials'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Close'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                      // showAlertDialog(context, "Logging in . . .  ");
                      // bool? isSuccess = await userLoginAPI(
                      //     userNameController.text, passwordController.text
                      //     // "ayona.neo@gmail.com",
                      //     // "123456"
                      //     );
                      // userNameController.clear();
                      // passwordController.clear();
                      // print(isSuccess);
                      // if (isSuccess == true) {
                      //   Navigator.pop(context);
                      //   Get.to(dashboardEvents());
                      //   // Navigator.push(context, MaterialPageRoute(builder: (context) => qrScanner(),));
                      // } else {
                      //   Navigator.pop(context);
                      //   errorDialog(context, "Username or Password Invalid");
                      //   showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return AlertDialog(
                      //         title: Text('Login Failed'),
                      //         content: Text('Invalid Credentials'),
                      //         actions: <Widget>[
                      //           TextButton(
                      //             child: Text('Close'),
                      //             onPressed: () {
                      //               Navigator.of(context).pop();
                      //             },
                      //           ),
                      //         ],
                      //       );
                      //     },
                      //   );
                      // }
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.sp),
                            bottomRight: Radius.circular(10.sp),
                            bottomLeft: Radius.circular(10.sp),
                            topRight: Radius.circular(10.sp)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffD2D0D0), //0xFF113F9A),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset:
                                    Offset(3, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          height: 6.h,
                          width: 70.w,
                          child: Center(
                              child: Text(
                            "Login",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          )),
                        )),
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
