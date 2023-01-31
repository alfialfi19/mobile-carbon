import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/widgets.dart';

// ignore: avoid_classes_with_only_static_members
class ToastUtil {
  static void error(BuildContext context, String message) {
    FToast()
      ..init(context)
      ..showToast(
        child: ErrorToast(message),
        gravity: ToastGravity.TOP,
      );
  }

  static void info(BuildContext context, String message) {
    FToast()
      ..init(context)
      ..showToast(
        child: InfoToast(message),
        gravity: ToastGravity.TOP,
      );
  }
}
