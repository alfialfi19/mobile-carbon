import 'package:flutter/material.dart';
import 'package:mobile_carbon/commons/commons.dart';

class CarbonRoundedButton extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsets? padding;
  final VoidCallback? action;

  const CarbonRoundedButton({
    Key? key,
    required this.label,
    this.labelColor = ColorPalettes.white,
    this.backgroundColor = ColorPalettes.primary,
    this.borderColor = ColorPalettes.primary,
    this.padding,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => action?.call(),
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: labelColor,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
