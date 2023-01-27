import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../widgets.dart';

class PostCommentBottomSheet extends StatelessWidget {
  const PostCommentBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        BottomSheetContainer(
          color: ColorPalettes.backgroundLight,
          header: BottomSheetTitleHeader(
            titleText: "Komentar",
          ),
          content: Container(
            color: ColorPalettes.backgroundLight,
            width: double.maxFinite,
            child: _PostCommentForm(),
          ),
        ),
      ],
    );
  }
}

class _PostCommentForm extends StatefulWidget {
  const _PostCommentForm({Key? key}) : super(key: key);

  @override
  State<_PostCommentForm> createState() => _PostCommentFormState();
}

class _PostCommentFormState extends State<_PostCommentForm> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 40.0,
        right: 40.0,
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TextField(
            controller: commentController,
            maxLines: null,
            maxLength: 200,
            decoration: InputDecoration(
              hintText: 'Masukkan komentar',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalettes.line,
                  width: 2.0,
                ),
              ),
              focusColor: ColorPalettes.primary,
              filled: true,
              fillColor: ColorPalettes.backgroundLight,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          CarbonRoundedButton(
            label: "Kirim",
            action: () => print("Send comment request"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
