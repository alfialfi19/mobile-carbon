import 'package:flutter/material.dart';
import 'package:mobile_carbon/commons/commons.dart';

class OnBoardingIndicator extends StatelessWidget {
  final bool isActive;

  const OnBoardingIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.0,
      width: isActive ? 44.0 : 8.0,
      margin: const EdgeInsets.only(right: 6.0),
      decoration: BoxDecoration(
        color: isActive ? ColorPalettes.secondary : ColorPalettes.gray,
        borderRadius: BorderRadius.circular(100.0),
      ),
    );
  }
}
