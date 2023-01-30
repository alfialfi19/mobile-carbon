import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../widgets.dart';

class DeleteArticleBottomSheet extends StatelessWidget {
  const DeleteArticleBottomSheet({Key? key}) : super(key: key);

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
            child: _DeleteArticleForm(),
          ),
        ),
      ],
    );
  }
}

class _DeleteArticleForm extends StatelessWidget {
  const _DeleteArticleForm({Key? key}) : super(key: key);

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
              "Hapus Artikel",
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
              "Apakah Anda ingin menghapus artikel? Artikel yang telah dihapus "
              "tidak dapat dikembalikan lagi.",
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
                    label: "Batal",
                    labelColor: ColorPalettes.dark,
                    backgroundColor: ColorPalettes.backgroundLight,
                    borderColor: ColorPalettes.line,
                    action: () => print("==> Cancel delete article"),
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Expanded(
                  child: CarbonRoundedButton(
                    label: "Hapus",
                    backgroundColor: ColorPalettes.redConfirmation,
                    borderColor: ColorPalettes.redConfirmation,
                    action: () => print("==> Approve delete article"),
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
