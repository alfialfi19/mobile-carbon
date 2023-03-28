import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../widgets.dart';

class PostCommentBottomSheet extends StatelessWidget {
  final String? currentComment;

  const PostCommentBottomSheet({
    this.currentComment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        BottomSheetContainer(
          color: ColorPalettes.backgroundLight,
          // header: BottomSheetTitleHeader(
          //   titleText: "Komentar",
          // ),
          content: Container(
            color: ColorPalettes.backgroundLight,
            width: double.maxFinite,
            child: _PostCommentForm(
              currentComment: currentComment,
            ),
          ),
        ),
      ],
    );
  }
}

class _PostCommentForm extends StatefulWidget {
  final String? currentComment;

  const _PostCommentForm({
    this.currentComment,
    Key? key,
  }) : super(key: key);

  @override
  State<_PostCommentForm> createState() => _PostCommentFormState();
}

class _PostCommentFormState extends State<_PostCommentForm> {
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    if (widget.currentComment != null) {
      commentController.text = widget.currentComment!;
    }

    super.initState();
  }

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
          const SizedBox(
            height: 40.0,
          ),
          TextFieldInput(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
            ),
            labelText: "Komentar",
            labelStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w700,
                ),
            hintText: "Masukkan komentar",
            maxLength: null,
            minLines: 5,
            controller: commentController,
            callback: (value) => print(
              "==> comment: $value",
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          CarbonRoundedButton(
            label: "Kirim",
            action: () => Navigator.of(context).pop(commentController.text),
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
