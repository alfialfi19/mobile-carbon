import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../widgets.dart';

class MainArticleItem extends StatelessWidget {
  final String? imageUrl;
  final String? articleLabel;
  final String? articleCategory;
  final String? authorName;
  final String? dateCreated;

  const MainArticleItem({
    Key? key,
    this.imageUrl,
    this.articleLabel,
    this.articleCategory,
    this.authorName,
    this.dateCreated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 330,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
              image: AssetImage(
                imageUrl ?? Images.dummyPlant,
              ),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                ColorPalettes.black.withOpacity(0.4),
                BlendMode.luminosity,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          left: 20.0,
          right: 20.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                dateCreated: dateCreated ?? "-",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
