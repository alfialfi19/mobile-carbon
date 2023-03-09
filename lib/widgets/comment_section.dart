import 'package:flutter/material.dart';
import 'package:mobile_carbon/commons/commons.dart';

import '../models/models.dart';
import 'widgets.dart';

class CommentSection extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     AuthorItem(
        //       author: author,
        //       dateCreated: DateUtil.sanitizeDateTime(createdAt ?? "-"),
        //       authorTextColor: ColorPalettes.dark,
        //       dateTextColor: ColorPalettes.grayZill,
        //       dividerColor: ColorPalettes.line,
        //     ),
        //     Expanded(
        //       child: InkWell(
        //         onTap: () => optionsCallback?.call(),
        //         child: Container(
        //           alignment: Alignment.centerRight,
        //           width: double.maxFinite,
        //           child: const Icon(
        //             Icons.more_horiz_rounded,
        //             color: ColorPalettes.dots,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // Container(
        //   margin: const EdgeInsets.only(
        //     top: 5.0,
        //     bottom: 4.0,
        //   ),
        //   child: Text(
        //     comment ?? "-",
        //     style: Theme.of(context)
        //         .textTheme
        //         .caption
        //         ?.copyWith(
        //       color: ColorPalettes.dark,
        //       fontWeight: FontWeight.w400,
        //     ),
        //     textAlign: TextAlign.justify,
        //   ),
        // ),
        CommentItem(
          imgUrl: imgUrl,
          author: author,
          createdAt: createdAt,
          comment: comment,
          optionsCallback: optionsCallback,
        ),
        if (childComment != null && childComment!.isNotEmpty) ...[
          Container(
            margin: const EdgeInsets.only(
              bottom: 12.0,
            ),
            child: Text(
              "Sembunyikan komentar",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: childComment?.length,
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
                  imgUrl: childComment?[index].file,
                  author: childComment?[index].writerName,
                  createdAt: DateUtil.sanitizeDateTime(
                      childComment?[index].createdAt ?? "-"),
                  comment: childComment?[index].desc,
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
      crossAxisAlignment:
          isChildComment ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            AuthorItem(
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
