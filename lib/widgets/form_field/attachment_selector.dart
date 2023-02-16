import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class AttachmentSelector extends StatelessWidget {
  final String primaryPlaceholder;
  final String? secondaryPlaceholder;
  final bool isErrorState;

  const AttachmentSelector({
    required this.primaryPlaceholder,
    this.secondaryPlaceholder,
    this.isErrorState = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isErrorState ? ColorPalettes.red400 : ColorPalettes.line,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   ExmIcons.docs,
          //   height: 24.0,
          //   width: 24.0,
          // ),
          const Icon(
            Icons.add,
            size: 42.0,
            color: ColorPalettes.grayZill,
          ),
          // const SizedBox(height: 8.0),
          // Text(
          //   primaryPlaceholder,
          //   textAlign: TextAlign.center,
          //   style: Theme.of(context).textTheme.overline!.copyWith(
          //         color: isErrorState
          //             ? ColorPalettes.red400
          //             : ColorPalettes.blue400,
          //         fontSize: 14,
          //       ),
          // ),
          if (secondaryPlaceholder != null)
            Text(
              secondaryPlaceholder!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.overline!.copyWith(
                    color: ColorPalettes.slate,
                    fontSize: 8,
                  ),
            ),
        ],
      ),
    );
  }
}
