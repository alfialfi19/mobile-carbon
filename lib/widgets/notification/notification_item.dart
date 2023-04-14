import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class NotificationItem extends StatelessWidget {
  final String? imageUrl;
  final String? notificationLabel;
  final String? notificationCaption;
  final String? timeStamp;
  final VoidCallback? onTap;

  const NotificationItem({
    Key? key,
    this.imageUrl,
    this.notificationLabel,
    this.notificationCaption,
    this.timeStamp,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: Image.asset(
              imageUrl ?? CarbonIcons.success,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationLabel ?? "-",
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorPalettes.dark,
                        fontWeight: FontWeight.w700,
                      ),
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.justify,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 2.0,
                    bottom: 4.0,
                  ),
                  child: Text(
                    notificationCaption ?? "-",
                    style: Theme.of(context).textTheme.overline?.copyWith(
                          color: ColorPalettes.grayZill,
                          fontWeight: FontWeight.w400,
                        ),
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Text(
                  timeStamp ?? "-",
                  style: Theme.of(context).textTheme.overline?.copyWith(
                        color: ColorPalettes.placeholderZill,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
