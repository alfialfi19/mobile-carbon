import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class BadgeLevelItemGradient extends StatelessWidget {
  final String badgeLabel;

  const BadgeLevelItemGradient({
    required this.badgeLabel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 138.0,
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
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            ColorPalettes.badgeGradient2,
            ColorPalettes.badgeGradient1,
          ],
        ),
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
            CarbonIcons.badge,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            badgeLabel,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorPalettes.white,
                  fontWeight: FontWeight.w400,
                ),
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
