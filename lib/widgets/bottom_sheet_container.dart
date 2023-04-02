import 'package:flutter/material.dart';

import '../commons/commons.dart';

const defaultBottomSheetShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(10.0),
  ),
);

class BottomSheetContainer extends StatelessWidget {
  final Widget content;
  final Widget? header;
  final Widget? bottom;
  final Color color;
  final bool asScrollingContent;

  const BottomSheetContainer({
    required this.content,
    this.header,
    this.bottom,
    this.color = Colors.white,
    this.asScrollingContent = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: screenHeight(context),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      child: SafeArea(
        bottom: false,
        minimum: const EdgeInsets.only(
          top: 8.0,
          bottom: 35.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //Bottom sheet dragging bar
            Container(
              width: 104.0,
              height: 5.0,
              margin: const EdgeInsets.only(
                top: 12.0,
              ),
              decoration: BoxDecoration(
                color: ColorPalettes.line,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            if (header != null) header!,
            if (asScrollingContent)
              Flexible(
                child: SingleChildScrollView(
                  child: content,
                ),
              )
            else
              Expanded(child: content),
            if (bottom != null) bottom!
          ],
        ),
      ),
    );
  }
}
