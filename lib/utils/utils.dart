import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum SnackBarStates { ERROR, SUCCESS, NORMAL }

class Utils {
  static showToast({
    required String message,
    int duration = 2,
    SnackBarStates state = SnackBarStates.NORMAL,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: state == SnackBarStates.NORMAL
          ? Colors.white
          : state == SnackBarStates.ERROR
              ? Colors.red
              : Colors.green,
      textColor: state == SnackBarStates.NORMAL ? Colors.black : Colors.white,
      fontSize: 16.0,
    );
  }

  static Future<bool> networkIsConnective() async {
    List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    return (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
  }
}
