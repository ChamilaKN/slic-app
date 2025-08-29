import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sizer/sizer.dart';
import 'package:slic_app/popUs.dart';

import 'endPoints.dart';

final GlobalKey qrKey1 = GlobalKey(debugLabel: 'QR');
QRViewController? controller;

class qrScanner extends StatefulWidget {
  final dynamicList;
  const qrScanner({super.key, required this.dynamicList});

  @override
  State<qrScanner> createState() => _qrScannerState();
}

class _qrScannerState extends State<qrScanner> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.pauseCamera();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController mainController) {
    controller = mainController;
    controller?.scannedDataStream.listen((scanData) async {
      print(int.parse(scanData.code.toString()));
      // setState(() async {
      controller?.pauseCamera();

      //   print(
      //     int.parse(scanData.code.toString()),
      //   );
      List<dynamic> data = await qrScanData(int.parse(scanData.code.toString()),
          widget.dynamicList[0]["event_id"]);

      data[0]["response_code"] == 200
          ? confirmParticipation(
              context,
              data[0]["data_list"]["nic"],
              int.parse(scanData.code.toString()),
              widget.dynamicList[0]["event_id"],
              data[0]["data_list"]["name"].toString(),
              data[0]["data_list"]["table_no"].toString(),
              data[0]["data_list"]["category"].toString(),
              data[0]["data_list"]["branch_name"].toString(),
              // "(" +
              // data[0]["data_list"]["branch_code"].toString() +
              // ")",
              data[0]["data_list"]["prize"].toString())
          : errorDialog(
              context,
              data[0]["response_text"],
            );
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.dynamicList[0]["event_id"].toString() + "-----");
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //  SizedBox(width: 28.sp,),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Text(
                    "Scan QR",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                ),
                Spacer(),

                SizedBox(
                  height: 50.sp,
                )
              ],
            ),
            SizedBox(
              height: 20.sp,
            ),
            // Spacer(),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.sp),
              child: Container(
                height: 110.w,
                width: 90.w,
                child: QRView(
                  key: qrKey1,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                      borderColor: Colors.red,
                      borderRadius: 10,
                      borderLength: 20.sp,
                      borderWidth: 5.sp,
                      cutOutSize: 75.sp),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  controller?.resumeCamera();
                });

                //delete api
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.sp)),
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 5.sp,
                      ),
                      Icon(
                        Icons.refresh,
                        size: 25.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
        // child:
        // QRView(
        //   key: qrKey,
        //   onQRViewCreated: _onQRViewCreated,
        // ),
      ),
    );
  }
}
