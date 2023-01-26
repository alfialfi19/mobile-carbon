import 'package:flutter/material.dart';

import '../commons/commons.dart';

class BottomSheetField extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final String titleText;
  final String? trailingText;
  final Color backgroundColor;
  final int? titleMaxLines;
  final int? trailingMaxLines;

  const BottomSheetField({
    required this.titleText,
    required this.trailingText,
    this.padding = const EdgeInsets.symmetric(
      vertical: 12.0,
      horizontal: 16.0,
    ),
    this.backgroundColor = ColorPalettes.white,
    this.titleMaxLines,
    this.trailingMaxLines,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              titleText,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: ColorPalettes.slate),
              textAlign: TextAlign.start,
              maxLines: titleMaxLines,
            ),
          ),
          Expanded(
            child: Text(
              trailingText.isNotBlank ? trailingText! : '-',
              style: Theme.of(context).textTheme.bodyText1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              maxLines: trailingMaxLines,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetTitleHeader extends StatelessWidget {
  final String titleText;
  final String? closeDialogText;
  final Color closeDialogColor;
  final VoidCallback? closeDialogCallback;

  const BottomSheetTitleHeader({
    required this.titleText,
    this.closeDialogText,
    this.closeDialogColor = ColorPalettes.blue400,
    this.closeDialogCallback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalettes.cloud,
      child: ListTile(
        title: Text(
          titleText,
          style: Theme.of(context).textTheme.headline3,
        ),
        trailing: closeDialogText == null
            ? null
            : InkWell(
                onTap: () => closeDialogCallback != null
                    ? closeDialogCallback!.call()
                    : Navigator.pop(context),
                child: Text(
                  closeDialogText!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: closeDialogColor),
                ),
              ),
      ),
    );
  }
}

class BottomSheetSectionSeparator extends StatelessWidget {
  const BottomSheetSectionSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: ColorPalettes.cloud,
      thickness: 8.0,
    );
  }
}

class BottomSheetHeadlineText extends StatelessWidget {
  final String label;
  final String? value;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const BottomSheetHeadlineText({
    required this.label,
    this.value,
    this.backgroundColor = ColorPalettes.white,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 12.0,
    ),
    Key? key,
  }) : super(key: key);

  factory BottomSheetHeadlineText.withTotalLabel(String totalAmount) {
    return BottomSheetHeadlineText(
      value: totalAmount,
      label: "This is Total Headline",
    );
  }

  factory BottomSheetHeadlineText.withTotalPaymentLabel(String totalAmount) {
    return BottomSheetHeadlineText(
      value: totalAmount,
      label: "This is Detail Total Payment",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.start,
            ),
          ),
          if (value.isNotBlank)
            Expanded(
              child: Text(
                value!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: ColorPalettes.red400),
                textAlign: TextAlign.end,
              ),
            ),
        ],
      ),
    );
  }
}

class BottomSheetRadioOption<T> extends StatelessWidget {
  final String label;
  final T? value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final bool showDivider;

  const BottomSheetRadioOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.showDivider = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            label,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          trailing: Radio<T?>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          onTap: onChanged != null ? () => onChanged!(value) : null,
        ),
        if (showDivider)
          const Divider(
            indent: 16.0,
            color: ColorPalettes.smoke,
            height: 1.0,
          ),
      ],
    );
  }
}
