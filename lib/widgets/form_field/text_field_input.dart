import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commons/commons.dart';

typedef OnChangedDescription = void Function(String);

class TextFieldInput extends StatefulWidget {
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final int? maxLength;
  final int minLines;
  final String? errorMessage;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;

  final TextInputAction? inputAction;
  final TextEditingController controller;
  final OnChangedDescription callback;
  final bool isAutoFocus;

  final double? width;
  final Widget? prefix;
  final TextInputType keyboardType;

  final DropdownSource source;

  const TextFieldInput({
    required this.controller,
    required this.callback,
    this.labelStyle,
    this.inputAction,
    this.labelText,
    this.hintText,
    this.maxLength = 200,
    this.minLines = 1,
    this.errorMessage,
    this.isAutoFocus = false,
    this.padding,
    this.contentPadding,
    this.width,
    this.prefix,
    this.keyboardType = TextInputType.multiline,
    this.source = DropdownSource.addArticle,
    Key? key,
  }) : super(key: key);

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput>
    with WidgetsBindingObserver {
  final _textFieldFocusNode = FocusNode();

  @override
  void initState() {
    if (widget.controller.text.isNotBlank) {
      _onValuesChanged(context, widget.controller.text);
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
            15.0,
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
                        fontWeight: FontWeight.w700,
                      ),
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
          Container(
            color: widget.source == DropdownSource.addArticle
                ? ColorPalettes.white
                : ColorPalettes.grayTextField,
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
                    color: ColorPalettes.line,
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
                prefixIcon: widget.prefix,
              ),
              onChanged: (value) => _onValuesChanged(context, value),
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
}
