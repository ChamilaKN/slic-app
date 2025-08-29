import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

String? baseUrl = "https://sliclifecongress.ogilvydigital.net/api/v1";
Future<bool?> userLoginAPI(String userName, String userPassword) async {
  GetStorage box = GetStorage();
  try {
    var requestBody = json.encode({
      "email": userName,
      "password": userPassword,
    });
    var response = await http.post(Uri.parse(baseUrl! + "/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        },
        body: requestBody);
    print(requestBody);
    print(response.body.toString());

    //currentUserModel = new userModel(decodedResponse["data"][0]["userEmail"], decodedResponse["data"][0]["userPassword"], decodedResponse["data"][0]["userName"], decodedResponse["data"][0]["fcmId"], decodedResponse["data"][0]["profileImageUrl"], decodedResponse["data"][0]["uid"]);
    var decodedResponse = jsonDecode(response.body);
    print("response code " + decodedResponse[0]["id"].toString());
    if (decodedResponse[0]["response_code"] == 200) {
      box.write("userId", decodedResponse[0]["id"]);
      box.write("name", decodedResponse[0]["name"]);
      box.write("token", decodedResponse[0]["token"]);
      box.write("isLoggedIn", true);
      return true;
    } else {
      return false;
    }
    return true;
  } catch (ex) {
    print(ex.toString());
  }
  return null;
}

Future<List> getEventList() async {
  GetStorage box = GetStorage();
  // print("response.bod11y");
  
  // print(userId);
  // String? token = box.read("token");

  var requestBody = json.encode({
    "vendorId": box.read("userId"),
    "token": box.read("token"),
  });
   print("Request body: $requestBody");
  final response = await http.post(Uri.parse(baseUrl! + "/event-list"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
      },
      body: requestBody);
  // print(response.body);

  List<dynamic> data = json.decode(response.body);
  // print(data[0]);
  return data;
}

Future<List> qrScanData(int memberId, int eventId) async {
  GetStorage box = GetStorage();

  var requestBody = json.encode({
    "vendorId": box.read("userId"),
    "token": box.read("token"),
    "memberId": memberId,
    "eventId": eventId,
  });
  final response = await http.post(Uri.parse(baseUrl! + "/qrscan"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
      },
      body: requestBody);
  // print(response.body);

  // List<dynamic> data = json.decode(response.body);
  // print(data[0]);
  return json.decode(response.body);
}

Future markAttendence(
    int memberId, int eventId, int status, String rejectReason) async {
  GetStorage box = GetStorage();
  try {
    var requestBody = json.encode({
      "memberId": memberId,
      "token": box.read("token"),
      "eventId": eventId,
      "vendorId": box.read("userId"),
      "status": status,
      "reject_reason": rejectReason
    });
    var response = await http.post(Uri.parse(baseUrl! + "/mark-attendance"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        },
        body: requestBody);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse[0]["response_code"] == 400) {}
  } catch (ex) {
    print(ex.toString());
  }
}
