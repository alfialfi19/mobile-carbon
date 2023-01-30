import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commons/commons.dart';

typedef OnChangedDescription = void Function(String);

class TextFieldInput extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final int? maxLength;
  final String? errorMessage;

  final TextInputAction? inputAction;
  final TextEditingController controller;
  final OnChangedDescription callback;
  final bool isAutoFocus;

  const TextFieldInput({
    required this.controller,
    required this.callback,
    this.inputAction,
    this.labelText,
    this.hintText,
    this.maxLength = 200,
    this.errorMessage,
    this.isAutoFocus = false,
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
      padding: const EdgeInsets.fromLTRB(
        15.0,
        6.0,
        0.0,
        6.0,
      ),
      child: TextFormField(
        autofocus: widget.isAutoFocus,
        controller: widget.controller,
        focusNode: _textFieldFocusNode,
        keyboardType: TextInputType.multiline,
        maxLength: widget.maxLength,
        minLines: 1,
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
          hintText: widget.hintText ?? "",
          hintStyle: const TextStyle(height: 1.2),
          labelText: widget.labelText ?? "",
          labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
          // helperText: widget.required ? null : LocaleKeys.optional.tr(),
          // helperStyle: Theme.of(context).textTheme.overline?.copyWith(
          //       color: ColorPalettes.gray600,
          //     ),
          // errorText: widget.errorMessage,
          counterStyle: Theme.of(context).textTheme.overline?.copyWith(
                color: ColorPalettes.placeholderZill,
              ),
          contentPadding: const EdgeInsets.only(
            right: 16.0,
            top: 10.0,
            bottom: 12.0,
            left: 16.0,
          ),
        ),
        onChanged: (value) => _onValuesChanged(context, value),
        textInputAction: widget.inputAction ?? TextInputAction.done,
      ),
    );
  }

  void _onValuesChanged(BuildContext context, String value) {
    widget.callback.call(value);
  }
}
