import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class DetailPointComponent extends StatelessWidget {
  final String iconHeader;
  final String caption;
  final Color? captionColor;
  final String pointValue;
  final Color? pointColor;
  final Color? backgroundColor;
  final LinearGradient? colorGradient;
  const DetailPointComponent({
    Key? key,
    required this.iconHeader,
    required this.caption,
    required this.pointValue,
    this.captionColor,
    this.pointColor,
    this.backgroundColor,
    this.colorGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(right: 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: backgroundColor,
        gradient: colorGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            iconHeader,
          ),
          const SizedBox(
            height: 32.0,
          ),
          Text(
            caption,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: captionColor ?? ColorPalettes.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
          RichText(
            text: TextSpan(
              text: pointValue.toString(),
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: pointColor ?? ColorPalettes.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
