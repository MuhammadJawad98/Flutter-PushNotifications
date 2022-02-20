import 'package:flutter/material.dart';

class DataNotifier extends ChangeNotifier {
  var _deviceToken = "";

  String get getDeviceToken {
    return _deviceToken.toString();
  }

  void setDeviceToken(token) {
    _deviceToken = token;
    notifyListeners();
  }
}
