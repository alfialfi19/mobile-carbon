import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class PointStandingItem extends StatelessWidget {
  final String? imageUrl;
  final String? standingNumber;
  final String? standingName;
  final String? point;

  const PointStandingItem({
    Key? key,
    this.imageUrl,
    this.standingNumber,
    this.standingName,
    this.point,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 26.0,
          child: Text(
            standingNumber ?? "-",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        Row(
          children: [
            Container(
              height: 24.0,
              width: 24.0,
              margin: const EdgeInsets.only(
                right: 8.0,
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  imageUrl ?? Images.dummyProfile,
                ),
              ),
            ),
            Text(
              standingName ?? "-",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            width: double.maxFinite,
            alignment: Alignment.centerRight,
            child: Text(
              "${point ?? '0'} poin",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
