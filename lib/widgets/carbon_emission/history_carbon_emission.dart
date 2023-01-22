import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class HistoryCarbonEmission extends StatelessWidget {
  final String? label;
  final String? caption;
  final String? pointValue;
  final Widget? leadingIcon;
  final Color? leadingBackgroundColor;

  const HistoryCarbonEmission({
    Key? key,
    this.label,
    this.caption,
    this.pointValue,
    this.leadingIcon,
    this.leadingBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: leadingBackgroundColor ?? Colors.orange.withOpacity(0.1),
            ),
            child: leadingIcon ??
                Image.asset(
                  CarbonIcons.food,
                  height: 24.0,
                  width: 24.0,
                ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label ?? "-",
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorPalettes.dark,
                        fontWeight: FontWeight.w700,
                      ),
                  overflow: TextOverflow.visible,
                ),
                if (caption != null)
                  Text(
                    caption ?? "-",
                    style: Theme.of(context).textTheme.overline?.copyWith(
                          color: ColorPalettes.placeholderZill,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              alignment: Alignment.centerRight,
              child: Text(
                pointValue ?? "- poin",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorPalettes.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
