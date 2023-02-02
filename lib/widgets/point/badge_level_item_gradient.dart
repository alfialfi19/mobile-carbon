import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class BadgeLevelItemGradient extends StatelessWidget {
  const BadgeLevelItemGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Eco-newbie",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorPalettes.white,
                  fontWeight: FontWeight.w400,
                ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
