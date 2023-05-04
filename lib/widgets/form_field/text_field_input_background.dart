import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commons/commons.dart';

typedef OnChangedText = void Function(String);

class TextFieldInputBackground extends StatefulWidget {
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final String? secondaryHintText;
  final int? maxLength;
  final int minLines;
  final String? errorMessage;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;

  final TextInputAction? inputAction;
  final TextEditingController controller;
  final TextEditingController? secondaryController;
  final OnChangedText callback;
  final OnChangedText? secondaryCallback;
  final bool isAutoFocus;

  final double? width;
  final String? suffixLabel;
  final String? secondarySuffixLabel;
  final TextInputType keyboardType;

  const TextFieldInputBackground({
    required this.controller,
    required this.callback,
    this.secondaryController,
    this.secondaryCallback,
    this.labelStyle,
    this.inputAction,
    this.labelText,
    this.hintText,
    this.secondaryHintText,
    this.maxLength = 200,
    this.minLines = 1,
    this.errorMessage,
    this.isAutoFocus = false,
    this.padding,
    this.contentPadding,
    this.width,
    this.suffixLabel,
    this.secondarySuffixLabel,
    this.keyboardType = TextInputType.multiline,
    Key? key,
  }) : super(key: key);

  @override
  State<TextFieldInputBackground> createState() =>
      _TextFieldInputBackgroundState();
}

class _TextFieldInputBackgroundState extends State<TextFieldInputBackground>
    with WidgetsBindingObserver {
  final _textFieldFocusNode = FocusNode();
  final _secondaryTextFieldFn = FocusNode();

  @override
  void initState() {
    if (widget.controller.text.isNotBlank) {
      _onValuesChanged(context, widget.controller.text);
    }

    if (widget.secondaryController != null &&
        widget.secondaryController!.text.isNotBlank) {
      _onSecondaryValuesChanged(context, widget.secondaryController!.text);
    }

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.fromLTRB(
            0.0,
            6.0,
            0.0,
            6.0,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null) ...[
            Text(
              widget.labelText ?? "-",
              style: widget.labelStyle ??
                  Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorPalettes.dark,
                        fontWeight: FontWeight.w600,
                      ),
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
          Container(
            decoration: BoxDecoration(
              color: ColorPalettes.grayTextField2,
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: widget.width,
            child: TextFormField(
              autofocus: widget.isAutoFocus,
              controller: widget.controller,
              focusNode: _textFieldFocusNode,
              keyboardType: widget.keyboardType,
              maxLength: widget.maxLength,
              minLines: widget.minLines,
              maxLines: null,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: ColorPalettes.dark,
                  ),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorPalettes.grayTextField,
                  ),
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
                hintText: widget.hintText,
                hintStyle: const TextStyle(height: 1.2),
                // helperText: widget.required ? null : LocaleKeys.optional.tr(),
                // helperStyle: Theme.of(context).textTheme.overline?.copyWith(
                //       color: ColorPalettes.gray600,
                //     ),
                // errorText: widget.errorMessage,
                counterStyle: Theme.of(context).textTheme.overline?.copyWith(
                      color: ColorPalettes.placeholderZill,
                    ),
                contentPadding: widget.contentPadding ??
                    const EdgeInsets.only(
                      right: 16.0,
                      top: 10.0,
                      bottom: 12.0,
                      left: 16.0,
                    ),
                suffixIcon: Container(
                  width: 100.0,
                  padding: const EdgeInsets.only(
                    right: 16.0,
                  ),
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.suffixLabel ?? "",
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: ColorPalettes.blackZill,
                        ),
                  ),
                ),
              ),
              onChanged: (value) => _onValuesChanged(context, value),
              textInputAction: widget.inputAction ?? TextInputAction.done,
            ),
          ),
          if (widget.secondaryController != null)
            Container(
              margin: const EdgeInsets.only(
                top: 6.0,
              ),
              decoration: BoxDecoration(
                color: ColorPalettes.grayTextField2,
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: widget.width,
              child: TextFormField(
                autofocus: widget.isAutoFocus,
                controller: widget.secondaryController,
                focusNode: _secondaryTextFieldFn,
                keyboardType: widget.keyboardType,
                maxLength: widget.maxLength,
                minLines: widget.minLines,
                maxLines: null,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: ColorPalettes.dark,
                    ),
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ColorPalettes.grayTextField,
                    ),
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                  hintText: widget.secondaryHintText,
                  hintStyle: const TextStyle(height: 1.2),
                  // helperText: widget.required ? null : LocaleKeys.optional.tr(),
                  // helperStyle: Theme.of(context).textTheme.overline?.copyWith(
                  //       color: ColorPalettes.gray600,
                  //     ),
                  // errorText: widget.errorMessage,
                  counterStyle: Theme.of(context).textTheme.overline?.copyWith(
                        color: ColorPalettes.placeholderZill,
                      ),
                  contentPadding: widget.contentPadding ??
                      const EdgeInsets.only(
                        right: 16.0,
                        top: 10.0,
                        bottom: 12.0,
                        left: 16.0,
                      ),
                  suffixIcon: Container(
                    width: 100.0,
                    padding: const EdgeInsets.only(
                      right: 16.0,
                    ),
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.secondarySuffixLabel ?? "",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorPalettes.blackZill,
                          ),
                    ),
                  ),
                ),
                onChanged: (value) => _onSecondaryValuesChanged(context, value),
                textInputAction: widget.inputAction ?? TextInputAction.done,
              ),
            ),
        ],
      ),
    );
  }

  void _onValuesChanged(BuildContext context, String value) {
    widget.callback.call(value);
  }

  void _onSecondaryValuesChanged(BuildContext context, String value) {
    widget.secondaryCallback?.call(value);
  }
}
