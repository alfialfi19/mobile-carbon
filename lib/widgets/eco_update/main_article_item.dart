import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../widgets.dart';

class MainArticleItem extends StatelessWidget {
  final String? imageUrl;
  final String? articleLabel;
  final String? articleCategory;
  final String? authorName;
  final String? authorImg;
  final String? dateCreated;
  final VoidCallback? onTap;

  const MainArticleItem({
    Key? key,
    this.imageUrl,
    this.articleLabel,
    this.articleCategory,
    this.authorName,
    this.authorImg,
    this.dateCreated,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        height: 330.0,
        width: 310.0,
        margin: const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.srcOver,
                  ),
                )
              : DecorationImage(
                  image: const AssetImage(
                    Images.dummyPlant,
                  ),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.srcOver,
                  ),
                ),
        ),
        child: Container(
          padding: const EdgeInsets.only(
            bottom: 30.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (articleCategory != null)
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: ColorPalettes.white.withOpacity(0.2),
                  ),
                  child: Text(
                    "Tanamanku",
                    style: Theme.of(context).textTheme.overline?.copyWith(
                          color: ColorPalettes.backgroundZill,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              Text(
                articleLabel ?? "",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: 18.0,
                      color: ColorPalettes.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              AuthorItem(
                author: authorName ?? "-",
                imageUrl: authorImg,
                dateCreated: dateCreated ?? "-",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
