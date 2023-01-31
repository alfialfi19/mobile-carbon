import 'package:flutter/material.dart';

import '../commons/resources/icons.dart';
import '../commons/styles/color_palettes.dart';
import 'top_toast.dart';

class InfoToast extends TopToast {
  InfoToast(String message)
      : super(
          message: message,
          borderColor: ColorPalettes.warning,
          icon: Image.asset(
            CarbonIcons.reset,
            height: 24,
            width: 24,
            color: ColorPalettes.warning,
          ),
        );
}
