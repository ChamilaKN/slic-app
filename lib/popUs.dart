import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:slic_app/dashboardEvents.dart';
import 'package:slic_app/endPoints.dart';

confirmParticipation(
    BuildContext context,
    String content,
    int memberId,
    int eventId,
    String userName,
    String userCategory,
    String userBranch,
    String userRegion,
    String userTshirt) {
  TextEditingController rejectionReasonController = new TextEditingController();
  AlertDialog alert = AlertDialog(
    content: Padding(
      padding: EdgeInsets.all(3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                content,
                style: GoogleFonts.montserrat(
                    fontSize: 20.sp, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 2.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  "Name : " + userName,
                  style: GoogleFonts.montserrat(
                      fontSize: 10.sp, fontWeight: FontWeight.normal),
                )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  "TShirt Size : " +
                      (userTshirt == "" || userTshirt.toLowerCase() == "null"
                          ? "N/A"
                          : userTshirt),
                  style: GoogleFonts.montserrat(
                      fontSize: 10.sp, fontWeight: FontWeight.normal),
                )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  "Category : " + userCategory,
                  style: GoogleFonts.montserrat(
                      fontSize: 10.sp, fontWeight: FontWeight.normal),
                )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  // "Prize : N/A",
                  "Region : " +
                      (userRegion == "" || userRegion.toLowerCase() == "null"
                          ? "N/A"
                          : userRegion),
                  style: GoogleFonts.montserrat(
                      fontSize: 10.sp, fontWeight: FontWeight.normal),
                )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  "Branch : " + userBranch,
                  style: GoogleFonts.montserrat(
                      fontSize: 10.sp, fontWeight: FontWeight.normal),
                )),
          ),
          SizedBox(
            height: 3.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Reject reason",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 8.sp),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          TextField(
            // enabled: enableTextFields,
            controller: rejectionReasonController,
            style: GoogleFonts.montserrat(color: Colors.black, fontSize: 9.sp),
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
              hintText: "Enter reason, If rejected",
              hintStyle: GoogleFonts.montserrat(color: Colors.grey),
              labelStyle: GoogleFonts.montserrat(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  markAttendence(
                      memberId, eventId, 1, rejectionReasonController.text);
                  Navigator.pop(context);
                  Get.off(dashboardEvents());
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.sp),
                        bottomRight: Radius.circular(10.sp),
                        bottomLeft: Radius.circular(10.sp),
                        topRight: Radius.circular(10.sp)),
                    child: Container(
                      color: Colors.black,
                      width: 30.w,
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.all(11.0.sp),
                        child: Text(
                          "Accepted",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                      )),
                    )),
              ),
              SizedBox(
                width: 1.h,
              ),
              GestureDetector(
                onTap: () {
                  markAttendence(
                      memberId, eventId, 0, rejectionReasonController.text);
                  Navigator.pop(context);
                  Get.off(dashboardEvents());
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.sp),
                        bottomRight: Radius.circular(10.sp),
                        bottomLeft: Radius.circular(10.sp),
                        topRight: Radius.circular(10.sp)),
                    child: Container(
                      color: Colors.black,
                      width: 30.w,
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.all(11.0.sp),
                        child: Text(
                          "Rejected",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                      )),
                    )),
              )
            ],
          )
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog(BuildContext context, String content) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircularProgressIndicator(
          color: Colors.black,
          strokeWidth: 1.sp,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                content,
                style: GoogleFonts.montserrat(),
              )),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

errorDialog(BuildContext context, String content) {
  AlertDialog alert = AlertDialog(
    content: Padding(
      padding: EdgeInsets.all(3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 15.sp, fontWeight: FontWeight.normal),
              )),
          SizedBox(
            height: 3.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Get.off(dashboardEvents());
            },
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.sp),
                    bottomRight: Radius.circular(10.sp),
                    bottomLeft: Radius.circular(10.sp),
                    topRight: Radius.circular(10.sp)),
                child: Container(
                  color: Colors.black,
                  width: 30.w,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(11.0.sp),
                    child: Text(
                      "Okay",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                  )),
                )),
          ),
          SizedBox(
            width: 1.h,
          )
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
