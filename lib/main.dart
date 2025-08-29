import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:slic_app/loginScreen.dart';

import 'dashboardEvents.dart';

GetStorage box = GetStorage();
void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const GetMaterialApp(home: splashScreen());
    });
  }
}

class splashScreen extends StatelessWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loadUserData(context);

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Spacer(),
          Padding(
            padding: EdgeInsets.all(40.sp),
            child: Image.asset("assets/slic.png"),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50.sp,
                  height: 50.sp,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 1.sp,
                  ),
                )),
          ),
          Spacer()
        ],
      ),
    );
  }
}

Future<void> loadUserData(BuildContext context) async {
  GetStorage box = GetStorage();
  if (box.read("token") != null) {
    print(box.read("token").toString());
    // Using Get.offAll() to ensure there are no routes behind the dashboard
    Timer(Duration(seconds: 3), () => Get.offAll(() => dashboardEvents()));
  } else {
    // Using Get.offAll() to ensure there are no routes behind the login screen
    Timer(Duration(seconds: 3), () => Get.offAll(() => loginScreen()));
  }
}
