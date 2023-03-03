import 'package:flutter/material.dart';

import '../commons/commons.dart';

class CarbonLoadingState extends StatelessWidget {
  final double marginTop;

  const CarbonLoadingState({
    this.marginTop = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: const Center(
        child: CircularProgressIndicator(
          color: ColorPalettes.primary,
        ),
      ),
    );
  }
}
