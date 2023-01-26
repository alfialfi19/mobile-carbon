import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../widgets.dart';

class CommentActionBottomSheet extends StatelessWidget {
  const CommentActionBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        BottomSheetContainer(
          color: ColorPalettes.cloud,
          header: BottomSheetTitleHeader(
            titleText: "",
          ),
          content: Container(
            color: ColorPalettes.backgroundLight,
            width: double.maxFinite,
            child: _CommentActionForm(),
          ),
        ),
      ],
    );
  }
}

class _CommentActionForm extends StatelessWidget {
  const _CommentActionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(1),
            child: Text(
              'Beri Komentar',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: ColorPalettes.black,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            height: 1.5,
            width: double.maxFinite,
            color: ColorPalettes.line,
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(2),
            child: Text(
              'Ubah',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: ColorPalettes.black,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            height: 1.5,
            width: double.maxFinite,
            color: ColorPalettes.line,
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(3),
            child: Text(
              'Hapus Komentar',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: ColorPalettes.red,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
