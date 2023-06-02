import 'package:flutter/material.dart';

import '../commons/commons.dart';

class AuthorItem extends StatelessWidget {
  final String? author;
  final String? dateCreated;
  final String? imageUrl;
  final Color? authorTextColor;
  final Color? dateTextColor;
  final Color? dividerColor;

  const AuthorItem({
    Key? key,
    this.author,
    this.dateCreated,
    this.imageUrl,
    this.authorTextColor,
    this.dateTextColor,
    this.dividerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(right: 8.0),
            height: 24.0,
            width: 24.0,
            child: imageUrl != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      imageUrl!,
                    ),
                  )
                : const CircleAvatar(
                    backgroundImage: AssetImage(
                      Images.dummyProfile,
                    ),
                  ),
          ),
        ),
        Expanded(
          flex: 3,
          // flex: 1,
          child: Text(
            author ?? "-",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: authorTextColor ?? ColorPalettes.white,
                  fontWeight: FontWeight.w700,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          height: 5.0,
          width: 5.0,
          decoration: BoxDecoration(
            color: dividerColor ?? ColorPalettes.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        Expanded(
          // flex: 1,
          flex: 2,
          child: Text(
            dateCreated ?? "-",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: dateTextColor ?? ColorPalettes.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ],
    );
  }
}

class AuthorItemComment extends StatelessWidget {
  final String? author;
  final String? dateCreated;
  final String? imageUrl;
  final Color? authorTextColor;
  final Color? dateTextColor;
  final Color? dividerColor;

  const AuthorItemComment({
    Key? key,
    this.author,
    this.dateCreated,
    this.imageUrl,
    this.authorTextColor,
    this.dateTextColor,
    this.dividerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        imageUrl != null
            ? Container(
                margin: const EdgeInsets.only(right: 8.0),
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl!),
                  ),
                  color: Colors.yellow,
                ),
              )
            : Container(
                margin: const EdgeInsets.only(right: 8.0),
                width: 24.0,
                height: 24.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(Images.dummyProfile),
                  ),
                  color: Colors.yellow,
                ),
              ),
        Text(
          author ?? "-",
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: authorTextColor ?? ColorPalettes.white,
                fontWeight: FontWeight.w700,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          height: 5.0,
          width: 5.0,
          decoration: BoxDecoration(
            color: dividerColor ?? ColorPalettes.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        Text(
          dateCreated ?? "-",
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: dateTextColor ?? ColorPalettes.white,
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
