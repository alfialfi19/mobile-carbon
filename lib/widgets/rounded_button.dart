import 'package:flutter/material.dart';

import '../commons/commons.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback action;
  final Widget? prefix;
  final double? margin;
  final Color? backgroundColor;
  final Color? labelColor;
  final Color? borderColor;

  const RoundedButton({
    Key? key,
    required this.label,
    required this.action,
    this.prefix,
    this.margin,
    this.backgroundColor,
    this.labelColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => action.call(),
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: margin ?? 40.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorPalettes.primary,
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color: borderColor ?? ColorPalettes.primary,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefix ?? const SizedBox.shrink(),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: labelColor ?? ColorPalettes.white,
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
