import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:slic_app/endPoints.dart';
import 'package:slic_app/loginScreen.dart';
import 'package:slic_app/qrScanner.dart';

class dashboardEvents extends StatefulWidget {
  const dashboardEvents({super.key});

  @override
  State<dashboardEvents> createState() => _dashboardEventsState();
}

class _dashboardEventsState extends State<dashboardEvents> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Color(0xffff5f5f5),
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Column(children: [
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Text(
                  "Event Name",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 18.sp),
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      logOut(context);
                    },
                    child: Icon(Icons.logout))
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            FutureBuilder(
                future: getEventList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // customerName = snapshot.data[0]["member_name"];
                  // print(snapshot.data);
                  //  print(snapshot.data[0]["response_code"].toString()+"xxxxxxxxxxxx");
                  return (snapshot.data != null)
                      ? Container(
                          height: 80.h,
                          child: RefreshIndicator(
                            onRefresh: () {
                              return Future.delayed(
                                Duration(seconds: 1),
                                () {
                                  setState(() {});
                                },
                              );
                            },
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: snapshot.data != null &&
                                        snapshot.data[0]["promo_list"] != null
                                    ? snapshot.data[0]["promo_list"].length
                                    : 0,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return snapshot.data[0]["response_code"] !=
                                          405
                                      ? GestureDetector(
                                          onTap: () {
                                            Get.to(qrScanner(
                                              dynamicList: [
                                                snapshot.data[0]["promo_list"]
                                                    [index]
                                              ],
                                            ));
                                          },
                                          child: Container(
                                            width: 100.w,
                                            height: 80.h,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 0.5,
                                                  blurRadius: 10,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      height: 40.h,
                                                      width: 40.h,
                                                      child: CachedNetworkImage(
                                                        imageUrl: snapshot
                                                                        .data[0]
                                                                    [
                                                                    "promo_list"]
                                                                [index]
                                                            ["event_image"],
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) => //   Container(
                                                                Container(
                                                          height: 60.0,
                                                          child: new Center(
                                                              child:
                                                                  new CircularProgressIndicator(
                                                            color: Colors.black,
                                                            strokeWidth: 1.sp,
                                                          )),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            //   Container(
                                                            // height: 60.0,
                                                            //   child: new Center(
                                                            //       child: new CircularProgressIndicator(
                                                            //     color: Colors.black,
                                                            //     strokeWidth: 1.sp,
                                                            //   )),
                                                            // ),
                                                            Icon(Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 4.h,
                                                  ),
                                                  Text(
                                                    "Event Name",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  SizedBox(
                                                    height: 1.sp,
                                                  ),
                                                  Text(
                                                    snapshot.data[0]
                                                            ["promo_list"]
                                                        [index]["event_name"],
                                                    style: GoogleFonts
                                                        .montserrat(),
                                                  ),
                                                  SizedBox(
                                                    height: 1.5.h,
                                                  ),
                                                  Text(
                                                    "Event Description  ",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  SizedBox(
                                                    height: 1.sp,
                                                  ),
                                                  snapshot.data[0]["promo_list"]
                                                                  [index]
                                                              ["description"] ==
                                                          null
                                                      ? Text("-")
                                                      : Text(
                                                          snapshot.data[0][
                                                                      "promo_list"]
                                                                  [index]
                                                              ["description"],
                                                          style: GoogleFonts
                                                              .montserrat(),
                                                        ),
                                                  // Text(
                                                  //   snapshot.data[0]
                                                  //           ["promo_list"]
                                                  //       [index]["description"],
                                                  //   style: GoogleFonts
                                                  //       .montserrat(),
                                                  // ),
                                                  SizedBox(
                                                    height: 1.5.h,
                                                  ),
                                                  Text(
                                                    "Event Date",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  SizedBox(
                                                    height: 1.sp,
                                                  ),
                                                  Text(
                                                    snapshot.data[0]
                                                            ["promo_list"]
                                                        [index]["event_date"],
                                                    style: GoogleFonts
                                                        .montserrat(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.all(10.sp),
                                          child: Center(
                                            child: Text(
                                                snapshot.data[0]
                                                    ["response_text"],
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.sp)),
                                          ),
                                        );
                                }),
                          ),
                        )
                      : Container(
                          height: 77.h,
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50.sp,
                                      height: 50.sp,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                        strokeWidth: 1.sp,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.sp),
                                      child: Text("Await for Events",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp)),
                                    )
                                  ],
                                )),
                          ));
                }),
          
          ]),
        ),
      ),
    );
  }
}

void logOut(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Logout'),
            onPressed: () {
              GetStorage box = GetStorage();
              box.erase();
              box.write("isLoggedIn", false);
              Get.off(loginScreen());
            },
          ),
        ],
      );
    },
  );
}
