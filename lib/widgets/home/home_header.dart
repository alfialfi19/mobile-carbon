import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class HomeHeader extends StatelessWidget {
  final String imgAsset;
  final String label;
  final String caption;

  const HomeHeader({
    required this.imgAsset,
    required this.label,
    required this.caption,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430.0,
      width: 330.0,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        image: DecorationImage(
          image: AssetImage(
            imgAsset,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          30.0,
          0.0,
          30.0,
          40.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 18.0,
                    color: ColorPalettes.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              caption,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.white,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
