import 'package:flutter/material.dart';

import '../commons/resources/icons.dart';
import '../commons/styles/color_palettes.dart';
import 'top_toast.dart';

class ErrorToast extends TopToast {
  ErrorToast(String error)
      : super(
          message: error,
          borderColor: ColorPalettes.red,
          icon: Image.asset(
            CarbonIcons.reset,
            height: 24,
            width: 24,
            color: ColorPalettes.red,
          ),
        );
}
