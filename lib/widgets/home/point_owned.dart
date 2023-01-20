import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class PointOwned extends StatelessWidget {
  final String iconHeader;
  final String label;
  final String caption;
  final int pointValue;
  final LinearGradient? colorGradient;
  final VoidCallback? action;

  const PointOwned({
    Key? key,
    required this.iconHeader,
    required this.label,
    required this.caption,
    required this.pointValue,
    this.colorGradient,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => action?.call(),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          gradient: colorGradient ??
              const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  ColorPalettes.purpleGradient1,
                  ColorPalettes.purpleGradient2,
                ],
              ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: ColorPalettes.white.withOpacity(0.2),
              ),
              child: Image.asset(
                iconHeader,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorPalettes.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              caption,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.white,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            RichText(
              text: TextSpan(
                text: pointValue.toString(),
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 32.0,
                      color: ColorPalettes.white,
                      fontWeight: FontWeight.w700,
                    ),
                children: [
                  TextSpan(
                    text: " Poin",
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: ColorPalettes.white,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
