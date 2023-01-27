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
          color: ColorPalettes.backgroundLight,
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
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(1),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Beri Komentar',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: ColorPalettes.black,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(2),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ColorPalettes.line,
                    width: 1.5,
                  ),
                  top: BorderSide(
                    color: ColorPalettes.line,
                    width: 1.5,
                  ),
                ),
              ),
              child: Text(
                'Ubah',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: ColorPalettes.black,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(3),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Hapus Komentar',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: ColorPalettes.red,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
