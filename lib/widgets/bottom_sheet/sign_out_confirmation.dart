import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../widgets.dart';

class SignOutConfirmation extends StatelessWidget {
  final String label;
  final String caption;
  final String? negativeLabel;
  final VoidCallback? negativeCallback;
  final String? positiveLabel;
  final VoidCallback? positiveCallback;

  const SignOutConfirmation({
    Key? key,
    required this.label,
    required this.caption,
    this.negativeLabel,
    this.negativeCallback,
    this.positiveLabel,
    this.positiveCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        BottomSheetContainer(
          color: ColorPalettes.backgroundLight,
          header: BottomSheetTitleHeader(
            titleText: "",
          ),
          content: Container(
            color: ColorPalettes.backgroundLight,
            width: double.maxFinite,
            child: _SignOutForm(
              label: label,
              caption: caption,
              negativeLabel: negativeLabel,
              negativeCallback: negativeCallback,
              positiveLabel: positiveLabel,
              positiveCallback: positiveCallback,
            ),
          ),
        ),
      ],
    );
  }
}

class _SignOutForm extends StatelessWidget {
  final String label;
  final String caption;
  final String? negativeLabel;
  final VoidCallback? negativeCallback;
  final String? positiveLabel;
  final VoidCallback? positiveCallback;

  const _SignOutForm({
    Key? key,
    required this.label,
    required this.caption,
    this.negativeLabel,
    this.negativeCallback,
    this.positiveLabel,
    this.positiveCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: 39.0,
            ),
            height: 212.0,
            width: 288.0,
            child: Image.asset(
              Images.humans,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 4.0,
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 46.0,
            ),
            child: Text(
              caption,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.grayZill,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CarbonRoundedButton(
                    label: negativeLabel ?? "Batal",
                    labelColor: ColorPalettes.dark,
                    backgroundColor: ColorPalettes.backgroundLight,
                    borderColor: ColorPalettes.line,
                    action: () => negativeCallback?.call(),
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                if (positiveLabel != null)
                  Expanded(
                    child: CarbonRoundedButton(
                      label: positiveLabel!,
                      backgroundColor: ColorPalettes.redConfirmation,
                      borderColor: ColorPalettes.redConfirmation,
                      action: () => positiveCallback?.call(),
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
