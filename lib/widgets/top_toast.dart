import 'package:flutter/material.dart';

import '../commons/styles/color_palettes.dart';

class TopToast extends StatelessWidget {
  final String message;
  final Widget icon;
  final Color borderColor;

  const TopToast({
    required this.message,
    this.icon = const SizedBox(),
    this.borderColor = ColorPalettes.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: ColorPalettes.slate.withOpacity(0.2),
            offset: const Offset(0.0, 12.0),
            blurRadius: 20.0,
          ),
          BoxShadow(
            color: ColorPalettes.slate.withOpacity(0.1),
            offset: const Offset(0.0, 4.0),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          const SizedBox(width: 12.0),
          Flexible(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
