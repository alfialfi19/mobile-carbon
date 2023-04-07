import 'package:flutter/material.dart';

import '../../commons/commons.dart';

typedef OnChangedCategory = void Function(String);

class CategoryInput extends StatefulWidget {
  final String? item;
  final List<String> categoryItem;
  final OnChangedCategory callback;
  final String? label;
  final double? width;
  final DropdownSource source;

  const CategoryInput({
    Key? key,
    this.item,
    required this.categoryItem,
    required this.callback,
    this.label = "Kategori",
    this.width,
    this.source = DropdownSource.addArticle,
  }) : super(key: key);

  @override
  State<CategoryInput> createState() => _CategoryInputState();
}

class _CategoryInputState extends State<CategoryInput> {
  String? _selectedItem;
  List<String> _categoryItem = [];

  @override
  void initState() {
    if (widget.item != null) {
      _selectedItem = widget.item;

      _onValueChanged(_selectedItem);
    }
    _categoryItem = widget.categoryItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label ?? "-",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
          Container(
            height: 55.0,
            width: widget.width,
            decoration: BoxDecoration(
              color: widget.source == DropdownSource.calculateCarbon
                  ? ColorPalettes.grayTextField
                  : ColorPalettes.white,
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            child: DropdownButtonFormField<String>(
              // value: _balances.length == 1 ? _balances.single : null,
              // onChanged: _onValueChanged,
              // items: _constructMenuItems(),
              value: _selectedItem,
              onChanged: _onValueChanged,
              items: _constructMenuItems(),
              decoration: InputDecoration(
                hintText: widget.label,
                isDense: true,
                fillColor: ColorPalettes.line,
                focusColor: ColorPalettes.line,
                // helperText: _selectedBalanceCategory != null
                //     ? LocaleKeys.request_reimbursement_category_balance_helper
                //     .tr(args: [
                //   _selectedBalanceCategory!.name,
                //   formatCurrency(_selectedBalanceCategory!.balance),
                // ])
                //     : null,
                helperStyle: Theme.of(context)
                    .textTheme
                    .overline!
                    .copyWith(color: ColorPalettes.slate),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorPalettes.line,
                  ),
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorPalettes.line,
                  ),
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
                // errorText: errorText,
              ),
              icon: Padding(
                padding: EdgeInsets.only(
                  right:
                      widget.source == DropdownSource.addArticle ? 20.0 : 0.0,
                ),
                child: Icon(
                  widget.source == DropdownSource.addArticle
                      ? Icons.arrow_drop_down
                      : Icons.keyboard_arrow_down_rounded,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onValueChanged(String? value) {
    print("===> masuk onValueChanged");
    print("===> onValueChanged from : $value");
    if (value != null) {
      setState(() {
        _selectedItem = value;
      });

      widget.callback.call(value);
    }
  }

  List<DropdownMenuItem<String>> _constructMenuItems() {
    return _categoryItem
        .map<DropdownMenuItem<String>>(
          (val) => DropdownMenuItem(
            value: val,
            child: Text(
              val,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        )
        .toList();
  }
}
