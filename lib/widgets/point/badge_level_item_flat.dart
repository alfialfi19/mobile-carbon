import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class BadgeLevelItemFlat extends StatelessWidget {
  final String badgeLabel;

  const BadgeLevelItemFlat({
    Key? key,
    required this.badgeLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128.0,
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      padding: const EdgeInsets.fromLTRB(
        30.0,
        0.0,
        30.0,
        30.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: ColorPalettes.white,
        boxShadow: const [
          BoxShadow(
            color: ColorPalettes.grayDivider,
            blurRadius: 8,
            offset: Offset(
              2,
              2,
            ),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            CarbonIcons.badgeElite,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            badgeLabel,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w400,
                ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
