import 'package:flutter/material.dart' show Color;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gs_test/utils/theme_manager.dart';

class ToastMessage {
  static Future<void> show({
    required String msg,
    Color? backgroundColor,
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) async {
    {
      Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor ?? ThemeManager.whiteColor,
        textColor: ThemeManager.blackColor,
        fontSize: 14,
      );
    }
  }
}
