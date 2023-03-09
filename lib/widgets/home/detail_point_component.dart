import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class DetailPointComponent extends StatelessWidget {
  final String iconHeaderAsset;
  final String? iconHeaderUrl;
  final String caption;
  final Color? captionColor;
  final String pointValue;
  final Color? pointColor;
  final Color? backgroundColor;
  final LinearGradient? colorGradient;
  final VoidCallback? onTap;

  const DetailPointComponent({
    Key? key,
    required this.caption,
    required this.pointValue,
    this.iconHeaderAsset = CarbonIcons.food2,
    this.iconHeaderUrl,
    this.captionColor,
    this.pointColor,
    this.backgroundColor,
    this.colorGradient,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
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
            iconHeaderUrl != null
                ? Image.network(
                    iconHeaderUrl!,
                  )
                : Image.asset(
                    iconHeaderAsset,
                  ),
            const SizedBox(
              height: 32.0,
            ),
            Expanded(
              child: Text(
                caption,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: captionColor ?? ColorPalettes.white,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: pointValue.toString(),
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: pointColor ?? ColorPalettes.white,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.visible,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
