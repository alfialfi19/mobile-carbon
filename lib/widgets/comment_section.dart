import 'package:flutter/material.dart';
import 'package:mobile_carbon/commons/commons.dart';

import '../models/models.dart';
import 'widgets.dart';

class CommentSection extends StatefulWidget {
  final String? imgUrl;
  final String? author;
  final String? createdAt;
  final String? comment;
  final List<CommentsItem>? childComment;
  final VoidCallback? optionsCallback;

  const CommentSection({
    this.imgUrl,
    this.author,
    this.createdAt,
    this.comment,
    this.childComment,
    this.optionsCallback,
    Key? key,
  }) : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  bool isExpand = false;
  String hideCommentLabel = 'Sembunyikan komentar';
  String showCommentLabel = 'Lihat balasan lainnya';
  String label = "";

  @override
  void initState() {
    super.initState();

    label = "$showCommentLabel (${widget.childComment?.length})";
  }

  void _expandComment() {
    setState(() {
      isExpand = !isExpand;

      if (isExpand) {
        label = hideCommentLabel;
      } else {
        label = "$showCommentLabel (${widget.childComment?.length})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentItem(
          imgUrl: widget.imgUrl,
          author: widget.author,
          createdAt: widget.createdAt,
          comment: widget.comment,
          optionsCallback: widget.optionsCallback,
        ),
        if (widget.childComment != null && widget.childComment!.isNotEmpty) ...[
          InkWell(
            onTap: () => _expandComment(),
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 12.0,
              ),
              child: Text(
                label,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorPalettes.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
          if (isExpand)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.childComment?.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(left: 36.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: ColorPalettes.line,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: CommentItem(
                    isChildComment: true,
                    imgUrl: widget.childComment?[index].file,
                    author: widget.childComment?[index].writerName,
                    createdAt: DateUtil.sanitizeDateTime(
                        widget.childComment?[index].createdAt ?? "-"),
                    comment: widget.childComment?[index].desc,
                  ),
                );
              },
            ),
        ],
      ],
    );
  }
}

class CommentItem extends StatelessWidget {
  final String? imgUrl;
  final String? author;
  final String? createdAt;
  final String? comment;
  final VoidCallback? optionsCallback;
  final bool isChildComment;

  const CommentItem({
    this.isChildComment = false,
    this.imgUrl,
    this.author,
    this.createdAt,
    this.comment,
    this.optionsCallback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment:
      //     isChildComment ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AuthorItemComment(
              imageUrl: imgUrl,
              author: author,
              dateCreated: createdAt,
              authorTextColor: ColorPalettes.dark,
              dateTextColor: ColorPalettes.grayZill,
              dividerColor: ColorPalettes.line,
            ),
            if (optionsCallback != null)
              Expanded(
                child: InkWell(
                  onTap: () => optionsCallback?.call(),
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: double.maxFinite,
                    child: const Icon(
                      Icons.more_horiz_rounded,
                      color: ColorPalettes.dots,
                    ),
                  ),
                ),
              ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(
            top: 5.0,
            bottom: 4.0,
            left: isChildComment ? 30.0 : 0.0,
            right: isChildComment ? 4.0 : 0.0,
          ),
          child: Text(
            comment ?? "-",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w400,
                ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
