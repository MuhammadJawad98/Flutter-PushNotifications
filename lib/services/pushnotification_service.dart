import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart';

class PushNotificationService {
  static var postUrl = "https://fcm.googleapis.com/fcm/send";

  static Future<void> sendNotification({receiver, msg}) async {
    // var token = await getToken(receiver);
    var token = await FirebaseMessaging.instance.getToken();
    log('token : $token');

    final data = {
      "notification": {
        "body": "Accept Ride Request",
        "title": "This is Ride Request"
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": "$token"
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAA_jmWZ4E:APA91bGUt7JBeDxpNmKwBJqAo6zOawaJifHOSAbDIOpMBeeb7RqfBXBIMOJIPTTOacx66jqfq8HAkXlDAixC7p41tS-LjPy89U-iiTk41xEzIK3sugTAY-IAhU7g9K2Xlva00NrbzMVk'
    };

    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );

    try {
      final response = await Dio(options).post(postUrl, data: data);

      if (response.statusCode == 200) {
        // Fluttertoast.showToast(msg: 'Request Sent To Driver');
        log('notification sending successfully');
      } else {
        log('notification sending failed');
        // on failure do sth
      }
    } catch (e) {
      log('exception $e');
    }
  }
}
